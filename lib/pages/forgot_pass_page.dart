// ignore_for_file: use_build_context_synchronously, unrelated_type_equality_checks, unnecessary_null_comparison

import 'package:explore_ease/services/alert_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class ForgotPassPage extends StatefulWidget {
  const ForgotPassPage({super.key});

  @override
  State<ForgotPassPage> createState() => _ForgotPassPageState();
}

class _ForgotPassPageState extends State<ForgotPassPage> {
  final _gmailController = TextEditingController();
  Color navyBlue = const Color(0xFF000080);

  void resetPassword() async {
    String gmailEntered = _gmailController.text.trim();
    if (gmailEntered.isEmpty) {
      showErrorAlert(context, "Enter email !");
      return;
    }
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _gmailController.text.trim());
      Navigator.pop(context);
      showSuccessAlert(context, "Password reset link sent! check your email");
    } on FirebaseAuthException catch (e) {
      showErrorAlert(context, e.message.toString());
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: navyBlue,
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width * 0.9,
          height: MediaQuery.of(context).size.height * 0.3,
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
          padding: const EdgeInsets.all(40),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const Text(
                  "Enter your email to reset password",
                  textAlign: TextAlign.center,
                ),
                TextField(
                  controller: _gmailController,
                  decoration: const InputDecoration(
                    prefixIcon: Icon(Icons.email),
                    labelText: "Gmail",
                    labelStyle: TextStyle(color: Colors.grey),
                  ),
                ),
                const SizedBox(
                  height: 10,
                ),
                ElevatedButton(
                  onPressed: () {
                    resetPassword();
                  },
                  child: const Text("Reset Password"),
                ),
                const SizedBox(
                  height: 20,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
