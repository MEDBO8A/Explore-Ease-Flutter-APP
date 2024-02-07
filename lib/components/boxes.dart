// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, must_be_immutable, library_private_types_in_public_api

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_ease/model/user.dart';
import 'package:explore_ease/pages/package_page.dart';
import 'package:explore_ease/services/authServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class CategorieBox extends StatelessWidget {
  final String name;
  final String image;
  final VoidCallback onTap;
  const CategorieBox(
      {super.key,
      required this.name,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.all(7),
        padding: const EdgeInsets.only(right: 7, top: 5, bottom: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              blurStyle: BlurStyle.normal,
              color: Color.fromARGB(68, 0, 0, 0),
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        height: 45,
        child: Row(
          children: [
            CircleAvatar(
              backgroundImage: AssetImage(image),
            ),
            SizedBox(
              width: 3,
            ),
            Text(
              name,
              style: TextStyle(fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}

class CountryBox extends StatelessWidget {
  final String country;
  final num number;
  final String image;
  final VoidCallback onTap;

  const CountryBox(
      {super.key,
      required this.country,
      required this.number,
      required this.image,
      required this.onTap});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        GestureDetector(
          onTap: onTap,
          child: Container(
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              boxShadow: const [
                BoxShadow(
                  blurRadius: 6,
                  blurStyle: BlurStyle.normal,
                  color: Color.fromARGB(68, 0, 0, 0),
                  spreadRadius: 1,
                  offset: Offset(0, 1),
                ),
              ],
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(20),
              child: Stack(
                children: [
                  Image.network(
                    image,
                    fit: BoxFit.cover,
                    height: MediaQuery.of(context).size.height * 0.22,
                    width: MediaQuery.of(context).size.width * 0.33,
                  ),
                  Positioned(
                    left: 10,
                    bottom: 12,
                    child: Container(
                      padding: EdgeInsets.all(5),
                      height: MediaQuery.of(context).size.height * 0.07,
                      width: MediaQuery.of(context).size.width * 0.26,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10),
                        color: Colors.black26,
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            country,
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 15,
                              color: Colors.white,
                            ),
                          ),
                          SizedBox(
                            height: 3,
                          ),
                          Text(
                            " $number Packages",
                            style: const TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 11,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
        SizedBox(
          width: 10,
        ),
      ],
    );
  }
}

class PopularPackageBox extends StatelessWidget {
  final String placeID;
  final String name;
  final String city;
  final String country;
  final String image;
  final num rate;
  final num rateNB;
  final num price;
  const PopularPackageBox({
    super.key,
    required this.placeID,
    required this.name,
    required this.city,
    required this.country,
    required this.image,
    required this.rate,
    required this.rateNB,
    required this.price,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyPackagePage(
              page: 5,
              placeID: placeID,
              city: city,
              country: country,
              image: image,
              name: name,
              rate: rate,
              rateNB: rateNB,
              price: price,
            ),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(right: 20, top: 5, bottom: 5),
        padding: EdgeInsets.only(right: 7),
        height: MediaQuery.of(context).size.height * 0.1,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              blurStyle: BlurStyle.normal,
              color: Color.fromARGB(68, 0, 0, 0),
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Row(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    image,
                    width: MediaQuery.of(context).size.width * 0.25,
                    height: MediaQuery.of(context).size.height * 0.1,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 0,
                  left: 4,
                  child: Container(
                    margin: EdgeInsets.only(bottom: 20),
                    padding: EdgeInsets.all(6),
                    decoration: BoxDecoration(
                      color: Color.fromARGB(69, 99, 103, 105),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          Icons.star_border_outlined,
                          size: 15,
                          color: Colors.white,
                        ),
                        Text(
                          " $rate ",
                          style: TextStyle(
                            fontWeight: FontWeight.w500,
                            fontSize: 12,
                            color: Colors.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
            SizedBox(
              width: 5,
            ),
            Container(
              padding: EdgeInsets.all(3),
              child: Column(
                children: [
                  SizedBox(
                    height: 5,
                  ),
                  Text(
                    name,
                    style: TextStyle(fontWeight: FontWeight.w600, fontSize: 17),
                  ),
                  SizedBox(
                    height: 5,
                  ),
                  Row(
                    children: [
                      Icon(
                        Icons.place,
                        size: 20,
                        color: const Color.fromARGB(181, 0, 0, 0),
                      ),
                      Text(
                        "$city, $country",
                        style: TextStyle(
                          fontWeight: FontWeight.w500,
                          fontSize: 14,
                          color: const Color.fromARGB(181, 0, 0, 0),
                        ),
                      ),
                    ],
                  ),
                  SizedBox(
                    height: 5,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class PackageBox extends StatefulWidget {
  final int page;
  final String placeID;
  final String name;
  final String city;
  final String country;
  final String image;
  final num rate;
  final num rateNB;
  final num price;
  final VoidCallback? onFavoriteChanged;

  const PackageBox({
    Key? key,
    required this.page,
    required this.placeID,
    required this.name,
    required this.city,
    required this.country,
    required this.image,
    required this.rate,
    required this.rateNB,
    required this.price,
    this.onFavoriteChanged,
  }) : super(key: key);

  @override
  _PackageBoxState createState() => _PackageBoxState();
}

class _PackageBoxState extends State<PackageBox> {
  UserModel? currentUser;
  CollectionReference userColl = FirebaseFirestore.instance.collection("user");

  @override
  void initState() {
    super.initState();
    currentUser = UserModel.current;
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => MyPackagePage(
              page: widget.page,
              placeID: widget.placeID,
              city: widget.city,
              country: widget.country,
              image: widget.image,
              name: widget.name,
              rate: widget.rate,
              rateNB: widget.rateNB,
              price: widget.price,
            ),
          ),
        );
      },
      child: Container(
        margin: const EdgeInsets.all(7),
        width: MediaQuery.of(context).size.width * 0.9,
        height: MediaQuery.of(context).size.height * 0.29,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(20),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              blurRadius: 6,
              blurStyle: BlurStyle.normal,
              color: Color.fromARGB(68, 0, 0, 0),
              spreadRadius: 1,
              offset: Offset(0, 1),
            ),
          ],
        ),
        child: Column(
          children: [
            Stack(
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(20),
                  child: Image.network(
                    widget.image,
                    width: MediaQuery.of(context).size.width * 0.97,
                    height: MediaQuery.of(context).size.height * 0.2,
                    fit: BoxFit.cover,
                  ),
                ),
                Positioned(
                  top: 8,
                  right: 8,
                  child: IconButton(
                    onPressed: () async{
                      if (currentUser!.favorite!.contains(widget.placeID)) {
                        setState(() {
                          currentUser!.favorite!.remove(widget.placeID);
                        });
                      } else {
                        setState(() {
                          currentUser!.favorite!.add(widget.placeID);
                        });
                      }

                      await userColl.doc(currentUser!.id).update({"favorite":currentUser!.favorite});

                      widget.onFavoriteChanged?.call();
                    },
                    icon: Icon(
                      Icons.favorite,
                      color: currentUser!.favorite!.contains(widget.placeID)
                          ? Colors.red
                          : Colors.white,
                      size: 27,
                    ),
                  ),
                ),
              ],
            ),
            SizedBox(
              width: 5,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Container(
                      padding: EdgeInsets.all(6),
                      decoration: BoxDecoration(
                        color: Colors.lightBlue[800],
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        children: [
                          Icon(
                            Icons.star_border_outlined,
                            size: 15,
                            color: Colors.white,
                          ),
                          Text(
                            " ${widget.rate} ",
                            style: TextStyle(
                              fontWeight: FontWeight.w500,
                              fontSize: 12,
                              color: Colors.white,
                            ),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      width: 10,
                    ),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        SizedBox(
                          height: 3,
                        ),
                        Text(
                          " ${widget.name}",
                          style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18,
                          ),
                        ),
                        Row(
                          children: [
                            Icon(
                              Icons.place,
                              size: 20,
                              color: const Color.fromARGB(181, 0, 0, 0),
                            ),
                            Text(
                              "${widget.city}, ${widget.country}",
                              style: TextStyle(
                                fontWeight: FontWeight.w500,
                                fontSize: 14,
                                color: const Color.fromARGB(181, 0, 0, 0),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 5,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
