import 'package:flutter/material.dart';

class Home extends StatelessWidget {
  const Home({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            Stack(
              children: [
                Container(
                  height: 200,
                  decoration: BoxDecoration(
                    color: const Color(0xFFF2F8FD),
                    borderRadius: BorderRadius.only(
                      bottomLeft: Radius.circular(24),
                      bottomRight: Radius.circular(24),
                    ),
                  ),
                ),
                Positioned(
                  top: 40,
                  left: 20,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      Image.asset('images1/avatar1.png', height: 50, width: 50),
                      Text(
                        'Hi Dawad',
                        style: TextStyle(
                          color: const Color(0xFFFFB545),
                          fontSize: 15,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                Positioned(
                  top: 80,
                  left: 20,
                  child: Text(
                    'What service do you need?',
                    style: TextStyle(
                      color: const Color(0xFF093A61),
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
                Positioned(
                  top: 120,
                  left: 20,
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xFFFFB545),
                      padding: EdgeInsets.only(left: 30, right: 30),
                    ),
                    onPressed: () {},
                    child: Text(
                      'Get Start',
                      style: TextStyle(
                        color: const Color(0xFF093A61),
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                ),
                Positioned(
                  right: -18,
                  bottom: -45,
                  child: Image.asset('images1/broom.png', width: 180),
                ),
              ],
            ),

            SizedBox(height: 20),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Align(
                alignment: Alignment.centerLeft,
                child: Text(
                  'Category',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: const Color(0xFF093A61),
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 100,
              child: ListView(
                scrollDirection: Axis.horizontal,
                padding: EdgeInsets.symmetric(horizontal: 16),
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

            SizedBox(height: 20),

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
            SizedBox(height: 10),
            recommendedCard(
              'John',
              'Cleaning Specialist',
              25,
              'images1/photo_5_2025-11-21_20-28-53-removebg-preview.png',
            ),
            recommendedCard(
              'Robert',
              'Electrician',
              35,
              'images1/photo_7_2025-11-21_20-28-53.jpg',
            ),
            recommendedCard(
              'Michael',
              'Delivery',
              20,
              'images1/photo_1_2025-11-21_20-29-04.jpg',
            ),
            recommendedCard(
              'James',
              'Fixing Technician',
              24,
              'images1/photo_3_2025-11-21_20-29-04.jpg',
            ),
            // recommendedCard('Maya', 'Laundry Expert', 'images1/photo_6_2025-11-21_20-28-53-removebg-preview.png'),
            recommendedCard(
              'Mark',
              'Carpentry',
              30,
              'images1/photo_9_2025-11-21_20-28-53.jpg',
            ),
          ],
        ),
      ),
    );
  }

  Widget categoryItem(String image, String label) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: Column(
        children: [
          Image.asset(image, height: 50, width: 50),
          SizedBox(height: 8),
          Text(label, style: TextStyle(color: const Color(0xFF093A61))),
        ],
      ),
    );
  }

  Widget recommendedCard(
    String name,
    String service,
    double price,
    String imagePath,
  ) {
    return Card(
      margin: EdgeInsets.symmetric(horizontal: 16, vertical: 8),
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Container(
        height: 150,
        width: 400,
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            Container(
              height: 150,
              width: 150,
              padding: EdgeInsetsGeometry.all(5),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(12),
              ),
              child: Image.asset(imagePath),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  service,
                  style: TextStyle(
                    color: const Color(0xFF093A61),
                    fontSize: 18,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                Text('by $name'),
                SizedBox(height: 20),
                Text('$price /h '),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
