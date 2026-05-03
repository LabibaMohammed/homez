import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditServicesPage extends StatefulWidget {
  const EditServicesPage({super.key});

  @override
  State<EditServicesPage> createState() => _EditServicesPageState();
}

class _EditServicesPageState extends State<EditServicesPage> {
  final CollectionReference services =
      FirebaseFirestore.instance.collection('services');

  // تحديث الخدمة
  void updateService(String docId, String name, String service, double price) {
    services.doc(docId).update({
      'name': name,
      'service': service,
      'price': price,
    });
  }

  // حذف خدمة (اختياري لكن مهم)
  void deleteService(String docId) {
    services.doc(docId).delete();
  }

  // نافذة التعديل
  void showEditDialog(String docId, Map data) {
    TextEditingController nameController =
        TextEditingController(text: data['name']);
    TextEditingController serviceController =
        TextEditingController(text: data['service']);
    TextEditingController priceController =
        TextEditingController(text: data['price'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          backgroundColor: const Color(0xFFF2F8FD),
          title: const Text("Edit Service"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: nameController,
                decoration: const InputDecoration(labelText: "Name"),
              ),
              TextField(
                controller: serviceController,
                decoration: const InputDecoration(labelText: "Service"),
              ),
              TextField(
                controller: priceController,
                decoration: const InputDecoration(labelText: "Price"),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel",style: TextStyle(color: Colors.grey),),
            ),
            TextButton(
              onPressed: () {
                deleteService(docId);
                Navigator.pop(context);
              },
              child: const Text(
                "Delete",
                style: TextStyle(color: Colors.red),
              ),
            ),
            ElevatedButton(
              onPressed: () {
                
                updateService(
                  docId,
                  nameController.text,
                  serviceController.text,
                  double.tryParse(priceController.text) ?? 0,
                );
                Navigator.pop(context);
              },
               style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFFFB545),
                      ),
              child: const Text("Save",style: TextStyle(color: Colors.white),),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
     backgroundColor: Colors.white,
      body: StreamBuilder(
        stream: services.snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("No services found"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index];

              return Card(
                
                color: const Color(0xFFF2F8FD),
                margin: const EdgeInsets.all(10),
                child: ListTile(
                  title: Text(data['name'] ?? ""),
                  subtitle: Text(data['service'] ?? ""),
                  trailing: Text("${data['price'] ?? 0}"),
                  onTap: () {
                    showEditDialog( data.id,
  data.data() as Map<String, dynamic>,);
                  },
                ),
              );
            },
          );
        },
      ),
    );
  }
}