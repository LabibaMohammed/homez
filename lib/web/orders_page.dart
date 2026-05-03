import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';


class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  final CollectionReference orders =
      FirebaseFirestore.instance.collection('orders');

  void deleteOrder(String docId) {
    orders.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      
     backgroundColor: Colors.white,

      body: StreamBuilder(
        stream: orders.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) {
            return Center(child: Text("Error: ${snapshot.error}"));
          }

          if (!snapshot.hasData) {
            return const Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return const Center(child: Text("No orders yet"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index];

              return Card(
                margin: const EdgeInsets.all(10),
                child: Padding(
                  padding: const EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Name: ${data['name']}"),
                      Text("Service: ${data['service']}"),
                      Text("Price: ${data['price']}"),

                      const SizedBox(height: 10),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          TextButton(
                            onPressed: () {
                              // ❌ رفض الطلب
                              deleteOrder(data.id);
                            },
                            child: const Text(
                              "Reject",
                              style: TextStyle(color: Colors.red),
                            ),
                          ),

                          const SizedBox(width: 10),

                          ElevatedButton(
                            onPressed: () {
  // generateExcelWeb(
  //   data['name'],
  //   data['service'],
  //   (data['price'] as num).toDouble(),كانت تابعة لصفحة الفاتورة ولكن الاستاذة لغتها
  // );
},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.green,
                            ),
                            child: const Text("Accept"),
                          ),
                        ],
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}