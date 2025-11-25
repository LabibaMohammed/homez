import 'package:flutter/material.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(

      ),
        body: SafeArea(child:
            Stack(
              alignment: Alignment.center,
              children: [

                Row(
                  children: [
                    Column(
                      children: [
                        Container(
                          height: 300,
                          width:200,
                          color: const Color(0xFFF2F8FD),
                          child: Column(
                            children: [
                              Text('Hi name'),
                              Text('what service do you need?'),
                              ElevatedButton(onPressed:
                                  (){}, child: Text('Get Start'))
                            ],
                          ),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                      width: 0,
                    ),
                    Image.asset('images1/photo_2025-11-21_21-18-43.jpg',width: 200,height: 200,),
                  ],
                ),
              ],
            )
        )
    );
  }
}