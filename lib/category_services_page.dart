// import 'package:flutter/material.dart';

// class CategoryServicesPage extends StatelessWidget {
//   final String categoryName;

//   const CategoryServicesPage({super.key, required this.categoryName});

//   @override
//   Widget build(BuildContext context) {

//     // قائمة مزودين خدمات (مؤقتة للتجربة)
//     final List<Map<String, dynamic>> allServices = [
//       // Cleaning workers
//       {'name': 'Ahmed', 'service': 'Cleaning', 'price': 25.0, 'image': 'images1/cleaning/photo_32_2026-03-08_22-44-49.jpg'},
//       {'name': 'Fatima', 'service': 'Cleaning', 'price': 27.0, 'image': 'images1/cleaning/photo_33_2026-03-08_22-44-49.jpg'},
//       {'name': 'Hassan', 'service': 'Cleaning', 'price': 24.0, 'image': 'images1/cleaning/photo_34_2026-03-08_22-44-49.jpg'},
//       {'name': 'Mona', 'service': 'Cleaning', 'price': 26.0, 'image': 'images1/cleaning/photo_35_2026-03-08_22-44-49.jpg'},
//       {'name': 'Samir', 'service': 'Cleaning', 'price': 23.0, 'image': 'images1/cleaning/photo_36_2026-03-08_22-44-49.jpg'},
//       {'name': 'Noura', 'service': 'Cleaning', 'price': 28.0, 'image': 'images1/cleaning/photo_37_2026-03-08_22-44-49.jpg'},
//       {'name': 'Majed', 'service': 'Cleaning', 'price': 29.0, 'image': 'images1/cleaning/photo_38_2026-03-08_22-44-49.jpg'},
//       // Carpentry workers
//       {'name': 'Khaled', 'service': 'Carpentry', 'price': 30.0, 'image': 'images1/carpentry/photo_39_2026-03-08_22-44-49.jpg'},
//       {'name': 'Yousef', 'service': 'Carpentry', 'price': 32.0, 'image': 'images1/carpentry/photo_40_2026-03-08_22-44-49.jpg'},
//       {'name': 'Rami', 'service': 'Carpentry', 'price': 31.0, 'image': 'images1/carpentry/photo_41_2026-03-08_22-44-49.jpg'},
//       {'name': 'Sami', 'service': 'Carpentry', 'price': 33.0, 'image': 'images1/carpentry/photo_42_2026-03-08_22-44-49.jpg'},
//       {'name': 'Hani', 'service': 'Carpentry', 'price': 34.0, 'image': 'images1/carpentry/photo_43_2026-03-08_22-44-49.jpg'},
//       {'name': 'Bader', 'service': 'Carpentry', 'price': 35.0, 'image': 'images1/carpentry/photo_7_2026-03-08_22-44-49.jpg'},
//       {'name': 'Ayman', 'service': 'Carpentry', 'price': 36.0, 'image': 'images1/carpentry/photo_8_2026-03-08_22-44-49.jpg'},
//       // Delivery workers
//       {'name': 'Ali', 'service': 'Delivery', 'price': 20.0, 'image': 'images1/delivery/photo_23_2026-03-08_22-44-49.jpg'},
//       {'name': 'Sara', 'service': 'Delivery', 'price': 22.0, 'image': 'images1/delivery/photo_24_2026-03-08_22-44-49.jpg'},
//       {'name': 'Fahad', 'service': 'Delivery', 'price': 21.0, 'image': 'images1/delivery/photo_25_2026-03-08_22-44-49.jpg'},
//       {'name': 'Lina', 'service': 'Delivery', 'price': 23.0, 'image': 'images1/delivery/photo_26_2026-03-08_22-44-49.jpg'},
//       {'name': 'Omar', 'service': 'Delivery', 'price': 24.0, 'image': 'images1/delivery/photo_27_2026-03-08_22-44-49.jpg'},
//       {'name': 'Nada', 'service': 'Delivery', 'price': 25.0, 'image': 'images1/delivery/photo_28_2026-03-08_22-44-49.jpg'},
//       {'name': 'Rashid', 'service': 'Delivery', 'price': 26.0, 'image': 'images1/delivery/photo_29_2026-03-08_22-44-49.jpg'},
//       {'name': 'Huda', 'service': 'Delivery', 'price': 27.0, 'image': 'images1/delivery/photo_30_2026-03-08_22-44-49.jpg'},
//       {'name': 'Talal', 'service': 'Delivery', 'price': 28.0, 'image': 'images1/delivery/photo_31_2026-03-08_22-44-49.jpg'},
//       // Electricity workers
//       {'name': 'Mohammed', 'service': 'Electricity', 'price': 35.0, 'image': 'images1/electricity/photo_15_2026-03-08_22-44-49.jpg'},
//       {'name': 'Salem', 'service': 'Electricity', 'price': 33.0, 'image': 'images1/electricity/photo_16_2026-03-08_22-44-49.jpg'},
//       {'name': 'Faisal', 'service': 'Electricity', 'price': 34.0, 'image': 'images1/electricity/photo_17_2026-03-08_22-44-49.jpg'},
//       {'name': 'Riyad', 'service': 'Electricity', 'price': 36.0, 'image': 'images1/electricity/photo_18_2026-03-08_22-44-49.jpg'},
//       {'name': 'Tariq', 'service': 'Electricity', 'price': 37.0, 'image': 'images1/electricity/photo_19_2026-03-08_22-44-49.jpg'},
//       {'name': 'Majed', 'service': 'Electricity', 'price': 38.0, 'image': 'images1/electricity/photo_20_2026-03-08_22-44-49.jpg'},
//       {'name': 'Nabil', 'service': 'Electricity', 'price': 39.0, 'image': 'images1/electricity/photo_21_2026-03-08_22-44-49.jpg'},
//       {'name': 'Saeed', 'service': 'Electricity', 'price': 40.0, 'image': 'images1/electricity/photo_22_2026-03-08_22-44-49.jpg'},
//       // Fixing workers
//       {'name': 'Omar', 'service': 'Fixing', 'price': 28.0, 'image': 'images1/fixing/photo_9_2026-03-08_22-44-49.jpg'},
//       {'name': 'Layla', 'service': 'Fixing', 'price': 29.0, 'image': 'images1/fixing/photo_10_2026-03-08_22-44-49.jpg'},
//       {'name': 'Huda', 'service': 'Fixing', 'price': 30.0, 'image': 'images1/fixing/photo_11_2026-03-08_22-44-49.jpg'},
//       {'name': 'Rami', 'service': 'Fixing', 'price': 31.0, 'image': 'images1/fixing/photo_12_2026-03-08_22-44-49.jpg'},
//       {'name': 'Sami', 'service': 'Fixing', 'price': 32.0, 'image': 'images1/fixing/photo_13_2026-03-08_22-44-49.jpg'},
//       {'name': 'Hani', 'service': 'Fixing', 'price': 33.0, 'image': 'images1/fixing/photo_14_2026-03-08_22-44-49.jpg'},
//        //repairing
//       {'name': 'Omar', 'service': 'repairing', 'price': 28.0, 'image': 'images1/repairing/photo_1_2026-03-08_22-44-49.jpg'},
//       {'name': 'Layla', 'service': 'repairing', 'price': 29.0, 'image': 'images1/repairing/photo_2_2026-03-08_22-44-49.jpg'},
//       {'name': 'Huda', 'service': 'repairing', 'price': 30.0, 'image': 'images1/repairing/photo_3_2026-03-08_22-44-49.jpg'},
//       {'name': 'Rami', 'service': 'repairing', 'price': 31.0, 'image': 'images1/repairing/photo_4_2026-03-08_22-44-49.jpg'},
//       {'name': 'Sami', 'service': 'repairing', 'price': 32.0, 'image': 'images1/repairing/photo_5_2026-03-08_22-44-49.jpg'},
//       {'name': 'Hani', 'service': 'repairing', 'price': 33.0, 'image': 'images1/repairing/photo_6_2026-03-08_22-44-49.jpg'},
//     ];

//     // فلترة حسب الكاتيجوري
//     final filteredServices = allServices
//         .where((service) => service['service'] == categoryName)
//         .toList();

//     return Scaffold(
//       appBar: AppBar(
//         title: Text(categoryName),
//         backgroundColor: const Color(0xFFFFB545),
//       ),
//       body: ListView.builder(
//         itemCount: filteredServices.length,
//         itemBuilder: (context, index) {
//           final service = filteredServices[index];

//           return Card(
//             margin: const EdgeInsets.all(12),
//             child: ListTile(
//               leading: SizedBox(
//                 width: 80,
//                 height: 80,
//                 child: Image.asset(service['image'])),
//               title: Text(service['name']),
//               subtitle: Text('${service['price']} /h'),
//             ),
//           );
//         },
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:homez/request.dart';
import 'package:firebase_auth/firebase_auth.dart';

class CategoryServicesPage extends StatelessWidget {
  final String categoryName;

  const CategoryServicesPage({super.key, required this.categoryName});

  @override
  Widget build(BuildContext context) {
    // قائمة مزودين خدمات (نفس بياناتك مع توحيد حالة الحروف لضمان الفلترة)
    final List<Map<String, dynamic>> allServices = [
      {'name': 'Ahmed', 'service': 'Cleaning', 'price': 25.0, 'image': 'images1/cleaning/photo_32_2026-03-08_22-44-49.jpg'},
      {'name': 'Fatima', 'service': 'Cleaning', 'price': 27.0, 'image': 'images1/cleaning/photo_33_2026-03-08_22-44-49.jpg'},
      {'name': 'Hassan', 'service': 'Cleaning', 'price': 24.0, 'image': 'images1/cleaning/photo_34_2026-03-08_22-44-49.jpg'},
      {'name': 'Mona', 'service': 'Cleaning', 'price': 26.0, 'image': 'images1/cleaning/photo_35_2026-03-08_22-44-49.jpg'},
      {'name': 'Samir', 'service': 'Cleaning', 'price': 23.0, 'image': 'images1/cleaning/photo_36_2026-03-08_22-44-49.jpg'},
      {'name': 'Noura', 'service': 'Cleaning', 'price': 28.0, 'image': 'images1/cleaning/photo_37_2026-03-08_22-44-49.jpg'},
      {'name': 'Majed', 'service': 'Cleaning', 'price': 29.0, 'image': 'images1/cleaning/photo_38_2026-03-08_22-44-49.jpg'},
      {'name': 'Khaled', 'service': 'Carpentry', 'price': 30.0, 'image': 'images1/carpentry/photo_39_2026-03-08_22-44-49.jpg'},
      {'name': 'Yousef', 'service': 'Carpentry', 'price': 32.0, 'image': 'images1/carpentry/photo_40_2026-03-08_22-44-49.jpg'},
      {'name': 'Rami', 'service': 'Carpentry', 'price': 31.0, 'image': 'images1/carpentry/photo_41_2026-03-08_22-44-49.jpg'},
      {'name': 'Sami', 'service': 'Carpentry', 'price': 33.0, 'image': 'images1/carpentry/photo_42_2026-03-08_22-44-49.jpg'},
      {'name': 'Hani', 'service': 'Carpentry', 'price': 34.0, 'image': 'images1/carpentry/photo_43_2026-03-08_22-44-49.jpg'},
      {'name': 'Bader', 'service': 'Carpentry', 'price': 35.0, 'image': 'images1/carpentry/photo_7_2026-03-08_22-44-49.jpg'},
      {'name': 'Ayman', 'service': 'Carpentry', 'price': 36.0, 'image': 'images1/carpentry/photo_8_2026-03-08_22-44-49.jpg'},
      {'name': 'Ali', 'service': 'Delivery', 'price': 20.0, 'image': 'images1/delivery/photo_23_2026-03-08_22-44-49.jpg'},
      {'name': 'Sara', 'service': 'Delivery', 'price': 22.0, 'image': 'images1/delivery/photo_24_2026-03-08_22-44-49.jpg'},
      {'name': 'Fahad', 'service': 'Delivery', 'price': 21.0, 'image': 'images1/delivery/photo_25_2026-03-08_22-44-49.jpg'},
      {'name': 'Lina', 'service': 'Delivery', 'price': 23.0, 'image': 'images1/delivery/photo_26_2026-03-08_22-44-49.jpg'},
      {'name': 'Omar', 'service': 'Delivery', 'price': 24.0, 'image': 'images1/delivery/photo_27_2026-03-08_22-44-49.jpg'},
      {'name': 'Nada', 'service': 'Delivery', 'price': 25.0, 'image': 'images1/delivery/photo_28_2026-03-08_22-44-49.jpg'},
      {'name': 'Rashid', 'service': 'Delivery', 'price': 26.0, 'image': 'images1/delivery/photo_29_2026-03-08_22-44-49.jpg'},
      {'name': 'Huda', 'service': 'Delivery', 'price': 27.0, 'image': 'images1/delivery/photo_30_2026-03-08_22-44-49.jpg'},
      {'name': 'Talal', 'service': 'Delivery', 'price': 28.0, 'image': 'images1/delivery/photo_31_2026-03-08_22-44-49.jpg'},
      {'name': 'Mohammed', 'service': 'Electricity', 'price': 35.0, 'image': 'images1/electricity/photo_15_2026-03-08_22-44-49.jpg'},
      {'name': 'Salem', 'service': 'Electricity', 'price': 33.0, 'image': 'images1/electricity/photo_16_2026-03-08_22-44-49.jpg'},
      {'name': 'Faisal', 'service': 'Electricity', 'price': 34.0, 'image': 'images1/electricity/photo_17_2026-03-08_22-44-49.jpg'},
      {'name': 'Riyad', 'service': 'Electricity', 'price': 36.0, 'image': 'images1/electricity/photo_18_2026-03-08_22-44-49.jpg'},
      {'name': 'Tariq', 'service': 'Electricity', 'price': 37.0, 'image': 'images1/electricity/photo_19_2026-03-08_22-44-49.jpg'},
      {'name': 'Majed', 'service': 'Electricity', 'price': 38.0, 'image': 'images1/electricity/photo_20_2026-03-08_22-44-49.jpg'},
      {'name': 'Nabil', 'service': 'Electricity', 'price': 39.0, 'image': 'images1/electricity/photo_21_2026-03-08_22-44-49.jpg'},
      {'name': 'Saeed', 'service': 'Electricity', 'price': 40.0, 'image': 'images1/electricity/photo_22_2026-03-08_22-44-49.jpg'},
      {'name': 'Omar', 'service': 'Fixing', 'price': 28.0, 'image': 'images1/fixing/photo_9_2026-03-08_22-44-49.jpg'},
      {'name': 'Layla', 'service': 'Fixing', 'price': 29.0, 'image': 'images1/fixing/photo_10_2026-03-08_22-44-49.jpg'},
      {'name': 'Huda', 'service': 'Fixing', 'price': 30.0, 'image': 'images1/fixing/photo_11_2026-03-08_22-44-49.jpg'},
      {'name': 'Rami', 'service': 'Fixing', 'price': 31.0, 'image': 'images1/fixing/photo_12_2026-03-08_22-44-49.jpg'},
      {'name': 'Sami', 'service': 'Fixing', 'price': 32.0, 'image': 'images1/fixing/photo_13_2026-03-08_22-44-49.jpg'},
      {'name': 'Hani', 'service': 'Fixing', 'price': 33.0, 'image': 'images1/fixing/photo_14_2026-03-08_22-44-49.jpg'},
      {'name': 'Omar', 'service': 'Repairing', 'price': 28.0, 'image': 'images1/repairing/photo_1_2026-03-08_22-44-49.jpg'},
      {'name': 'Layla', 'service': 'Repairing', 'price': 29.0, 'image': 'images1/repairing/photo_2_2026-03-08_22-44-49.jpg'},
      {'name': 'Huda', 'service': 'Repairing', 'price': 30.0, 'image': 'images1/repairing/photo_3_2026-03-08_22-44-49.jpg'},
      {'name': 'Rami', 'service': 'Repairing', 'price': 31.0, 'image': 'images1/repairing/photo_4_2026-03-08_22-44-49.jpg'},
      {'name': 'Sami', 'service': 'Repairing', 'price': 32.0, 'image': 'images1/repairing/photo_5_2026-03-08_22-44-49.jpg'},
      {'name': 'Hani', 'service': 'Repairing', 'price': 33.0, 'image': 'images1/repairing/photo_6_2026-03-08_22-44-49.jpg'},
    ];

    // فلترة حسب الكاتيجوري (مع تحويل كلاهما لـ lowercase لضمان التطابق)
    final filteredServices = allServices
        .where((service) => service['service'].toString().toLowerCase() == categoryName.toLowerCase())
        .toList();

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        title: Text(
          categoryName,
          style: const TextStyle(color: Color(0xFFFFB545), fontWeight: FontWeight.bold),
        ),
        backgroundColor: const Color(0xFF093A61),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFFFFB545)),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: filteredServices.isEmpty
          ? Center(
              child: Text(
                "No services available in $categoryName",
                style: const TextStyle(color: Color(0xFF093A61), fontSize: 16),
              ),
            )
          : ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 10),
              itemCount: filteredServices.length,
              itemBuilder: (context, index) {
                final service = filteredServices[index];

                return Container(
                  margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F8FD),
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black.withOpacity(0.03),
                        blurRadius: 10,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(12),
                    child: Row(
                      children: [
                        // صورة العامل بشكل دائري مرتب
                        Container(
                          width: 70,
                          height: 70,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(15),
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          clipBehavior: Clip.antiAlias,
                          child: Image.asset(
                            service['image'],
                            fit: BoxFit.cover,
                            errorBuilder: (context, error, stackTrace) =>
                                const Icon(Icons.person, size: 40, color: Colors.grey),
                          ),
                        ),
                        const SizedBox(width: 15),
                        // تفاصيل الخدمة
                        Expanded(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                service['name'],
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 17,
                                  color: Color(0xFF093A61),
                                ),
                              ),
                              const SizedBox(height: 4),
                              Text(
                                categoryName,
                                style: TextStyle(color: Colors.grey[600], fontSize: 13),
                              ),
                              const SizedBox(height: 6),
                              Text(
                                '${service['price']} \$/h',
                                style: const TextStyle(
                                  fontWeight: FontWeight.bold,
                                  color: Color(0xFFFFB545),
                                ),
                              ),
                            ],
                          ),
                        ),
                        // زر الريكويست
                        ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF093A61),
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                            elevation: 0,
                          ),
                          onPressed: () {
                            // تمرير البيانات لصفحة الريكويست كما في الـ Recommended
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => Request(
                                  cartItems: [
                                    {
                                      'name': service['name'],
                                      'service': service['service'],
                                      'price': service['price'],
                                    }
                                  ],
                                  email: FirebaseAuth.instance.currentUser?.email ?? "",
                                ),
                              ),
                            );
                          },
                          child: const Text(
                            'Request',
                            style: TextStyle(color: Colors.white, fontSize: 12, fontWeight: FontWeight.bold),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
    );
  }
}