// ignore_for_file: use_build_context_synchronously, unused_catch_clause, prefer_const_constructors

import 'package:explore_ease/pages/forgot_pass_page.dart';
import 'package:explore_ease/pages/home_page.dart';
import 'package:explore_ease/pages/signup_page.dart';
import 'package:explore_ease/services/authServices.dart';
import 'package:flutter/material.dart';

class MySigninPage extends StatefulWidget {
  const MySigninPage({super.key});

  @override
  State<MySigninPage> createState() => _MySigninPageState();
}

class _MySigninPageState extends State<MySigninPage> {
  Color navyBlue = const Color(0xFF000080);
  late String mail = "", pass = "";
  bool _isPasswordVisible = false;
  AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: navyBlue,
        body: Center(
          child: SingleChildScrollView(
            scrollDirection: Axis.vertical,
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
                      scale: 1.4, // Adjust the scale factor to make it smaller
                      child: Image.asset(
                        "lib/images/logo.png",
                        height: 250,
                      ),
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
                    Row(
                      mainAxisAlignment: MainAxisAlignment.end,
                      children: [
                        TextButton(
                          onPressed: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const ForgotPassPage(),
                              ),
                            );
                          },
                          child: const Text("Forgot Password!"),
                        ),
                      ],
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 20,
                        ),
                        backgroundColor: Color.fromARGB(255, 82, 79, 79),
                        padding: EdgeInsets.symmetric(
                            vertical: 17,
                            horizontal: MediaQuery.of(context).size.width *
                                0.29), // Adjust padding
                      ),
                      onPressed: () {
                        auth.signIn(context, mail, pass);
                      },
                      child: const Text(
                        "Sign In",
                        style: TextStyle(
                          fontWeight: FontWeight.bold, // Make the text bold
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontSize: 15,
                        ),
                        backgroundColor: Colors.grey[300],
                        shadowColor: Colors.grey,
                        padding: EdgeInsets.symmetric(
                            vertical: 13,
                            horizontal: MediaQuery.of(context).size.width *
                                0.10), // Adjust padding
                      ),
                      onPressed: () async {
                        await auth.logInWithGoogle(context);
                      },
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Image.asset(
                              "lib/images/google.png",
                              height: 28,
                              width: 28,
                            ),
                            SizedBox(width: 20,),
                            Text("Sign In with Google",style: TextStyle(color: Color.fromARGB(255, 82, 79, 79), fontWeight: FontWeight.bold,fontSize: 15),),
                          ],
                        ),
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MySignUpPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "Not registered? Sign Up",
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ),
        ));
  }
}
