import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:explore_ease/components/boxes.dart';
import 'package:firebase_database/firebase_database.dart';
import 'package:firebase_database/ui/firebase_animated_list.dart';
import 'package:flutter/material.dart';

class MyListView extends StatelessWidget {
  final String packName;
  final int page;

  MyListView({
    super.key,
    required this.packName,
    required this.page,
  });

  @override
  Widget build(BuildContext context) {
    final CollectionReference collection =
    FirebaseFirestore.instance.collection(packName);

    return StreamBuilder<QuerySnapshot>(
      stream: collection.snapshots(),
      builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return CircularProgressIndicator();
        }

        if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        }

        final List<QueryDocumentSnapshot> documents = snapshot.data!.docs;

        return ListView.builder(
          itemCount: documents.length,
          itemBuilder: (context, index) {
            Map<String, dynamic> data = documents[index].data()! as Map<
                String,
                dynamic>;

            return PackageBox(
              page: page,
              placeID: data["placeID"] ?? "",
              name: data["placeName"] ?? "",
              city: data["city"] ?? "",
              country: data["country"] ?? "",
              image: data["imageUrl"] ?? "",
              rate: data["rate"] ?? 0,
              rateNB: data["rateNB"] ?? 0,
              price: data["price"] ?? 0,
            );
          },
        );
      },
    );
  }
}
