import 'package:flutter/material.dart';
import 'package:proyecto_cine_app/themes/theme.dart';
import 'package:proyecto_cine_app/screens/home_screen.dart';



void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'NOMO Movie App',
      //aca en este theme es para que el fondo este oscuro 
      theme: ThemeData.dark().copyWith(
        scaffoldBackgroundColor: Themes.scaffoldBgColor,
      ),
      home: const HomeScreen(),
    );
  }
}