import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {

  final orders = FirebaseFirestore.instance.collection('orders');

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Orders")),
      body: StreamBuilder(
        stream: orders.snapshots(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {

              var data = docs[index];

              return Card(
                margin: EdgeInsets.all(10),
                child: Padding(
                  padding: EdgeInsets.all(10),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [

                      Text("Service: ${data['service']}"),
                      Text("User: ${data['userEmail']}"),
                      Text("Status: ${data['status']}"),

                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [

                          TextButton(
                            onPressed: () {
                              FirebaseFirestore.instance
                                  .collection('orders')
                                  .doc(data.id)
                                  .update({'status': 'rejected'});
                            },
                            child: Text("Reject", style: TextStyle(color: Colors.red)),
                          ),

                          ElevatedButton(
                            onPressed: () {
                              FirebaseFirestore.instance
    .collection('orders')
    .doc(data.id)
    .update({'status': 'accepted'});
                              
                            },
                            child: Text("Accept"),
                          ),

                        ],
                      )

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