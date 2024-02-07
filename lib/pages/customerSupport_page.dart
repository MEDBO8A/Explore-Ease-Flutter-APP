import 'package:flutter/material.dart';

class MySupportPage extends StatefulWidget {
  const MySupportPage({super.key});

  @override
  State<MySupportPage> createState() => _MySupportPageState();
}

class _MySupportPageState extends State<MySupportPage> {
  Color navyBlue = const Color(0xFF000080);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: MediaQuery.of(context).size.height * 0.05,
        iconTheme: IconThemeData(color: Colors.black87),
        backgroundColor: Colors.white60,
        centerTitle: true,
        title: Text(
          "Customer Support",
          style: TextStyle(
            color: navyBlue,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Expanded(
          child: Center(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Container(
                width: MediaQuery.of(context).size.width * 0.88,
                height: MediaQuery.of(context).size.height * 0.76,
                decoration: BoxDecoration(
                  boxShadow: const [
                    BoxShadow(
                        blurRadius: 5,
                        spreadRadius: 7,
                        color: Color.fromARGB(169, 158, 158, 158),
                        offset: Offset(2, 3)),
                  ],
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(
                    color: Colors.black,
                    width: 1,
                  ),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(20),
                  child: Column(
                    children: [
                      const Align(
                        alignment: Alignment.topLeft,
                        child: Text(
                          "Contact us ",
                          style: TextStyle(
                            fontSize: 25,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Full Name",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      const DropDownMenu(),
                      const SizedBox(
                        height: 15,
                      ),
                      Container(
                        height: MediaQuery.of(context).size.height * 0.2,
                        padding: const EdgeInsets.only(left: 10),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: Colors.white,
                        ),
                        child: const TextField(
                          decoration: InputDecoration(
                            border: InputBorder.none,
                            labelText: "Description",
                            labelStyle: TextStyle(
                              color: Colors.grey,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.85,
                        height: MediaQuery.of(context).size.height * 0.07,
                        child: ElevatedButton(
                          style: ElevatedButton.styleFrom(
                            foregroundColor: Colors.white,
                            backgroundColor: Colors.black,
                            padding: const EdgeInsets.all(15),
                          ),
                          onPressed: () {},
                          child: const Text(
                            "Send",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 15,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class DropDownMenu extends StatefulWidget {
  const DropDownMenu({super.key});

  @override
  _DropDownMenuState createState() => _DropDownMenuState();
}

class _DropDownMenuState extends State<DropDownMenu> {
  String _selectedItem = 'Bug Report';
  bool _showAdditionalTextField = false;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Align(
          alignment: Alignment.topLeft,
          child: Text(
            'Subject',
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
        const SizedBox(height: 20),
        PopupMenuButton<String>(
          itemBuilder: (BuildContext context) {
            return <PopupMenuEntry<String>>[
              const PopupMenuItem<String>(
                value: 'Bug Report',
                child: Text('Bug Report'),
              ),
              const PopupMenuItem<String>(
                value: 'Future Suggestion',
                child: Text('Future Suggestion'),
              ),
              const PopupMenuItem<String>(
                value: 'Other',
                child: Text('Other'),
              ),
            ];
          },
          onSelected: (String value) {
            setState(() {
              _selectedItem = value;
              _showAdditionalTextField = value == 'Other';
            });
          },
          child: Container(
            padding: const EdgeInsets.all(15),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.grey[200], // Background color of the dropdown menu
            ),
            child: Row(
              children: [
                Text(
                  _selectedItem,
                  style: const TextStyle(
                    fontSize: 17,
                    color: Colors.black, // Text color
                  ),
                ),
                const Icon(Icons.arrow_drop_down),
              ],
            ),
          ),
        ),
        if (_showAdditionalTextField) ...[
          const SizedBox(height: 15),
          Container(
            padding: const EdgeInsets.only(left: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              color: Colors.white,
            ),
            child: const TextField(
              decoration: InputDecoration(
                border: InputBorder.none,
                labelText: "Additionnal Informations",
                labelStyle: TextStyle(
                  color: Colors.grey,
                ),
              ),
            ),
          ),
        ],
      ],
    );
  }
}
