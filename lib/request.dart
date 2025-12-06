import 'package:flutter/material.dart';

class Request extends StatefulWidget {
  const Request({super.key});

  @override
  State<Request> createState() => _RequestState();
}

class _RequestState extends State<Request> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF2F8FD),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.all(30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: 60,
                ),
                Align(
                  alignment: Alignment.center,
                  child: Text(
                    'Request Service',
                    style: TextStyle(
                      fontSize: 35,
                      fontWeight: FontWeight.w500,
                      color: Color(0xFF093A61),
                    ),
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                Text('Service Type',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF093A61),
                        fontWeight: FontWeight.w500)),
                DropdownButton<String>(
                  items: [
                    DropdownMenuItem(
                        value: 'Electrical', child: Text('Electrical')),
                    DropdownMenuItem(
                        value: 'Plumbing', child: Text('Plumbing')),
                    DropdownMenuItem(
                        value: 'Cleaning', child: Text('Cleaning')),
                    DropdownMenuItem(
                        value: 'AC Repair', child: Text('AC Repair')),
                    DropdownMenuItem(
                        value: 'Delivery', child: Text('Delivery')),
                  ],
                  onChanged: (value) {},
                ),
                SizedBox(height: 20),
                Text('Description',
                    style: TextStyle(
                        fontSize: 16,
                        color: Color(0xFF093A61),
                        fontWeight: FontWeight.w500)),
                TextField(
                  decoration: InputDecoration(
                    hintText: 'Describe the work',
                     enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:  BorderSide(color: Colors.white),
                  ),
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:  BorderSide(color: Color(0xFF093A61)),
                  ),
                    
                  ),
                  maxLines: 3,
                ),
                SizedBox(height: 20),
                Text('Appointment', style: TextStyle(fontSize: 16,
                        color: Color(0xFF093A61),
                        fontWeight: FontWeight.w500)),
                Row(
                  children: [
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Date',
                          enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:  BorderSide(color: Colors.white),
                  ),
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:  BorderSide(color: Color(0xFF093A61)),
                  ),
                        ),
                      ),
                    ),
                    SizedBox(width: 10),
                    Expanded(
                      child: TextField(
                        decoration: InputDecoration(
                          hintText: 'Time',
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(20),
                    borderSide:  BorderSide(color: Colors.white),
                  ),
                    focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide:  BorderSide(color: Color(0xFF093A61)),
                  ),
                        ),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Text('Service Provider', style: TextStyle(fontSize: 16,color: Color(0xFF093A61),
                        fontWeight: FontWeight.w500)),
                DropdownButton<String>(
                  items: [
                    DropdownMenuItem(value: 'John', child: Text('John')),
                    DropdownMenuItem(value: 'Sarah', child: Text('Sarah')),
                    DropdownMenuItem(value: 'Ali', child: Text('Ali')),
                  ],
                  onChanged: (value) {},
                ),
                SizedBox(height: 30),
                Center(
                  child:  ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color(0xFFFFB545),
                  padding: EdgeInsets.symmetric(horizontal: 60),
                ),
                onPressed: (){},
                child: Text(
                  'Submit',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}