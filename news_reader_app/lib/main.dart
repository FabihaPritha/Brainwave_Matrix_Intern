import 'package:flutter/material.dart';
import 'package:news_reader_app/screens/home.dart';


void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flash Feed',
      theme: ThemeData(primarySwatch: Colors.red,
        primaryColor: Colors.red[900],
        colorScheme: ColorScheme.fromSwatch(
          primarySwatch: Colors.red,
        ).copyWith(
          secondary: Colors.red[900],
        ),),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}