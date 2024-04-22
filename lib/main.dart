import 'package:flutter/material.dart';
import 'package:socail_media_app/view/screens/bottom_nav_screen/Bottom_Navigation_Bar.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(

        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home:const BottomNavigationBarInFlutter (),
    );
  }
}




