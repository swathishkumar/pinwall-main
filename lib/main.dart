import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/home_page.dart';

void main() {
  runApp(const PinterestApp());
}

class PinterestApp extends StatelessWidget {
  const PinterestApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Pinterest App',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: const HomePage(),
    );
  }
}
