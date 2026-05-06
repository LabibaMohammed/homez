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

  Future<void> uploadExcel() async {
    try {
      // اختيار ملف Excel
      FilePickerResult? result = await FilePicker.platform.pickFiles(
        type: FileType.custom,
        allowedExtensions: ['xlsx'],
        withData: true
      );

      if (result == null) return;

      Uint8List bytes = result.files.single.bytes!;

      // حل مهم للويب: لو bytes null
      if (bytes == null) {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Failed to read file bytes")),
        );
        return;
      }

      var excel = Excel.decodeBytes(bytes);

      for (var tableName in excel.tables.keys) {
        var sheet = excel.tables[tableName];

        if (sheet == null) continue;

        for (var row in sheet.rows.skip(1)) {

          // حماية من null / صفوف ناقصة
          String name = row.isNotEmpty && row[0] != null
              ? row[0]!.value.toString()
              : "";

          String service = row.length > 1 && row[1] != null
              ? row[1]!.value.toString()
              : "";

          double price = row.length > 2 && row[2] != null
              ? double.tryParse(row[2]!.value.toString()) ?? 0
              : 0;
              String image = row.length > 3 ? row[3]!.value.toString() : ""; 

          if (name.isEmpty) continue;

          await FirebaseFirestore.instance.collection('services').add({
            "name": name,
            "service": service,
            "price": price,
            "image": image,
          });
        }
      }

      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Excel uploaded successfully 🚀")),
      );

    } catch (e) {
      // مهم جدًا لعرض الخطأ الحقيقي
      debugPrint("UPLOAD ERROR: $e");

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e")),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     backgroundColor: Colors.white,

      body: Padding(
        padding: const EdgeInsets.only(left: 80),
        child: Column(
          
          children: [

          const SizedBox(height: 80),

          ElevatedButton.icon(
            onPressed: uploadExcel,
            icon: const Icon(Icons.upload_file, color: Colors.white),
            label: const Text("Upload Excel",style: TextStyle(color: Colors.white),),
            style: ElevatedButton.styleFrom(
              backgroundColor: const Color(0xFFFFB545),
            ),
          ),

          const SizedBox(height: 20),

        //   Expanded(
        //     child: StreamBuilder(
        //       stream: FirebaseFirestore.instance
        //           .collection('services')
        //           .snapshots(),

        //       builder: (context, snapshot) {

        //         if (snapshot.hasError) {
        //           return Center(
        //             child: Text("Error: ${snapshot.error}"),
        //           );
        //         }

        //         if (!snapshot.hasData) {
        //           return const Center(
        //             child: CircularProgressIndicator(),
        //           );
        //         }

        //         final docs = snapshot.data!.docs;

        //         if (docs.isEmpty) {
        //           return const Center(child: Text("No data found"));
        //         }

        //         return ListView.builder(
        //           itemCount: docs.length,
        //           itemBuilder: (context, index) {
        //             final data = docs[index];

        //             return Card(
        //               margin: const EdgeInsets.all(10),
        //               child: ListTile(
        //                 title: Text(data['name'] ?? ""),
        //                 subtitle: Text(data['provider'] ?? ""),
        //                 trailing: Text("${data['price'] ?? 0}"),
        //               ),
        //             );
        //           },
        //         );
        //       },
        //     ),
        //   ),
         ],
      ),
      ),
    );
  }
}