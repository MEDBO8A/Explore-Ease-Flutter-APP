// ignore_for_file: use_build_context_synchronously

import 'package:explore_ease/pages/signin_page.dart';
import 'package:explore_ease/services/authServices.dart';
import 'package:flutter/material.dart';

class MyWelcomePage extends StatefulWidget {
  const MyWelcomePage({Key? key});

  @override
  State<MyWelcomePage> createState() => _MyWelcomePageState();
}

class _MyWelcomePageState extends State<MyWelcomePage> {
  Color navyBlue = const Color(0xFF000080);
  AuthServices auth = AuthServices();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage("lib/images/wallpaperr.jpg"),
              fit: BoxFit.cover,
            ),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Container(
                padding: const EdgeInsets.all(20),
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.2),
                child: const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "𝙀𝙭𝙥𝙡𝙤𝙧𝙚 𝙀𝙖𝙨𝙚",
                      style: TextStyle(
                        fontWeight: FontWeight.bold,
                        fontSize: 40,
                        color: Colors.black,
                      ),
                    ),
                    SizedBox(
                      height: 20,
                    ),
                    Text(
                      "' Life is either a daring adventure or nothing. '",
                      style: TextStyle(
                        fontSize: 20,
                        color: Color.fromARGB(221, 48, 47, 47),
                        fontWeight: FontWeight.w600,
                      ),
                    ),
                  ],
                ),
              ),
              Container(
                margin: EdgeInsets.only(
                    top: MediaQuery.of(context).size.height * 0.27),
                child: Column(
                  children: [
                    
                    const SizedBox(
                      height: 25,
                    ),
                    ElevatedButton(
                      style: ElevatedButton.styleFrom(
                          foregroundColor: navyBlue,
                          backgroundColor: Colors.white,
                          padding: EdgeInsets.symmetric(
                            horizontal:
                                MediaQuery.of(context).size.width * 0.30,
                            vertical: 17,
                          )),
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const MySigninPage(),
                          ),
                        );
                      },
                      child: const Text(
                        "𝙲𝚘𝚗𝚝𝚒𝚗𝚞𝚎",
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 26,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
