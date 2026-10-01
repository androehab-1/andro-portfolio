import 'package:flutter/material.dart';
import 'screens/home_screen.dart'; // سطر الربط بالملف الجديد

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Andro Portfolio',
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: const Color(0xFF0A192F), // لون كحلي غامق مريح للعين
      ),
      home: HomeScreen(), // هنا بنعرض الشاشة اللي لسه عاملينها
    );
  }
}