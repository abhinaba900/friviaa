import 'package:flutter/material.dart';
import 'package:friviaa/pages/game_page.dart';
import 'package:friviaa/pages/home_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Friviaa',
      theme: ThemeData(
        fontFamily: "ArchitectsDaughter",
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        scaffoldBackgroundColor: Color.fromRGBO(31, 31, 31, 1.0),
      ),
      home: SafeArea(child: HomePage()),
    );
  }
}
