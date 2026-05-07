import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Request extends StatefulWidget {
  final List cartItems;
  final String email;

  const Request({super.key, required this.cartItems, required this.email});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {

  final user = FirebaseAuth.instance.currentUser;

  Future<void> confirmOrder() async {
    for (var item in widget.cartItems) {

      var docRef = FirebaseFirestore.instance.collection('orders').doc();

      await docRef.set({
        'id': docRef.id,
        'service': item['service'],
        'name': item['name'],
        'price': item['price'],
        'status': 'pending',
        'userEmail': FirebaseAuth.instance.currentUser?.email,
      });
    }

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text("Order Sent ✔")),
    );

    setState(() {
      widget.cartItems.clear();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Request Cart")),
      body: Column(
        children: [

          Expanded(
            child: ListView.builder(
              itemCount: widget.cartItems.length,
              itemBuilder: (context, index) {
                final item = widget.cartItems[index];

                return ListTile(
                  title: Text(item['service']),
                  subtitle: Text(item['name']),
                  trailing: Text("${item['price']}"),
                );
              },
            ),
          ),

          ElevatedButton(
            onPressed: confirmOrder,
            child: Text("Confirm Order"),
          ),

          SizedBox(height: 20),
        ],
      ),
    );
  }
}