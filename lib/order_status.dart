// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class OrderStatus extends StatelessWidget {
//   const OrderStatus({super.key});

//   @override
//   Widget build(BuildContext context) {

//     final user = FirebaseAuth.instance.currentUser;

//     return Scaffold(
//       appBar: AppBar(title: Text("My Orders")),
//       body: StreamBuilder(
//         stream: FirebaseFirestore.instance
//             .collection('orders')
//             .where('userEmail', isEqualTo: user?.email)
//             .snapshots(),
//         builder: (context, snapshot) {

//           if (!snapshot.hasData) {
//             return Center(child: CircularProgressIndicator());
//           }

//           final docs = snapshot.data!.docs;

//           if (docs.isEmpty) {
//             return Center(child: Text("No orders yet"));
//           }

//           return ListView.builder(
//             itemCount: docs.length,
//             itemBuilder: (context, index) {

//               var data = docs[index];

//               return Card(
//                 margin: EdgeInsets.all(10),
//                 child: ListTile(
//                   title: Text(data['service']),
//                   subtitle: Text("Status: ${data['status']}"),

//                   trailing: Icon(
//                     data['status'] == 'accepted'
//                         ? Icons.check_circle
//                         : data['status'] == 'rejected'
//                             ? Icons.cancel
//                             : Icons.hourglass_bottom,
//                     color: data['status'] == 'accepted'
//                         ? Colors.green
//                         : data['status'] == 'rejected'
//                             ? Colors.red
//                             : Colors.orange,
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
import 'package:firebase_auth/firebase_auth.dart';

class OrderStatus extends StatelessWidget {
  const OrderStatus({super.key});

  @override
  Widget build(BuildContext context) {
    final user = FirebaseAuth.instance.currentUser;

    return Scaffold(
      // لون الخلفية الموحد للتطبيق
      backgroundColor: const Color(0xFFF2F8FD),
      body: SafeArea(
        child: Column(
          children: [
            // العنوان بنفس تنسيق صفحة البحث (بدون AppBar)
            const SizedBox(height: 60),
            const Text(
              'My Orders',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF093A61),
              ),
            ),
            const SizedBox(height: 30),

            // مراقبة البيانات من Firestore
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: FirebaseFirestore.instance
                    .collection('orders')
                    .where('userEmail', isEqualTo: user?.email)
                    .snapshots(),
                builder: (context, snapshot) {
                  // حالة التحميل
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(color: Color(0xFF093A61)),
                    );
                  }

                  // حالة وجود خطأ في الاتصال
                  if (snapshot.hasError) {
                    return const Center(child: Text("Something went wrong"));
                  }

                  // حالة عدم وجود طلبات
                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Icon(Icons.assignment_late_outlined, size: 80, color: Colors.grey[300]),
                          const SizedBox(height: 15),
                          Text(
                            "No orders found yet",
                            style: TextStyle(color: Colors.grey[600], fontSize: 16),
                          ),
                        ],
                      ),
                    );
                  }

                  final docs = snapshot.data!.docs;

                  return ListView.builder(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                    itemCount: docs.length,
                    itemBuilder: (context, index) {
                      // تحويل الوثيقة إلى Map بشكل آمن
                      final data = docs[index].data() as Map<String, dynamic>;
                      final String serviceName = data['service']?.toString() ?? 'Service';
                      final String status = (data['status']?.toString() ?? 'pending').toLowerCase();
                      final String price = data['price']?.toString() ?? '0';

                      // تحديد الألوان بناءً على الحالة
                      Color statusColor;
                      if (status == 'accepted') {
                        statusColor = Colors.green;
                      } else if (status == 'rejected') {
                        statusColor = Colors.redAccent;
                      } else {
                        statusColor = Colors.orange;
                      }

                      return Container(
                        margin: const EdgeInsets.only(bottom: 16),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(25),
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.03),
                              blurRadius: 10,
                              offset: const Offset(0, 4),
                            ),
                          ],
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(16),
                          child: Row(
                            children: [
                              // أيقونة الخدمة بشكل دائري
                              Container(
                                padding: const EdgeInsets.all(12),
                                decoration: const BoxDecoration(
                                  color: Color(0xFFF2F8FD),
                                  shape: BoxShape.circle,
                                ),
                                child: Icon(
                                  _getServiceIcon(serviceName),
                                  color: const Color(0xFF093A61),
                                  size: 28,
                                ),
                              ),
                              const SizedBox(width: 15),
                              // تفاصيل الخدمة والحالة
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      serviceName,
                                      style: const TextStyle(
                                        fontWeight: FontWeight.bold,
                                        fontSize: 17,
                                        color: Color(0xFF093A61),
                                      ),
                                    ),
                                    const SizedBox(height: 6),
                                    // بطاقة صغيرة لحالة الطلب
                                    Container(
                                      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
                                      decoration: BoxDecoration(
                                        color: statusColor.withOpacity(0.1),
                                        borderRadius: BorderRadius.circular(10),
                                      ),
                                      child: Text(
                                        status.toUpperCase(),
                                        style: TextStyle(
                                          color: statusColor,
                                          fontSize: 10,
                                          fontWeight: FontWeight.bold,
                                          letterSpacing: 0.5,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              // عرض السعر
                              Text(
                                "\$$price",
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFB545),
                                  fontSize: 18,
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  // وظيفة لتحديد الأيقونة المناسبة
  IconData _getServiceIcon(String service) {
    switch (service.toLowerCase()) {
      case 'cleaning': return Icons.cleaning_services_rounded;
      case 'electricity': return Icons.flash_on_rounded;
      case 'delivery': return Icons.local_shipping_rounded;
      case 'carpentry': return Icons.carpenter_rounded;
      case 'repairing':
      case 'fixing': return Icons.build_rounded;
      default: return Icons.miscellaneous_services_rounded;
    }
  }
}