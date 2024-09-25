import 'package:flutter/material.dart';
import 'package:switchfrontend/src/features/home/presentation/pages/home_page.dart';
import 'package:switchfrontend/src/features/login/presentation/pages/login_page.dart';
import 'package:switchfrontend/src/features/addCode/presentation/pages/addCode_page.dart'; 
import 'package:switchfrontend/src/features/schedule/presentation/pages/schedule_page.dart';
import 'package:switchfrontend/src/features/listSwitch/presentation/pages/listSwitch_page.dart';  
import 'package:switchfrontend/src/features/addRoom/presentation/pages/addRoom_page.dart'; 
import 'package:switchfrontend/src/features/listRoom/presentation/pages/listRoom_page.dart'; 
import 'package:switchfrontend/src/features/login/presentation/pages/signin_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Switch',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
      home: HomePage(),
    );
  }
}

