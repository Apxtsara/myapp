import 'package:flutter/material.dart';
//import 'package:myapp/menu/main2.dart'; // ไฟล์ Main2.dart
import 'package:myapp/screen/home.dart'; // ไฟล์ HomeScreen.dart

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: const HomeScreen(), // เริ่มต้นจากหน้า HomeScreen
    );
  }
}
