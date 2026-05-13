// import 'package:flutter/material.dart';
// import 'package:homez/account.dart';
// import 'package:homez/category_services_page.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:homez/request.dart';
// import 'package:firebase_auth/firebase_auth.dart';

// class Home extends StatefulWidget {

//   final String firstName;
//   final String lastName;
//   final String email;

//   const Home({super.key, required this.firstName, required this.lastName, required this.email});

//   @override
//   State<Home> createState() => _HomeState();
// }

// class _HomeState extends State<Home> {
//   late String firstName;
//   late String lastName;
//   late String email;
//   List<Map<String, dynamic>> requestCart = [];

//   @override
//   void initState() {
//     super.initState();
//     firstName = widget.firstName;
//     lastName = widget.lastName;
//      email = widget.email;
//   }
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       drawer: Drawer(
//         child: Account(
//           name: firstName + ' ' + lastName,
//           email: email,
//         ),
//       ),
//       appBar: AppBar(
//         backgroundColor:  const Color(0xFFF2F8FD),
//         title:  Row(
//                     mainAxisAlignment: MainAxisAlignment.start,
//                     children: [
//                       Image.asset('images1/avatar1.png', height: 50, width: 50),
//                       Text(
//                         'Hi $firstName $lastName',
//                         style: TextStyle(
//                           color: const Color(0xFFFFB545),
//                           fontSize: 15,
//                           fontWeight: FontWeight.bold,
//                         ),
//                       ),
//                     ],
//                   ),
//         // backgroundColor: const Color(0xFF093A61),
//         // title: const Text("Homez"),
//         leading: Builder(
//           builder: (context) => IconButton(
//             icon: const Icon(Icons.menu),
//             onPressed: () => Scaffold.of(context).openDrawer(),
//           ),
//         ),
//       ),
//       body: SingleChildScrollView(
//         child: Column(
//           children: [
//             Stack(
//               children: [
//                 Container(
//                   height: 200,
//                   decoration: BoxDecoration(
//                     color: const Color(0xFFF2F8FD),
//                     borderRadius: BorderRadius.only(
//                       bottomLeft: Radius.circular(24),
//                       bottomRight: Radius.circular(24),
//                     ),
//                   ),
//                 ),
//                 // Positioned(
//                 //   top: 40,
//                 //   left: 20,
//                 //   child: Row(
//                 //     mainAxisAlignment: MainAxisAlignment.spaceAround,
//                 //     children: [
//                 //       Image.asset('images1/avatar1.png', height: 50, width: 50),
//                 //       Text(
//                 //         'Hi $firstName $lastName',
//                 //         style: TextStyle(
//                 //           color: const Color(0xFFFFB545),
//                 //           fontSize: 15,
//                 //           fontWeight: FontWeight.bold,
//                 //         ),
//                 //       ),
//                 //     ],
//                 //   ),
//                 // ),
//                 Positioned(
//                   top: 20,
//                   left: 20,
//                   child: Text(
//                     'What service \n  do you need?',
//                     style: TextStyle(
//                       color: const Color(0xFF093A61),
//                       fontSize: 25,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   top: 120,
//                   left: 20,
//                   child: ElevatedButton(
//                     style: ElevatedButton.styleFrom(
//                       backgroundColor: const Color(0xFF093A61),
//                       foregroundColor: Colors.white,
//                       padding: const EdgeInsets.symmetric(horizontal: 36, vertical: 12),
//                       shape: RoundedRectangleBorder(
//                         borderRadius: BorderRadius.circular(24),
//                       ),
//                       elevation: 6,
//                     ),
//                     onPressed: () {},
//                     child: const Text(
//                       'Get Started',
//                       style: TextStyle(
//                         color: Color(0xFFFFB545),
//                         fontWeight: FontWeight.bold,
//                         fontSize: 16,
//                         letterSpacing: 1.2,
//                       ),
//                     ),
//                   ),
//                 ),
//                 Positioned(
//                   right: -10,
//                   bottom: -45,
//                   child: Image.asset('images1/broom.png', width: 190),
//                 ),
//               ],
//             ),

//             SizedBox(height: 20),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Category',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: const Color(0xFF093A61),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(
//               height: 100,
//               child: ListView(
//                 scrollDirection: Axis.horizontal,
//                 padding: EdgeInsets.symmetric(horizontal: 16),
//                 children: [
//                   categoryItem(
//                     'images1/photo_3_2025-11-21_20-28-53-removebg-preview.png',
//                     'Cleaning',
//                   ),
//                   categoryItem(
//                     'images1/photo_1_2025-11-21_20-28-53-removebg-preview.png',
//                     'Repairing',
//                   ),
//                   categoryItem(
//                     'images1/photo_2_2025-11-21_20-28-53-removebg-preview.png',
//                     'Carpentry',
//                   ),
//                   categoryItem('images1/electrictiy.png', 'Electricity'),
//                   categoryItem(
//                     'images1/photo_10_2025-11-21_20-28-53-removebg-preview.png',
//                     'Delivery',
//                   ),
//                   categoryItem(
//                     'images1/photo_4_2025-11-21_20-28-53-removebg-preview.png',
//                     'Fixing',
//                   ),
//                 ],
//               ),
//             ),

//             SizedBox(height: 20),

//             Padding(
//               padding: const EdgeInsets.symmetric(horizontal: 16),
//               child: Align(
//                 alignment: Alignment.centerLeft,
//                 child: Text(
//                   'Recommended',
//                   style: TextStyle(
//                     fontSize: 20,
//                     fontWeight: FontWeight.bold,
//                     color: const Color(0xFF093A61),
//                   ),
//                 ),
//               ),
//             ),
//             SizedBox(height: 10),
//             // recommendedCard(
//             //   'John',
//             //   'Cleaning Specialist',
//             //   25,
//             //   'images1/photo_5_2025-11-21_20-28-53-removebg-preview.png',
//             // ),
//             // recommendedCard(
//             //   'Robert',
//             //   'Electrician',
//             //   35,
//             //   'images1/photo_7_2025-11-21_20-28-53.jpg',
//             // ),
//             // recommendedCard(
//             //   'Michael',
//             //   'Delivery',
//             //   20,
//             //   'images1/photo_1_2025-11-21_20-29-04.jpg',
//             // ),
//             // recommendedCard(
//             //   'James',
//             //   'Fixing Technician',
//             //   24,
//             //   'images1/photo_3_2025-11-21_20-29-04.jpg',
//             // ),
//             // // recommendedCard('Maya', 'Laundry Expert', 'images1/photo_6_2025-11-21_20-28-53-removebg-preview.png'),
//             // recommendedCard(
//             //   'Mark',
//             //   'Carpentry',
//             //   30,
//             //   'images1/photo_9_2025-11-21_20-28-53.jpg',
//             // ),

//             //--------------------------------هنا سمية عدلت باضافة استريم بلدر فقط-------------------------------
//             StreamBuilder(
//   stream: FirebaseFirestore.instance.collection('services').snapshots(),
//   builder: (context, snapshot) {
//     if (!snapshot.hasData) {
//       return Center(child: CircularProgressIndicator());
//     }

//     final docs = snapshot.data!.docs;

//     return ListView.builder(
//       shrinkWrap: true,
//       physics: NeverScrollableScrollPhysics(),
//       itemCount: docs.length,
//       itemBuilder: (context, index) {
//         var data = docs[index];

//         return Card(
//           margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
//           elevation: 4,
//           shape: RoundedRectangleBorder(
//             borderRadius: BorderRadius.circular(12),
//           ),
//           child: ListTile(
//             leading: Image.network(data['image']),
//             title: Text(data['service'] ?? ""),
//             subtitle: Text("by ${data['name']}"),
//             trailing: Column(
//   mainAxisAlignment: MainAxisAlignment.center,
//   children: [
//     Text("${data['price']} /h"),
//     SizedBox(height: 5),

//     ElevatedButton(
//       style: ElevatedButton.styleFrom(
//         backgroundColor: const Color(0xFF093A61),
//         foregroundColor: Colors.white,
//         shape: RoundedRectangleBorder(
//           borderRadius: BorderRadius.circular(16),
//         ),
//         elevation: 4,
//         padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
//       ),
//       onPressed: () {
//         setState(() {
//           requestCart.add({
//             'name': data['name'],
//             'service': data['service'],
//             'price': data['price'],
//           });
//         });

//         ScaffoldMessenger.of(context).showSnackBar(
//           const SnackBar(content: Text("Added to Request 🛒")),
//         );

//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => Request(cartItems: requestCart, email: FirebaseAuth.instance.currentUser?.email ?? ""),
//           ),
//         );
//       },
//       child: const Text(
//         "Request",
//         style: TextStyle(
//           color: Color(0xFFFFB545),
//           fontWeight: FontWeight.bold,
//           fontSize: 14,
//         ),
//       ),
//     ),
//   ],
// ),
//           ),
//         );
//       },
//     );
//   },
// )
//           ],
//         ),
//       ),
//     );
//   }

//   Widget categoryItem(String image, String label) {
//     return GestureDetector(
//       child: Padding(
//         padding: const EdgeInsets.only(right: 12),
//         child: Column(
//           children: [
//             Container(
//               height: 50,
//               width: 50,
//               child: Image.asset(
//                 image,
//                 height: 50,
//                 width: 50,
//                 fit: BoxFit.cover,
//               ),
//             ),
//             SizedBox(height: 8),
//             Text(label, style: TextStyle(color: const Color(0xFF093A61))),
//           ],
//         ),
//       ),
//       onTap: () {
//         Navigator.push(
//           context,
//           MaterialPageRoute(
//             builder: (context) => CategoryServicesPage(categoryName: label),
//           ),
//         );
//       },
//     );
//   }

//   Widget recommendedCard(
//     String name,
//     String service,
//     double price,
//     String imagePath,
//   ) {
//     return Card(
//       margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
//       elevation: 6,
//       shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
//       child: Container(
//         height: 180,
//         width: 440,
//         padding: const EdgeInsets.all(12),
//         child: Row(
//           crossAxisAlignment: CrossAxisAlignment.center,
//           children: [
//             Container(
//               height: 150,
//               width: 150,
//               padding: const EdgeInsets.all(6),
//               decoration: BoxDecoration(
//                 borderRadius: BorderRadius.circular(16),
//                 color: Colors.white,
//                 boxShadow: [
//                   BoxShadow(
//                     color: Colors.black12,
//                     blurRadius: 4,
//                     offset: Offset(0, 2),
//                   ),
//                 ],
//               ),
//               child: ClipRRect(
//                 borderRadius: BorderRadius.circular(16),
//                 child: Image.asset(
//                   imagePath,
//                   height: 150,
//                   width: 150,
//                   fit: BoxFit.cover,
//                 ),
//               ),
//             ),
//             const SizedBox(width: 18),
//             Expanded(
//               child: Column(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   Text(
//                     service,
//                     style: const TextStyle(
//                       color: Color(0xFF093A61),
//                       fontSize: 20,
//                       fontWeight: FontWeight.bold,
//                     ),
//                   ),
//                   const SizedBox(height: 6),
//                   Text('by $name', style: const TextStyle(fontSize: 15)),
//                   const SizedBox(height: 16),
//                   Row(
//                     children: [
//                       Text(
//                         ' ${price.toStringAsFixed(0)} /h',
//                         style: const TextStyle(
//                           color: Color(0xFFFFB545),
//                           fontWeight: FontWeight.bold,
//                           fontSize: 16,
//                         ),
//                       ),
//                       const Spacer(),
//                       ElevatedButton.icon(
//                         style: ElevatedButton.styleFrom(
//                           backgroundColor: const Color(0xFF093A61),
//                           foregroundColor: Colors.white,
//                           shape: RoundedRectangleBorder(
//                             borderRadius: BorderRadius.circular(30),
//                           ),
//                           elevation: 4,
//                           padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 10),
//                         ),
//                         onPressed: () {},
//                         icon: const Icon(Icons.shopping_cart_checkout, color: Color(0xFFFFB545)),
//                         label: const Text(
//                           "Request",
//                           style: TextStyle(
//                             color: Color(0xFFFFB545),
//                             fontWeight: FontWeight.bold,
//                             fontSize: 15,
//                           ),
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ],
//         ),
//       ),
//     );
//   }
// }

import 'package:flutter/material.dart';
import 'package:homez/account.dart';
import 'package:homez/category_services_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:homez/request.dart';
import 'package:firebase_auth/firebase_auth.dart';

class Home extends StatefulWidget {
  final String firstName;
  final String lastName;
  final String email;

  const Home({
    super.key,
    required this.firstName,
    required this.lastName,
    required this.email,
  });

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  late String firstName;
  late String lastName;
  late String email;
  List<Map<String, dynamic>> requestCart = [];

  @override
  void initState() {
    super.initState();
    firstName = widget.firstName;
    lastName = widget.lastName;
    email = widget.email;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      drawer: Drawer(
        child: Account(name: '$firstName $lastName', email: email),
      ),
      appBar: AppBar(
        backgroundColor: const Color(0xFFF2F8FD),
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            Image.asset('images1/avatar1.png', height: 50, width: 50),
            const SizedBox(width: 8),
            Text(
              'Hi $firstName $lastName',
              style: const TextStyle(
                color: Color(0xFFFFB545),
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
          ],
        ),
        leading: Builder(
          builder: (context) => IconButton(
            icon: const Icon(Icons.menu, color: Color(0xFF093A61)),
            onPressed: () => Scaffold.of(context).openDrawer(),
          ),
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            // --- جزء الـ Stack اللي تحبينه رجع كما كان ---
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: const BoxDecoration(
                    color: Color(0xFFF2F8FD),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),
                const Positioned(
                  top: 20,
                  left: 20,
                  child: Text(
                    'What service \n  do you need?',
                    style: TextStyle(
                      color: Color(0xFF093A61),
                      fontSize: 25,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFF093A61),
                      foregroundColor: Colors.white,
                      padding: const EdgeInsets.symmetric(
                        horizontal: 36,
                        vertical: 12,
                      ),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24),
                      ),
                      elevation: 6,
                    ),
                    onPressed: () {},
                    child: const Text(
                      'Get Started',
                      style: TextStyle(
                        color: Color(0xFFFFB545),
                        fontWeight: FontWeight.bold,
                        fontSize: 16,
                        letterSpacing: 1.2,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -10,
                  bottom: -45,
                  child: Image.asset('images1/broom.png', width: 190),
                ),
              ],
            ),

            // -------------------------------------------
            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Categories',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF093A61),
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),

            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: const EdgeInsets.symmetric(horizontal: 16),
                children: [
                  categoryItem(
                    'images1/photo_3_2025-11-21_20-28-53-removebg-preview.png',
                    'Cleaning',
                  ),
                  categoryItem(
                    'images1/photo_1_2025-11-21_20-28-53-removebg-preview.png',
                    'Repairing',
                  ),
                  categoryItem(
                    'images1/photo_2_2025-11-21_20-28-53-removebg-preview.png',
                    'Carpentry',
                  ),
                  categoryItem('images1/electrictiy.png', 'Electricity'),
                  categoryItem(
                    'images1/photo_10_2025-11-21_20-28-53-removebg-preview.png',
                    'Delivery',
                  ),
                  categoryItem(
                    'images1/photo_4_2025-11-21_20-28-53-removebg-preview.png',
                    'Fixing',
                  ),
                ],
              ),
            ),

            const SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Recommended',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF093A61),
                  ),
                ),
              ),
            ),

            StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection('services')
                  .snapshots(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return const Center(child: CircularProgressIndicator());
                }

                final docs = snapshot.data!.docs;

                return ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: docs.length,
                  itemBuilder: (context, index) {
                    var data = docs[index];
                    return buildModernServiceCard(data, context);
                  },
                );
              },
            ),
            const SizedBox(height: 20),
          ],
        ),
      ),
    );
  }

  // الكارد المحسن بلمسة عصرية لزر الريكويست
  Widget buildModernServiceCard(DocumentSnapshot data, BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
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
        padding: const EdgeInsets.all(12),
        child: Row(
          children: [
            ClipRRect(
              borderRadius: BorderRadius.circular(15),
              child: Image.network(
                data['image'],
                width: 80,
                height: 80,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.person, size: 50),
              ),
            ),
            const SizedBox(width: 15),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    data['service'] ?? "",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 17,
                      color: Color(0xFF093A61),
                    ),
                  ),
                  Text(
                    'by ${data['name']}',
                    style: TextStyle(color: Colors.grey[600], fontSize: 13),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    '${data['price']} \$/h',
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFFFFB545),
                    ),
                  ),
                ],
              ),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFF093A61),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(12),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 8,
                ),
              ),
              onPressed: () {
                setState(() {
                  requestCart.add({
                    'name': data['name'],
                    'service': data['service'],
                    'price': data['price'],
                  });
                });
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => Request(
                      cartItems: requestCart,
                      email: FirebaseAuth.instance.currentUser?.email ?? "",
                    ),
                  ),
                );
              },
              child: const Text(
                'Request',
                style: TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(String image, String label) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CategoryServicesPage(categoryName: label),
          ),
        );
      },
      child: Padding(
        padding: const EdgeInsets.only(right: 12),
        child: Column(
          children: [
            Container(
              height: 70,
              width: 70,
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: const Color(0xFFF2F8FD),
                borderRadius: BorderRadius.circular(15),
              ),
              child: Image.asset(image, fit: BoxFit.contain),
            ),
            const SizedBox(height: 8),
            Text(
              label,
              style: const TextStyle(color: Color(0xFF093A61), fontSize: 14),
            ),
          ],
        ),
      ),
    );
  }
}
