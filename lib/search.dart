// import 'package:flutter/material.dart';

// class Search extends StatefulWidget {
//   const Search({super.key});

//   @override
//   State<Search> createState() => _SearchState();
// }

// class _SearchState extends State<Search> {
//   final List<String> services = [
//     'Cleaning',
//     'Plumbing',
//     'Electrical',
//     'AC Repair',
//     'Delivery',
//   ];

//   String query = '';

//   @override
//   Widget build(BuildContext context) {
//     final filteredServices = services
//         .where((service) => service.toLowerCase().contains(query.toLowerCase()))
//         .toList();

//     return Scaffold(
//       // backgroundColor:  Color(0xFFF2F8FD),
//       backgroundColor:  Theme.of(context).scaffoldBackgroundColor,

      
//       body: SafeArea(
//         child: Padding(
//           padding: const EdgeInsets.all(50),
//           child: Column(
//             children: [
//               const SizedBox(height: 150),
//               const Text(
//                 'Search',
//                 style: TextStyle(
//                   fontSize: 45,
//                   fontWeight: FontWeight.w500,
//                   color: Color(0xFF093A61),
//                 ),
//               ),
//               const SizedBox(height: 20),
//               TextField(
//                 cursorColor: const Color(0xFF093A61),
//                 onChanged: (value) => setState(() => query = value),
//                 decoration: InputDecoration(
//                   labelText: 'Search services',
//                   labelStyle:  TextStyle(color: Color(0xFF093A61)),
//                   enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide:  BorderSide(color: Colors.white),
//                   ),
//                   focusedBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(20),
//                     borderSide:  BorderSide(color: Colors.white),
//                   ),
//                   fillColor: Colors.white,
//                   filled: true,
//                 ),
//               ),
//               const SizedBox(height: 20),
//               Expanded(
//                 child: ListView.builder(
//                   itemCount: filteredServices.length,
//                   itemBuilder: (context, index) {
//                     return Card(
//                       color: Colors.white,
//                       elevation: 0,
//                       child: ListTile(
//                         title: Text(filteredServices[index]),
//                         onTap: () {
//                           ScaffoldMessenger.of(context).showSnackBar(
//                             SnackBar(
//                               content:
//                                   Text('Selected: ${filteredServices[index]}'),
//                               duration: Duration(seconds: 1),
//                             ),
//                           );
//                         },
//                       ),
//                     );
//                   },
//                 ),
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:homez/category_services_page.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  // قائمة الخدمات المتاحة في تطبيقك
  final List<String> services = [
    'Cleaning',
    'Repairing',
    'Carpentry',
    'Electricity',
    'Delivery',
    'Fixing',
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    // فلترة القائمة بناءً على نص البحث
    final filteredServices = services
        .where((service) => service.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD), // نفس خلفية التطبيق الفاتحة
      body: SafeArea(
        child: Column(
          children: [
            const SizedBox(height: 60), // تقليل المسافة العلوية قليلاً لراحة العين
            const Text(
              'Search',
              style: TextStyle(
                fontSize: 40,
                fontWeight: FontWeight.bold,
                color: Color(0xFF093A61), // اللون الكحلي الأساسي
              ),
            ),
            const SizedBox(height: 30),
            
            // حقل البحث (TextField) بتصميم عصري
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: TextField(
                cursorColor: const Color(0xFF093A61),
                onChanged: (value) => setState(() => query = value),
                decoration: InputDecoration(
                  prefixIcon: const Icon(Icons.search, color: Color(0xFF093A61)),
                  hintText: 'Search services...',
                  hintStyle: TextStyle(color: Colors.grey[400]),
                  filled: true,
                  fillColor: Colors.white,
                  contentPadding: const EdgeInsets.symmetric(vertical: 15),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(25),
                    borderSide: const BorderSide(color: Color(0xFFFFB545), width: 1.5), // حدود ذهبية عند التركيز
                  ),
                ),
              ),
            ),
            
            const SizedBox(height: 20),

            // قائمة النتائج
            Expanded(
              child: filteredServices.isEmpty
                  ? Center(
                      child: Text(
                        'No services found',
                        style: TextStyle(color: Colors.grey[600]),
                      ),
                    )
                  : ListView.builder(
                      padding: const EdgeInsets.symmetric(horizontal: 25),
                      itemCount: filteredServices.length,
                      itemBuilder: (context, index) {
                        final serviceName = filteredServices[index];
                        return Container(
                          margin: const EdgeInsets.only(bottom: 12),
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.black.withOpacity(0.03),
                                blurRadius: 8,
                                offset: const Offset(0, 4),
                              ),
                            ],
                          ),
                          child: ListTile(
                            title: Text(
                              serviceName,
                              style: const TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Color(0xFF093A61),
                              ),
                            ),
                            trailing: const Icon(
                              Icons.arrow_forward_ios,
                              size: 16,
                              color: Color(0xFFFFB545), // سهم ذهبي
                            ),
                            onTap: () {
                              // الانتقال لصفحة الكاتيجوري الخاصة بالخدمة المختارة
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => CategoryServicesPage(
                                    categoryName: serviceName,
                                  ),
                                ),
                              );
                            },
                          ),
                        );
                      },
                    ),
            ),
          ],
        ),
      ),
    );
  }
}