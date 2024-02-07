import 'package:flutter/material.dart';

class MyBookPackage extends StatefulWidget {
  const MyBookPackage({super.key});

  @override
  State<MyBookPackage> createState() => _MyBookPackageState();
}

class _MyBookPackageState extends State<MyBookPackage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Book Now ",
        ),
        centerTitle: true,
      ),
    );
  }
}
