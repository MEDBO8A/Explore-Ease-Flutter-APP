import 'package:flutter/material.dart';

class MyCommunityPage extends StatefulWidget {
  const MyCommunityPage({super.key});

  @override
  State<MyCommunityPage> createState() => _MyCommunityPageState();
}

class _MyCommunityPageState extends State<MyCommunityPage> {
  Color navyBlue = const Color(0xFF000080);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        iconTheme: const IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white60,
        centerTitle: true,
        title: Text(
          "Community Chat",
          style: TextStyle(
            color: navyBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }
}
