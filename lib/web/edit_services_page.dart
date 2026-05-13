// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class EditServicesPage extends StatefulWidget {
//   const EditServicesPage({super.key});

//   @override
//   State<EditServicesPage> createState() => _EditServicesPageState();
// }

// class _EditServicesPageState extends State<EditServicesPage> {
//   final CollectionReference services =
//       FirebaseFirestore.instance.collection('services');

//   // تحديث الخدمة
//   void updateService(String docId, String name, String service, double price) {
//     services.doc(docId).update({
//       'name': name,
//       'service': service,
//       'price': price,
//     });
//   }

//   // حذف خدمة (اختياري لكن مهم)
//   void deleteService(String docId) {
//     services.doc(docId).delete();
//   }

//   // نافذة التعديل
//   void showEditDialog(String docId, Map data) {
//     TextEditingController nameController =
//         TextEditingController(text: data['name']);
//     TextEditingController serviceController =
//         TextEditingController(text: data['service']);
//     TextEditingController priceController =
//         TextEditingController(text: data['price'].toString());

//     showDialog(
//       context: context,
//       builder: (context) {
//         return AlertDialog(
//           backgroundColor: const Color(0xFFF2F8FD),
//           title: const Text("Edit Service"),
//           content: Column(
//             mainAxisSize: MainAxisSize.min,
//             children: [
//               TextField(
//                 controller: nameController,
//                 decoration: const InputDecoration(labelText: "Name"),
//               ),
//               TextField(
//                 controller: serviceController,
//                 decoration: const InputDecoration(labelText: "Service"),
//               ),
//               TextField(
//                 controller: priceController,
//                 decoration: const InputDecoration(labelText: "Price"),
//                 keyboardType: TextInputType.number,
//               ),
//             ],
//           ),
//           actions: [
//             TextButton(
//               onPressed: () => Navigator.pop(context),
//               child: const Text("Cancel",style: TextStyle(color: Colors.grey),),
//             ),
//             TextButton(
//               onPressed: () {
//                 deleteService(docId);
//                 Navigator.pop(context);
//               },
//               child: const Text(
//                 "Delete",
//                 style: TextStyle(color: Colors.red),
//               ),
//             ),
//             ElevatedButton(
//               onPressed: () {
                
//                 updateService(
//                   docId,
//                   nameController.text,
//                   serviceController.text,
//                   double.tryParse(priceController.text) ?? 0,
//                 );
//                 Navigator.pop(context);
//               },
//                style: ElevatedButton.styleFrom(
//                         backgroundColor: const Color(0xFFFFB545),
//                       ),
//               child: const Text("Save",style: TextStyle(color: Colors.white),),
//             ),
//           ],
//         );
//       },
//     );
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//      backgroundColor: Colors.white,
//       body: StreamBuilder(
//         stream: services.snapshots(),
//         builder: (context, snapshot) {
//           if (!snapshot.hasData) {
//             return const Center(child: CircularProgressIndicator());
//           }

//           final docs = snapshot.data!.docs;

//           if (docs.isEmpty) {
//             return const Center(child: Text("No services found"));
//           }

//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {
//               var data = docs[index];

//               return Card(
                
//                 color: const Color(0xFFF2F8FD),
//                 margin: const EdgeInsets.all(10),
//                 child: ListTile(
//                   title: Text(data['name'] ?? ""),
//                   subtitle: Text(data['service'] ?? ""),
//                   trailing: Text("${data['price'] ?? 0}"),
//                   onTap: () {
//                     showEditDialog( data.id,
//   data.data() as Map<String, dynamic>,);
//                   },
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class EditServicesPage extends StatefulWidget {
  const EditServicesPage({super.key});

  @override
  State<EditServicesPage> createState() => _EditServicesPageState();
}

class _EditServicesPageState extends State<EditServicesPage> {
  // المرجع لمجموعة الخدمات في فيربايس
  final CollectionReference services =
      FirebaseFirestore.instance.collection('services');

  // دالة حذف الخدمة
  void deleteService(String docId) {
    services.doc(docId).delete();
  }

  // نافذة التعديل - باللغة الإنجليزية وتنسيق متناسق
  void showEditDialog(String docId, Map data) {
    TextEditingController nameController = TextEditingController(text: data['name']);
    TextEditingController serviceController = TextEditingController(text: data['service']);
    TextEditingController priceController = TextEditingController(text: data['price'].toString());

    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
          backgroundColor: Colors.white,
          title: const Text(
            "Edit Service Info",
            style: TextStyle(
              color: Color(0xFF093A61), 
              fontWeight: FontWeight.bold,
            ),
          ),
          content: SingleChildScrollView(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                // حقل اسم المزود
                TextField(
                  controller: nameController,
                  cursorColor: const Color(0xFF093A61),
                  decoration: const InputDecoration(
                    labelText: "Provider Name",
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFFB545)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // حقل نوع الخدمة
                TextField(
                  controller: serviceController,
                  cursorColor: const Color(0xFF093A61),
                  decoration: const InputDecoration(
                    labelText: "Service Type",
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFFB545)),
                    ),
                  ),
                ),
                const SizedBox(height: 15),
                // حقل السعر
                TextField(
                  controller: priceController,
                  keyboardType: TextInputType.number,
                  cursorColor: const Color(0xFF093A61),
                  decoration: const InputDecoration(
                    labelText: "Price",
                    labelStyle: TextStyle(color: Colors.grey),
                    focusedBorder: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFFFFB545)),
                    ),
                  ),
                ),
              ],
            ),
          ),
          actionsPadding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          actions: [
            // زر الحذف
            TextButton(
              onPressed: () {
                deleteService(docId);
                Navigator.pop(context);
              },
              child: const Text("Delete", style: TextStyle(color: Colors.redAccent)),
            ),
            // زر الإغلاق
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text("Cancel", style: TextStyle(color: Colors.grey)),
            ),
            // زر الحفظ
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF093A61),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
                elevation: 0,
              ),
              onPressed: () {
                services.doc(docId).update({
                  'name': nameController.text,
                  'service': serviceController.text,
                  'price': double.tryParse(priceController.text) ?? 0,
                });
                Navigator.pop(context);
              },
              child: const Text("Save Changes", style: TextStyle(color: Colors.white)),
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
      body: StreamBuilder<QuerySnapshot>(
        stream: services.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF093A61)));
          }
          
          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return const Center(
              child: Text("No services found.", style: TextStyle(color: Colors.grey)),
            );
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;
              var docId = docs[index].id;

              return Card(
                elevation: 0,
                color: const Color(0xFFF2F8FD),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                margin: const EdgeInsets.only(bottom: 12),
                child: ListTile(
                  contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
                  leading: const CircleAvatar(
                    backgroundColor: Colors.white,
                    child: Icon(Icons.build_rounded, color: Color(0xFF093A61), size: 20),
                  ),
                  title: Text(
                    data['name'] ?? "No Name",
                    style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF093A61)),
                  ),
                  subtitle: Text(
                    data['service'] ?? "No Service",
                    style: TextStyle(color: Colors.blueGrey[600]),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Text(
                        "${data['price']} \$",
                        style: const TextStyle(
                          color: Color(0xFF093A61),
                          fontWeight: FontWeight.bold,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(width: 12),
                      const Icon(Icons.edit_note_rounded, color: Color(0xFFFFB545)),
                    ],
                  ),
                  onTap: () => showEditDialog(docId, data),
                ),
              );
            },
          );
        },
      ),
    );
  }
}