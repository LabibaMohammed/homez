// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Request extends StatefulWidget {
//   final List cartItems;
//   final String email;

//   const Request({super.key, required this.cartItems, required this.email});

//   @override
//   State<Request> createState() => _RequestState();
// }

// class _RequestState extends State<Request> {

//   final user = FirebaseAuth.instance.currentUser;

//   Future<void> confirmOrder() async {
//     for (var item in widget.cartItems) {

//       var docRef = FirebaseFirestore.instance.collection('orders').doc();

//       await docRef.set({
//         'id': docRef.id,
//         'service': item['service'],
//         'name': item['name'],
//         'price': item['price'],
//         'status': 'pending',
//         'userEmail': FirebaseAuth.instance.currentUser?.email,
//       });
//     }

//     ScaffoldMessenger.of(context).showSnackBar(
//       SnackBar(content: Text("Order Sent ✔")),
//     );

//     setState(() {
//       widget.cartItems.clear();
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Request Cart")),
//       body: Column(
//         children: [

//           Expanded(
//             child: ListView.builder(
//               itemCount: widget.cartItems.length,
//               itemBuilder: (context, index) {
//                 final item = widget.cartItems[index];

//                 return ListTile(
//                   title: Text(item['service']),
//                   subtitle: Text(item['name']),
//                   trailing: Text("${item['price']}"),
//                 );
//               },
//             ),
//           ),

//           ElevatedButton(
//             onPressed: confirmOrder,
//             child: Text("Confirm Order"),
//           ),

//           SizedBox(height: 20),
//         ],
//       ),
//     );
//   }
// }
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
  bool isLoading = false; // لحالة تحميل الزر

  // حساب المجموع الكلي
  double get totalPrice {
    return widget.cartItems.fold(0, (sum, item) => sum + (double.tryParse(item['price'].toString()) ?? 0.0));
  }

  Future<void> confirmOrder() async {
    if (widget.cartItems.isEmpty) return;

    setState(() => isLoading = true);

    try {
      final batch = FirebaseFirestore.instance.batch();
      final collection = FirebaseFirestore.instance.collection('orders');

      for (var item in widget.cartItems) {
        var docRef = collection.doc();
        batch.set(docRef, {
          'orderId': docRef.id,
          'service': item['service'],
          'name': item['name'],
          'price': item['price'],
          'status': 'pending',
          'userEmail': FirebaseAuth.instance.currentUser?.email ?? widget.email,
          'createdAt': FieldValue.serverTimestamp(),
        });
      }

      await batch.commit();

      if (!mounted) return;
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Order Sent Successfully! ✔"),
          backgroundColor: Colors.green,
        ),
      );

      setState(() {
        widget.cartItems.clear();
        isLoading = false;
      });
      
      Navigator.pop(context); // العودة بعد النجاح

    } catch (e) {
      setState(() => isLoading = false);
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Error: $e"), backgroundColor: Colors.red),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD), // نفس خلفية اللوقن
      appBar: AppBar(
        title: const Text("Order Summary", style: TextStyle(fontWeight: FontWeight.bold, color: Colors.white)),
        backgroundColor: const Color(0xFF093A61),
        centerTitle: true,
        elevation: 0,
      ),
      body: widget.cartItems.isEmpty
          ? _buildEmptyState()
          : Column(
              children: [
                Expanded(
                  child: ListView.builder(
                    padding: const EdgeInsets.all(15),
                    itemCount: widget.cartItems.length,
                    itemBuilder: (context, index) {
                      final item = widget.cartItems[index];
                      return _buildCartItem(item, index);
                    },
                  ),
                ),
                _buildBottomSummary(),
              ],
            ),
    );
  }

  // واجهة السلة الفارغة
  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.shopping_cart_outlined, size: 100, color: Colors.grey[300]),
          const SizedBox(height: 20),
          const Text("Your cart is empty", style: TextStyle(fontSize: 18, color: Colors.grey)),
        ],
      ),
    );
  }

  // بطاقة العنصر في السلة
  Widget _buildCartItem(Map item, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 15),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.05), blurRadius: 10, offset: const Offset(0, 4)),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
        leading: CircleAvatar(
          backgroundColor: const Color(0xFFF2F8FD),
          child: Icon(Icons.build_circle, color: const Color(0xFF093A61)),
        ),
        title: Text(
          item['service'],
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFF093A61)),
        ),
        subtitle: Text(item['name'], style: TextStyle(color: Colors.grey[600])),
        trailing: Text(
          "\$${item['price']}",
          style: const TextStyle(fontWeight: FontWeight.bold, color: Color(0xFFFFB545), fontSize: 16),
        ),
      ),
    );
  }

  // منطقة ملخص الفاتورة والزر
  Widget _buildBottomSummary() {
    return Container(
      padding: const EdgeInsets.all(25),
      decoration: const BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.vertical(top: Radius.circular(30)),
        boxShadow: [BoxShadow(color: Colors.black12, blurRadius: 10)],
      ),
      child: SafeArea(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text("Total Amount", style: TextStyle(fontSize: 18, fontWeight: FontWeight.w500)),
                Text(
                  "\$${totalPrice.toStringAsFixed(2)}",
                  style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold, color: Color(0xFF093A61)),
                ),
              ],
            ),
            const SizedBox(height: 20),
            SizedBox(
              width: double.infinity,
              height: 55,
              child: ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB545), // لون برتقالي لتمييز الفعل
                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                  elevation: 0,
                ),
                onPressed: isLoading ? null : confirmOrder,
                child: isLoading
                    ? const CircularProgressIndicator(color: Colors.white)
                    : const Text(
                        "Confirm & Send Order",
                        style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
                      ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}