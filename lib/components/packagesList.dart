import 'package:explore_ease/pages/home_page.dart';
import 'package:flutter/material.dart';
import 'package:explore_ease/components/packageListView.dart';

class MyPackagesList extends StatefulWidget {
  final String value;
  const MyPackagesList({super.key, required this.value});

  @override
  State<MyPackagesList> createState() => _PackagesState();
}

class _PackagesState extends State<MyPackagesList> {
  Color navyBlue = const Color(0xFF000080);
  final themes = ["Beach", "Desert", "Historic", "Island", "Mount"];

  content() {
    if (widget.value == "U.A.E") {
      return MyListView(packName: "country_UAE",page: 2,);
    }
    if (themes.contains(widget.value)) {
      return MyListView(packName: "package_${widget.value.toLowerCase()}",page: 1,);
    } else {
      return MyListView(packName: "country_${widget.value.toLowerCase()}",page: 2,);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white60,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Text(
          "${widget.value} Packages",
          style: TextStyle(
            color: navyBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
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
      body: content(),
    );
  }
}
