// ignore_for_file: use_build_context_synchronously, prefer_const_constructors, unnecessary_null_comparison, deprecated_member_use, prefer_const_literals_to_create_immutables, unused_local_variable, sized_box_for_whitespace, unnecessary_string_interpolations

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_ease/components/boxes.dart';
import 'package:explore_ease/components/navigationDrawer.dart';
import 'package:explore_ease/components/packagesList.dart';
import 'package:explore_ease/components/popularPacksList.dart';
import 'package:explore_ease/model/user.dart';
import 'package:explore_ease/pages/profile_page.dart';
import 'package:explore_ease/pages/signin_page.dart';
import 'package:explore_ease/services/authServices.dart';
import 'package:explore_ease/services/dataBaseServices.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:flutter/material.dart';

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key});

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Color navyBlue = const Color(0xFF000080);
  AuthServices auth = AuthServices();
  UserModel? userdata;
  bool show = false;

  @override
  void initState() {
    super.initState();
    getUser();
    getSizes();
    getPopular();
  }

  Future<void> getUser() async {
    try {
      final user = FirebaseAuth.instance.currentUser;
      if (user != null) {
        final userRes = await DBServices().getUser(user.uid);

        if (userRes != null) {
          setState(() {
            userdata = userRes;
            UserModel.current = userRes;
          });
        } else {
          print("User data from DB is null.");
        }
      }
    } catch (e) {
      print("Error getting user: $e");
    }
  }

  Future<void> getPopular() async {
    final CollectionReference packageCollection =
    FirebaseFirestore.instance.collection('packages');
    final CollectionReference popPackCollection =
    FirebaseFirestore.instance.collection('popular');

    // Delete existing documents in the 'popular' collection
    await popPackCollection.get().then((snapshot) {
      for (DocumentSnapshot doc in snapshot.docs) {
        doc.reference.delete();
      }
    });

    // Retrieve documents from the 'packages' collection
    final QuerySnapshot packageSnapshot = await packageCollection.get();

    if (packageSnapshot.docs.isNotEmpty) {
      // Convert the QuerySnapshot to a List<DocumentSnapshot>
      List dataList = packageSnapshot.docs;

      // Sort the list based on the 'rate' property in descending order
      dataList.sort(
            (a, b) => (b.data()!['rate'] as num).compareTo(a.data()!['rate'] as num),
      );

      // Set the top 5 documents in the 'popular' collection without changing the key
      for (int i = 0; i < dataList.length && i < 5; i++) {
        final String placeID = dataList[i].id;
        final Map<String, dynamic> packageData = dataList[i].data()! as Map<String, dynamic>;
        await popPackCollection.doc(placeID).set(packageData);
      }
    }
  }


  num tunisieSize = 0;
  num spainSize = 0;
  num italySize = 0;
  num greeceSize = 0;
  num UAESize = 0;
  num australiaSize = 0;
  num croatiaSize = 0;
  num turkeySize = 0;

  CollectionReference tunisieCollection =
  FirebaseFirestore.instance.collection("country_tunisia");
  CollectionReference spainCollection =
  FirebaseFirestore.instance.collection("country_spain");
  CollectionReference italyCollection =
  FirebaseFirestore.instance.collection("country_italy");
  CollectionReference greeceCollection =
  FirebaseFirestore.instance.collection("country_greece");
  CollectionReference UAECollection =
  FirebaseFirestore.instance.collection("country_UAE");
  CollectionReference australiaCollection =
  FirebaseFirestore.instance.collection("country_australia");
  CollectionReference croatiaCollection =
  FirebaseFirestore.instance.collection("country_croatia");
  CollectionReference turkeyCollection =
  FirebaseFirestore.instance.collection("country_turkey");

  Future<void> getSizes() async {
    await getNodeSize(
        tunisieCollection,
            (list) => setState(() {
          tunisieSize = list.length;
        }));
    await getNodeSize(
        spainCollection,
            (list) => setState(() {
          spainSize = list.length;
        }));
    await getNodeSize(
        italyCollection,
            (list) => setState(() {
          italySize = list.length;
        }));
    await getNodeSize(
        greeceCollection,
            (list) => setState(() {
          greeceSize = list.length;
        }));
    await getNodeSize(
        UAECollection,
            (list) => setState(() {
          UAESize = list.length;
        }));
    await getNodeSize(
        australiaCollection,
            (list) => setState(() {
          australiaSize = list.length;
        }));
    await getNodeSize(
        croatiaCollection,
            (list) => setState(() {
          croatiaSize = list.length;
        }));
    await getNodeSize(
        turkeyCollection,
            (list) => setState(() {
          turkeySize = list.length;
        }));
  }

  Future<void> getNodeSize(
      CollectionReference collection, void Function(List<DocumentSnapshot>) setSize) async {
    QuerySnapshot snapshot = await collection.get();
    setSize(snapshot.docs);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: NavigationDrawerBar(),
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white60,
        centerTitle: true,
        title: Text(
          "Explore Ease",
          style: TextStyle(
            color: navyBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
        actions: [
          /*IconButton(
              onPressed: () async {
                await auth.signOut();
                Navigator.of(context).pop();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MySigninPage(),
                  ),
                );
              },
              icon: Icon(Icons.arrow_back),
              ),
           */
          Padding(
            padding: EdgeInsets.symmetric(horizontal: 10),
            child: GestureDetector(
              child: CircleAvatar(
                radius: 20,
                backgroundImage:
                    userdata != null ? NetworkImage(userdata!.profPic) : null,
              ),
              onTap: () {
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => MyProfilePage(),
                  ),
                );
              },
            ),
          ),
        ],
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Padding(
          padding: EdgeInsets.all(5),
          child: Center(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20, vertical: 10),
                  child: Row(
                    children: [
                      Expanded(
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              "Hello, ${userdata?.username}",
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                                fontSize: 22,
                              ),
                            ),
                            Text(
                              "Explore the beauty of the world ",
                              style: TextStyle(
                                fontWeight: FontWeight.w600,
                                color: Colors.black54,
                                fontSize: 19,
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 45,
                  width: MediaQuery.of(context).size.width * 0.8,
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    boxShadow: const [
                      BoxShadow(
                        blurRadius: 8,
                        blurStyle: BlurStyle.normal,
                        color: Color.fromARGB(68, 0, 0, 0),
                        spreadRadius: 1,
                        offset: Offset(0, 1),
                      ),
                    ],
                  ),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 5),
                    child: TextField(
                      onChanged: (e) {},
                      decoration: InputDecoration(
                        label: Text("Search Here"),
                        prefixIcon: Icon(Icons.search),
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Categories",
                      style: TextStyle(
                          color: const Color.fromARGB(209, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Container(
                    padding: EdgeInsets.all(5),
                    child: Row(
                      children: [
                        CategorieBox(
                          name: "Island",
                          image: "lib/images/island.jpg",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyPackagesList(value: "Island"),
                              ),
                            );
                          },
                        ),
                        CategorieBox(
                          name: "Desert",
                          image: "lib/images/desert.jpg",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyPackagesList(value: "Desert"),
                              ),
                            );
                          },
                        ),
                        CategorieBox(
                          name: "Mount",
                          image: "lib/images/mount.jpg",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyPackagesList(value: "Mount"),
                              ),
                            );
                          },
                        ),
                        CategorieBox(
                          name: "Historic",
                          image: "lib/images/historic.jpg",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyPackagesList(value: "Historic"),
                              ),
                            );
                          },
                        ),
                        CategorieBox(
                          name: "Beach",
                          image: "lib/images/beach.jpeg",
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (context) =>
                                    MyPackagesList(value: "Beach"),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Row(
                    children: [
                      Expanded(
                        child: Text(
                          "Countries",
                          style: TextStyle(
                              color: const Color.fromARGB(209, 0, 0, 0),
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                      ),
                      TextButton(
                        onPressed: () {
                          setState(() {
                            show = !show;
                          });
                        },
                        child: Text(
                          show ? "See Less" : "See All",
                        ),
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.topLeft,
                  child: SingleChildScrollView(
                    scrollDirection: Axis.horizontal,
                    child: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          CountryBox(
                            country: "Tunisia",
                            number: tunisieSize,
                            image:
                                "https://www.shutterstock.com/shutterstock/videos/1108853813/thumb/1.jpg?ip=x480",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyPackagesList(value: "Tunisia"),
                                ),
                              );
                            },
                          ),
                          CountryBox(
                            country: "Spain",
                            number: spainSize,
                            image:
                                "https://images.pexels.com/photos/15429580/pexels-photo-15429580/free-photo-of-bank-of-spain-museum.jpeg?auto=compress&cs=tinysrgb&dpr=1&w=500",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyPackagesList(value: "Spain"),
                                ),
                              );
                            },
                          ),
                          CountryBox(
                            country: "Italy",
                            number: italySize,
                            image:
                                "https://i.pinimg.com/564x/c1/43/ee/c143ee39bf902e66490f789f9767b0f6.jpg",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyPackagesList(value: "Italy"),
                                ),
                              );
                            },
                          ),
                          CountryBox(
                            country: "Greece",
                            number: greeceSize,
                            image:
                                "https://c1.wallpaperflare.com/preview/91/625/233/flag-windmill-greek-flag-ocean.jpg",
                            onTap: () {
                              Navigator.of(context).push(
                                MaterialPageRoute(
                                  builder: (context) =>
                                      MyPackagesList(value: "Greece"),
                                ),
                              );
                            },
                          ),
                          if (show)
                            (Row(
                              children: [
                                CountryBox(
                                  country: "U A E",
                                  number: UAESize,
                                  image:
                                      "https://en.vogue.me/wp-content/uploads/2020/11/flag-promo.jpg",
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyPackagesList(value: "U.A.E"),
                                      ),
                                    );
                                  },
                                ),
                                CountryBox(
                                  country: "Australia",
                                  number: australiaSize,
                                  image:
                                      "https://media.istockphoto.com/id/1090465252/photo/perth-skyline-with-australian-flag.jpg?s=612x612&w=0&k=20&c=Q4WxRlBjxQ5rLx-mL67rgQocgU8ZBUOz1sVaEZm5HFQ=",
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyPackagesList(value: "Australia"),
                                      ),
                                    );
                                  },
                                ),
                                CountryBox(
                                  country: "Croatia",
                                  number: croatiaSize,
                                  image:
                                      "https://c8.alamy.com/comp/K27HHG/croatian-flag-above-the-old-town-of-trogir-croatia-K27HHG.jpg",
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyPackagesList(value: "Croatia"),
                                      ),
                                    );
                                  },
                                ),
                                CountryBox(
                                  country: "Turkey",
                                  number: turkeySize,
                                  image:
                                      "https://images.unsplash.com/photo-1634744285082-ffd1ba014b85?q=80&w=1000&auto=format&fit=crop&ixlib=rb-4.0.3&ixid=M3wxMjA3fDB8MHxzZWFyY2h8MTJ8fHR1cmtpc2glMjBmbGFnfGVufDB8fDB8fHww",
                                  onTap: () {
                                    Navigator.of(context).push(
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            MyPackagesList(value: "Turkey"),
                                      ),
                                    );
                                  },
                                ),
                              ],
                            )),
                        ],
                      ),
                    ),
                  ),
                ),
                SizedBox(
                  height: 10,
                ),
                Padding(
                  padding: const EdgeInsets.all(10.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: Text(
                      "Popular Packages",
                      style: TextStyle(
                          color: const Color.fromARGB(209, 0, 0, 0),
                          fontSize: 20,
                          fontWeight: FontWeight.w600),
                    ),
                  ),
                ),
                Container(
                  width: MediaQuery.of(context).size.width * 0.98,
                  height: MediaQuery.of(context).size.height * 0.11,
                  child: PopularPacksList(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
