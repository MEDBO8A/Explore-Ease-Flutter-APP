// ignore_for_file: prefer_const_constructors

import 'package:explore_ease/pages/home_page.dart';
import 'package:explore_ease/pages/welcome_page.dart';
import 'package:explore_ease/services/authServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class MyStatepage extends StatefulWidget {
  const MyStatepage({super.key});

  @override
  State<MyStatepage> createState() => _MyStatepageState();
}

class _MyStatepageState extends State<MyStatepage> {
  User? user;
  AuthServices auth = AuthServices();

  Future<void> getUser() async {
    final userRes = await auth.getUser();
    setState(() {
      user = userRes;
    });
  }

  @override
  Widget build(BuildContext context) {
    getUser();
    return user != null ? MyHomePage() : MyWelcomePage();
  }
}
