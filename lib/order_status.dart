import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {

    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      appBar: AppBar(title: Text("My Orders")),
      body: StreamBuilder(
        stream: FirebaseFirestore.instance
            .collection('orders')
            .where('userEmail', isEqualTo: user?.email)
            .snapshots(),
        builder: (context, snapshot) {

          if (!snapshot.hasData) {
            return Center(child: CircularProgressIndicator());
          }

          final docs = snapshot.data!.docs;

          if (docs.isEmpty) {
            return Center(child: Text("No orders yet"));
          }

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {

              var data = docs[index];

              return Card(
                margin: EdgeInsets.all(10),
                child: ListTile(
                  title: Text(data['service']),
                  subtitle: Text("Status: ${data['status']}"),

                  trailing: Icon(
                    data['status'] == 'accepted'
                        ? Icons.check_circle
                        : data['status'] == 'rejected'
                            ? Icons.cancel
                            : Icons.hourglass_bottom,
                    color: data['status'] == 'accepted'
                        ? Colors.green
                        : data['status'] == 'rejected'
                            ? Colors.red
                            : Colors.orange,
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