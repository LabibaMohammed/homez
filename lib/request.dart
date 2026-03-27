import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:excel/excel.dart';
import 'dart:io';
import 'package:path_provider/path_provider.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  String? selectedService;
  String? selectedProvider;

  final descriptionController = TextEditingController();
  final dateController = TextEditingController();
  final timeController = TextEditingController();

  Future<void> submitRequest() async {
    if (selectedService == null ||
        selectedProvider == null ||
        descriptionController.text.isEmpty ||
        dateController.text.isEmpty ||
        timeController.text.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Please fill all fields')),
      );
      return;
    }

    // 🔥 1. حفظ البيانات في Firestore
    await FirebaseFirestore.instance.collection('requests').add({
      'serviceType': selectedService,
      'description': descriptionController.text,
      'date': dateController.text,
      'time': timeController.text,
      'provider': selectedProvider,
      'createdAt': Timestamp.now(),
    });

    // 📊 2. جلب جميع الطلبات من Firebase
    QuerySnapshot snapshot =
        await FirebaseFirestore.instance.collection('requests').get();

    // 📄 3. إنشاء ملف Excel
    var excel = Excel.createExcel();
    Sheet sheet = excel['Requests'];

  sheet.appendRow([
  TextCellValue('Service'),
  TextCellValue('Description'),
  TextCellValue('Date'),
  TextCellValue('Time'),
  TextCellValue('Provider'),
]);

    for (var doc in snapshot.docs) {
  sheet.appendRow([
    TextCellValue(doc['serviceType'].toString()),
    TextCellValue(doc['description'].toString()),
    TextCellValue(doc['date'].toString()),
    TextCellValue(doc['time'].toString()),
    TextCellValue(doc['provider'].toString()),
  ]);
}

    final directory = await getExternalStorageDirectory();
final file = File('${directory!.path}/requests.xlsx');

await file.writeAsBytes(excel.encode()!);

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text('Request saved & Excel updated')),
    );

    descriptionController.clear();
    dateController.clear();
    timeController.clear();
    setState(() {
      selectedService = null;
      selectedProvider = null;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 60),
                const Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Request Service',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF093A61),
                    ),
                  ),
                ),
                const SizedBox(height: 30),

                /// Service Type
                const Text('Service Type',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF093A61),
                        fontWeight: FontWeight.w500)),
                DropdownButton<String>(
                  value: selectedService,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(
                        value: 'Electrical', child: Text('Electrical')),
                    DropdownMenuItem(
                        value: 'Plumbing', child: Text('Plumbing')),
                    DropdownMenuItem(
                        value: 'Cleaning', child: Text('Cleaning')),
                    DropdownMenuItem(
                        value: 'AC Repair', child: Text('AC Repair')),
                    DropdownMenuItem(
                        value: 'Delivery', child: Text('Delivery')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedService = value;
                    });
                  },
                ),

                const SizedBox(height: 20),

                /// Description
                const Text('Description',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF093A61),
                        fontWeight: FontWeight.w500)),
                TextField(
                  controller: descriptionController,
                  maxLines: 3,
                  decoration: InputDecoration(
                    hintText: 'Describe the work',
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.white),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Color(0xFF093A61)),
                    ),
                  ),
                ),

                const SizedBox(height: 20),

                /// Appointment
                const Text('Appointment',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF093A61),
                        fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        controller: dateController,
                        decoration: InputDecoration(
                          hintText: 'Date',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color(0xFF093A61)),
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        controller: timeController,
                        decoration: InputDecoration(
                          hintText: 'Time',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide:
                                const BorderSide(color: Colors.white),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                            borderSide: const BorderSide(
                                color: Color(0xFF093A61)),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 20),

                /// Provider
                const Text('Service Provider',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF093A61),
                        fontWeight: FontWeight.w500)),
                DropdownButton<String>(
                  value: selectedProvider,
                  isExpanded: true,
                  items: const [
                    DropdownMenuItem(value: 'John', child: Text('John')),
                    DropdownMenuItem(value: 'Sarah', child: Text('Sarah')),
                    DropdownMenuItem(value: 'Ali', child: Text('Ali')),
                  ],
                  onChanged: (value) {
                    setState(() {
                      selectedProvider = value;
                    });
                  },
                ),

                const SizedBox(height: 30),

                /// Submit Button
                Center(
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB545),
                      padding:
                          const EdgeInsets.symmetric(horizontal: 60),
                    ),
                    onPressed: submitRequest,
                    child: const Text(
                      'Submit',
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}