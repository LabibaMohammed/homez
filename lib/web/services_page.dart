import 'dart:typed_data';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:excel/excel.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';

class ServicesPage extends StatefulWidget {
  const ServicesPage({super.key});

  @override
  State<ServicesPage> createState() => _ServicesPageState();
}

class _ServicesPageState extends State<ServicesPage> {
  bool isUploading = false;

  Future<void> uploadExcel() async {
    try {
      FilePickerResult? result = await FilePicker.platform.pickFiles(
          type: FileType.custom,
          allowedExtensions: ['xlsx'],
          withData: true);

      if (result == null) return;

      setState(() => isUploading = true);

      Uint8List bytes = result.files.single.bytes!;
      var excel = Excel.decodeBytes(bytes);

      int totalUploaded = 0;

      for (var tableName in excel.tables.keys) {
        var sheet = excel.tables[tableName];
        if (sheet == null) continue;

        // نقسم البيانات إلى مجموعات (Batches) كل مجموعة 500 سجل بحد أقصى
        var batch = FirebaseFirestore.instance.batch();
        int counter = 0;

        // تخطي العنوان (الصف الأول)
        for (var row in sheet.rows.skip(1)) {
          if (row.isEmpty || row[0] == null) continue;

          // استخراج القيم بأمان مع التأكد من النوع
          String name = row[0]?.value?.toString() ?? "";
          String service = (row.length > 1) ? row[1]?.value?.toString() ?? "" : "";
          
          // معالجة السعر للتأكد من أنه رقم
          var priceValue = (row.length > 2) ? row[2]?.value : 0;
          double price = double.tryParse(priceValue.toString()) ?? 0.0;
          
          String image = (row.length > 3) ? row[3]?.value?.toString() ?? "" : "";

          if (name.trim().isEmpty) continue;

          var docRef = FirebaseFirestore.instance.collection('services').doc();
          batch.set(docRef, {
            "name": name,
            "service": service,
            "price": price,
            "image": image,
            "createdAt": FieldValue.serverTimestamp(),
          });

          counter++;
          totalUploaded++;

          // إذا وصلنا لـ 500 عملية، نقوم بحفظ الدفعة ونبدأ دفعة جديدة
          if (counter == 500) {
            await batch.commit();
            batch = FirebaseFirestore.instance.batch();
            counter = 0;
          }
        }

        // حفظ آخر مجموعة إذا كانت أقل من 500
        if (counter > 0) {
          await batch.commit();
        }
      }

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text("Success! $totalUploaded services uploaded. 🚀"),
          backgroundColor: Colors.green,
        ),
      );
    } catch (e) {
      debugPrint("Excel Upload Error: $e");
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    } finally {
      if (mounted) setState(() => isUploading = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    // ... (نفس تصميم الواجهة السابق يظل ممتازاً)
    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Container(
          constraints: const BoxConstraints(maxWidth: 600),
          padding: const EdgeInsets.all(40),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(Icons.cloud_upload_outlined, size: 80, color: const Color(0xFF093A61).withOpacity(0.2)),
              const SizedBox(height: 20),
              const Text(
                "Upload Services List",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF093A61)),
              ),
              const SizedBox(height: 30),
              
              // بطاقة التعليمات
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: const Color(0xFFF2F8FD),
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Column(
                  children: [
                    _formatRow("A", "Name"),
                    _formatRow("B", "Service Type"),
                    _formatRow("C", "Price"),
                    _formatRow("D", "Image Link"),
                  ],
                ),
              ),
              
              const SizedBox(height: 40),
              
              isUploading 
                ? const CircularProgressIndicator(color: Color(0xFFFFB545))
                : ElevatedButton.icon(
                    onPressed: uploadExcel,
                    icon: const Icon(Icons.add_to_photos, color: Colors.white),
                    label: const Text("Select Excel File", style: TextStyle(color: Colors.white)),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB545),
                      minimumSize: const Size(200, 50),
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                    ),
                  ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _formatRow(String col, String desc) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4),
      child: Row(
        children: [
          Text("Column $col:", style: const TextStyle(fontWeight: FontWeight.bold)),
          const SizedBox(width: 10),
          Text(desc),
        ],
      ),
    );
  }
}