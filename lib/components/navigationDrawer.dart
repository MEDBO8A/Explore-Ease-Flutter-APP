// ignore_for_file: must_be_immutable, prefer_const_constructors, use_build_context_synchronously

import 'package:explore_ease/model/user.dart';
import 'package:explore_ease/pages/community_page.dart';
import 'package:explore_ease/pages/customerSupport_page.dart';
import 'package:explore_ease/pages/favorite_page.dart';
import 'package:explore_ease/pages/profile_page.dart';
import 'package:explore_ease/pages/signin_page.dart';
import 'package:explore_ease/services/authServices.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NavigationDrawerBar extends StatelessWidget {
  NavigationDrawerBar({Key? key});
  AuthServices auth = AuthServices();
  UserModel? user = UserModel.current;

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Material(
        color: Colors.black,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            children: [
              Expanded(
                child: ListView(
                  children: [
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 35,
                            backgroundImage: user != null
                                ? NetworkImage(user!.profPic)
                                : null,
                          ),
                          SizedBox(
                            width: 15,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                user!.username,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                              SizedBox(
                                height: 15,
                              ),
                              Text(
                                user!.mail,
                                style: TextStyle(
                                  color: Colors.white,
                                  fontSize: 15,
                                ),
                              ),
                            ],
                          )
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Divider(
                      color: Colors.grey,
                      height: 10,
                      thickness: 1,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.person,
                        color: Colors.white70,
                        size: 20,
                      ),
                      title: Text(
                        "My Account",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyProfilePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: FaIcon(
                        FontAwesomeIcons.heart,
                        color: Colors.white70,
                        size: 20,
                      ),
                      title: Text(
                        "Favorites",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyFavoritePage(),
                          ),
                        );
                      },
                    ),
                    ListTile(
                      leading: Icon(
                        Icons.message_outlined,
                        color: Colors.white70,
                        size: 20,
                      ),
                      title: Text(
                        "Community Chat",
                        style: TextStyle(
                            color: Colors.white,
                            fontWeight: FontWeight.bold,
                            fontSize: 15),
                      ),
                      onTap: () {
                        Navigator.of(context).push(
                          MaterialPageRoute(
                            builder: (context) => MyCommunityPage(),
                          ),
                        );
                      },
                    ),
                  ],
                ),
              ),
              Divider(
                color: Colors.grey,
                height: 10,
                thickness: 1,
              ),
              SizedBox(
                height: 20,
              ),
              ListTile(
                leading: Icon(
                  Icons.support_agent,
                  color: Colors.white70,
                  size: 20,
                ),
                title: Text(
                  "Customer Support",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                onTap: () {
                  Navigator.of(context).push(
                    MaterialPageRoute(
                      builder: (context) => MySupportPage(),
                    ),
                  );
                },
              ),
              ListTile(
                leading: FaIcon(
                  FontAwesomeIcons.powerOff,
                  color: Colors.white70,
                  size: 20,
                ),
                title: Text(
                  "Log Out",
                  style: TextStyle(
                      color: Colors.white,
                      fontWeight: FontWeight.bold,
                      fontSize: 15),
                ),
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return AlertDialog(
                        title: Text(
                          "Log Out",
                          style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                            fontSize: 22,
                          ),
                        ),
                        content: Text(
                          "Confirme to log out",
                          style: TextStyle(
                            color: Colors.black,
                            fontSize: 18,
                          ),
                        ),
                        actions: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                            children: [
                              Container(
                                height: 40,
                                width: 80,
                                child: FloatingActionButton(
                                  onPressed: () async {
                                    await auth.signOut();
                                    Navigator.of(context).pop();
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) => MySigninPage(),
                                      ),
                                    );
                                  },
                                  child: Text(
                                    "Yes",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                              Container(
                                height: 40,
                                width: 80,
                                child: FloatingActionButton(
                                  onPressed: () {
                                    Navigator.of(context).pop();
                                  },
                                  child: Text(
                                    "No",
                                    style: TextStyle(
                                      color: Colors.black,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 15,
                                    ),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ],
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
