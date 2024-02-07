// ignore_for_file: use_build_context_synchronously

import 'package:explore_ease/pages/email_verification_page.dart';
import 'package:explore_ease/pages/signin_page.dart';
import 'package:explore_ease/services/authServices.dart';
import 'package:explore_ease/services/loadingWidget.dart';
import 'package:flutter/material.dart';

class MySignUpPage extends StatefulWidget {
  const MySignUpPage({super.key});

  @override
  State<MySignUpPage> createState() => _MySignUpPageState();
}

class _MySignUpPageState extends State<MySignUpPage> {
  Color navyBlue = const Color(0xFF000080);
  String name = "", mail = "", pass = "";
  bool _isPasswordVisible = false;
  AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: navyBlue,
        body: Center(
          child: Container(
            width: MediaQuery.of(context).size.width * 0.9,
            height: MediaQuery.of(context).size.height * 0.9,
            margin: EdgeInsets.only(top: 30),
            decoration: BoxDecoration(
              color: Color.fromARGB(195, 255, 255, 255),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 10,
                  color: Colors.grey,
                  spreadRadius: 4,
                  offset: Offset(0, 3),
                ),
              ],
              borderRadius: BorderRadius.circular(20),
            ),
            padding: const EdgeInsets.all(30),
            child: SingleChildScrollView(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Transform.scale(
                    scale: 1.5, // Adjust the scale factor to make it smaller
                    child: Image.asset(
                      "lib/images/logo.png",
                      height: 250,
                    ),
                  ),
                  TextField(
                    onChanged: (e) {
                      setState(() {
                        name = e;
                      });
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.person),
                      labelText: "Username",
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (e) {
                      setState(() {
                        mail = e;
                      });
                    },
                    decoration: const InputDecoration(
                      prefixIcon: Icon(Icons.email),
                      labelText: "Gmail",
                      labelStyle: TextStyle(color: Colors.grey),
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  TextField(
                    onChanged: (e) {
                      setState(() {
                        pass = e;
                      });
                    },
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      prefixIcon: const Icon(Icons.lock),
                      labelText: "Password",
                      labelStyle: const TextStyle(color: Colors.grey),
                      suffixIcon: IconButton(
                        iconSize: 20,
                        icon: Icon(
                          _isPasswordVisible
                              ? Icons.visibility
                              : Icons.visibility_off,
                        ),
                        onPressed: () {
                          setState(() {
                            _isPasswordVisible = !_isPasswordVisible;
                          });
                        },
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      foregroundColor: Colors.white,
                      textStyle: const TextStyle(
                        fontSize: 20,
                      ),
                      backgroundColor: Color.fromARGB(255, 82, 79, 79),
                      padding: EdgeInsets.symmetric(
                          vertical: 15,
                          horizontal: MediaQuery.of(context).size.width * 0.28),
                    ),
                    onPressed: () async{
                      auth.signUp(context, name, mail, pass);
                    },
                    child: const Text(
                      "Sign Up",
                      style: TextStyle(
                        fontWeight: FontWeight.bold, // Make the text bold
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  TextButton(
                      onPressed: () {
                        debugPrint("signed up");
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const MySigninPage()),
                        );
                      },
                      child: const Text(
                        "Already have an account? Sign In",
                      )),
                ],
              ),
            ),
          ),
        ));
  }
}
