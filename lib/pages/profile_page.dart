// ignore_for_file: deprecated_member_use, prefer_const_literals_to_create_immutables, prefer_const_constructors, use_build_context_synchronously

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_ease/components/popup.dart';
import 'package:explore_ease/model/user.dart';
import 'package:explore_ease/pages/home_page.dart';
import 'package:explore_ease/services/dataBaseServices.dart';
import 'package:explore_ease/services/loadingWidget.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class MyProfilePage extends StatefulWidget {
  const MyProfilePage({super.key});

  @override
  State<MyProfilePage> createState() => _MyProfilePageState();
}

class _MyProfilePageState extends State<MyProfilePage> {
  final Color navyBlue = const Color(0xFF000080);

  UserModel? user = UserModel.current;
  final CollectionReference usersCollection =
  FirebaseFirestore.instance.collection('user');

  @override
  void initState() {
    super.initState();
  }

  Future<void> selectAndUploadImage() async {
    final imagePicker = ImagePicker();

    final XFile? image =
        await imagePicker.pickImage(source: ImageSource.gallery);

    loading(context);

    if (image != null) {
      Reference ref = FirebaseStorage.instance
          .ref()
          .child('profile_images')
          .child('${user!.id}.jpg');

      await ref.putFile(File(image.path));

      String imageUrl = await ref.getDownloadURL();

      final CollectionReference usersCollection =
      FirebaseFirestore.instance.collection('user');
      await usersCollection.doc(user!.id).update({'profPic': imageUrl});

    }
    final userr = await DBServices().getUser(user!.id);
    setState(() {
      user = userr;
    });
    Navigator.pop(context);

  }

  Future showEditField(BuildContext context, String field) async {
    TextEditingController textController = TextEditingController();
    String newValue = "";

    await showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: Text("Edit $field"),
        content: TextField(
          controller: textController,
          onChanged: (e) {
            newValue = e;
          },
          decoration: const InputDecoration(
            hintText: "Enter new value here",
            hintStyle: TextStyle(
              color: Colors.grey,
            ),
          ),
        ),
        actions: [
          ElevatedButton(
            onPressed: () {
              Navigator.of(context).pop(newValue); // Cancel button
            },
            child: const Text("Cancel"),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
            },
            child: const Text("Edit"),
          ),
        ],
      ),
    );
    if (newValue.trim().isNotEmpty){
      await usersCollection.doc(user!.id).update({field:newValue});

    final userr = await DBServices().getUser(user!.id);
    setState(() {
      user = userr;
    });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: navyBlue,
        iconTheme: IconThemeData(color: Colors.white),
        title: const Text(
          "Profile ",
          style: TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.bold,
            fontSize: 30,
          ),
        ),
        centerTitle: true,
        automaticallyImplyLeading: false,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MyHomePage(),
              ),
            );
          },
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Center(
          child: Column(
            children: [
              Container(
                color: navyBlue,
                child: Column(
                  children: [
                    SizedBox(
                      height: MediaQuery.of(context).size.height * 0.05,
                    ),
                    Stack(
                      children: [
                        Container(
                          height: 100,
                          width: 100,
                          decoration: BoxDecoration(
                            image: DecorationImage(
                              image: NetworkImage(
                                user!.profPic,
                              ),
                              fit: BoxFit.cover,
                            ),
                            border: Border.all(
                              color: Colors.white,
                              width: 2,
                            ),
                            borderRadius: BorderRadius.circular(50),
                          ),
                        ),
                        Positioned(
                          bottom: -10,
                          right: -5,
                          child: IconButton(
                            onPressed: () {
                              selectAndUploadImage();
                            },
                            icon: Container(
                              padding: const EdgeInsets.all(3),
                              decoration: BoxDecoration(
                                color: Color.fromARGB(255, 48, 19, 126),
                                border: Border.all(
                                  color: Colors.white,
                                  width: 2,
                                ),
                                borderRadius: BorderRadius.circular(50),
                              ),
                              child: const Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                                size: 17,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user!.username,
                            style: const TextStyle(
                              fontSize: 25.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showEditField(context, "username");
                              },
                              icon: const Icon(
                                Icons.create_outlined,
                                size: 15,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            user!.bio,
                            style: const TextStyle(
                              fontSize: 15.0,
                              fontWeight: FontWeight.bold,
                              color: Colors.white,
                            ),
                          ),
                          IconButton(
                              onPressed: () {
                                showEditField(context, "bio");
                              },
                              icon: const Icon(
                                Icons.create_outlined,
                                size: 15,
                                color: Colors.white,
                              ))
                        ],
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Container(
                      width: MediaQuery.of(context).size.width,
                      height: MediaQuery.of(context).size.height * 0.8,
                      decoration: const BoxDecoration(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                          topRight: Radius.circular(30.0),
                        ),
                        color: Colors.white,
                      ),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 10,
                          ),
                          const Text(
                            "Booked Packages",
                            style: TextStyle(
                                fontWeight: FontWeight.w700,
                                fontSize: 20,
                                color: Colors.black87),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 10),
                            child: Align(
                              alignment: Alignment.centerLeft,
                              child: Column(
                                children: [],
                              ),
                            ),
                          ),
                        ],
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
