import 'package:flutter/material.dart';

class Search extends StatefulWidget {
  const Search({super.key});

  @override
  State<Search> createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final List<String> services = [
    'Cleaning',
    'Plumbing',
    'Electrical',
    'AC Repair',
    'Delivery',
  ];

  String query = '';

  @override
  Widget build(BuildContext context) {
    final filteredServices = services
        .where((service) => service.toLowerCase().contains(query.toLowerCase()))
        .toList();

    return Scaffold(
      // backgroundColor:  Color(0xFFF2F8FD),
      backgroundColor:  Theme.of(context).scaffoldBackgroundColor,

      
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.all(50),
          child: Column(
            children: [
              const SizedBox(height: 150),
              const Text(
                'Search',
                style: TextStyle(
                  fontSize: 45,
                  fontWeight: FontWeight.w500,
                  color: Color(0xFF093A61),
                ),
              ),
              const SizedBox(height: 20),
              TextField(
                cursorColor: const Color(0xFF093A61),
                onChanged: (value) => setState(() => query = value),
                decoration: InputDecoration(
                  labelText: 'Search services',
                  labelStyle:  TextStyle(color: Color(0xFF093A61)),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:  BorderSide(color: Colors.white),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:  BorderSide(color: Colors.white),
                  ),
                  fillColor: Colors.white,
                  filled: true,
                ),
              ),
              const SizedBox(height: 20),
              Expanded(
                child: ListView.builder(
                  itemCount: filteredServices.length,
                  itemBuilder: (context, index) {
                    return Card(
                      color: Colors.white,
                      elevation: 0,
                      child: ListTile(
                        title: Text(filteredServices[index]),
                        onTap: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content:
                                  Text('Selected: ${filteredServices[index]}'),
                              duration: Duration(seconds: 1),
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
      ),
    );
  }
}