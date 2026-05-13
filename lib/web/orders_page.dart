// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class OrdersPage extends StatefulWidget {
//   const OrdersPage({super.key});

//   @override
//   State<OrdersPage> createState() => _OrdersPageState();
// }

// class _OrdersPageState extends State<OrdersPage> {

//   final orders = FirebaseFirestore.instance.collection('orders');

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(title: Text("Orders")),
//       body: StreamBuilder(
//         stream: orders.snapshots(),
//         builder: (context, snapshot) {

//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           final docs = snapshot.data!.docs;

//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {

//               var data = docs[index];

//               return Card(
//                 margin: EdgeInsets.all(10),
//                 child: Padding(
//                   padding: EdgeInsets.all(10),
//                   child: Column(
//                     crossAxisAlignment: CrossAxisAlignment.start,
//                     children: [

//                       Text("Service: ${data['service']}"),
//                       Text("User: ${data['userEmail']}"),
//                       Text("Status: ${data['status']}"),

//                       Row(
//                         mainAxisAlignment: MainAxisAlignment.end,
//                         children: [

//                           TextButton(
//                             onPressed: () {
//                               FirebaseFirestore.instance
//                                   .collection('orders')
//                                   .doc(data.id)
//                                   .update({'status': 'rejected'});
//                             },
//                             child: Text("Reject", style: TextStyle(color: Colors.red)),
//                           ),

//                           ElevatedButton(
//                             onPressed: () {
//                               FirebaseFirestore.instance
//     .collection('orders')
//     .doc(data.id)
//     .update({'status': 'accepted'});
                              
//                             },
//                             child: Text("Accept"),
//                           ),

//                         ],
//                       )

//                     ],
//                   ),
//                 ),
//               );
//             },
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class OrdersPage extends StatefulWidget {
  const OrdersPage({super.key});

  @override
  State<OrdersPage> createState() => _OrdersPageState();
}

class _OrdersPageState extends State<OrdersPage> {
  // مرجع المجموعة مع ترتيب الطلبات حسب الأحدث
  final Query ordersQuery = FirebaseFirestore.instance
      .collection('orders')
      .orderBy('createdAt', descending: true); // تأكد من وجود حقل التاريخ في قاعدة البيانات

  // دالة لتحديث حالة الطلب
  Future<void> updateStatus(String docId, String newStatus) async {
    await FirebaseFirestore.instance
        .collection('orders')
        .doc(docId)
        .update({'status': newStatus});
  }

  // لون الحالة بناءً على النص
  Color getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'accepted': return Colors.green;
      case 'rejected': return Colors.red;
      case 'pending': return const Color(0xFFFFB545);
      default: return Colors.grey;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD),
      body: StreamBuilder<QuerySnapshot>(
        stream: ordersQuery.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator(color: Color(0xFF093A61)));
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return _buildEmptyOrders();
          }

          final docs = snapshot.data!.docs;

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: docs.length,
            itemBuilder: (context, index) {
              var data = docs[index].data() as Map<String, dynamic>;
              String docId = docs[index].id;
              String status = data['status'] ?? 'pending';

              return Container(
                margin: const EdgeInsets.only(bottom: 15),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withOpacity(0.05),
                      blurRadius: 10,
                      offset: const Offset(0, 4),
                    ),
                  ],
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // رأس البطاقة: الخدمة والحالة
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Row(
                            children: [
                              const Icon(Icons.receipt_long, color: Color(0xFF093A61)),
                              const SizedBox(width: 10),
                              Text(
                                data['service'] ?? 'No Service',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                  color: Color(0xFF093A61),
                                ),
                              ),
                            ],
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                            decoration: BoxDecoration(
                              color: getStatusColor(status).withOpacity(0.1),
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Text(
                              status.toUpperCase(),
                              style: TextStyle(
                                color: getStatusColor(status),
                                fontWeight: FontWeight.bold,
                                fontSize: 12,
                              ),
                            ),
                          ),
                        ],
                      ),
                      const Divider(height: 30),

                      // تفاصيل العميل والسعر
                      _buildInfoRow(Icons.person_outline, "User:", data['userEmail'] ?? 'N/A'),
                      const SizedBox(height: 10),
                      _buildInfoRow(Icons.price_check, "Price:", "\$${data['price'] ?? '0'}"),

                      const SizedBox(height: 20),

                      // أزرار التحكم (تظهر فقط إذا كان الطلب قيد الانتظار)
                      if (status == 'pending')
                        Row(
                          children: [
                            Expanded(
                              child: OutlinedButton(
                                style: OutlinedButton.styleFrom(
                                  side: const BorderSide(color: Colors.red),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                ),
                                onPressed: () => updateStatus(docId, 'rejected'),
                                child: const Text("Reject", style: TextStyle(color: Colors.red)),
                              ),
                            ),
                            const SizedBox(width: 15),
                            Expanded(
                              child: ElevatedButton(
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFF093A61),
                                  shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
                                  padding: const EdgeInsets.symmetric(vertical: 12),
                                  elevation: 0,
                                ),
                                onPressed: () => updateStatus(docId, 'accepted'),
                                child: const Text("Accept", style: TextStyle(color: Colors.white)),
                              ),
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

  // ويدجت مساعدة لعرض صف المعلومات
  Widget _buildInfoRow(IconData icon, String label, String value) {
    return Row(
      children: [
        Icon(icon, size: 18, color: Colors.grey),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(color: Colors.grey, fontSize: 14)),
        const SizedBox(width: 5),
        Expanded(
          child: Text(
            value,
            style: const TextStyle(fontWeight: FontWeight.w600, fontSize: 14),
            overflow: TextOverflow.ellipsis,
          ),
        ),
      ],
    );
  }

  // واجهة حالة لا توجد طلبات
  Widget _buildEmptyOrders() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.inbox_outlined, size: 80, color: Colors.grey[300]),
          const SizedBox(height: 15),
          const Text("No orders found", style: TextStyle(color: Colors.grey, fontSize: 18)),
        ],
      ),
    );
  }
}