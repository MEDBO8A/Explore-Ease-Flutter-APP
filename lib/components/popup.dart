import 'package:flutter/material.dart';

class PopUp {
  void popUp(BuildContext context, String text) {
    showDialog(
      context: context,
      builder: (BuildContext builderContext) {
        Future.delayed(Duration(seconds: 3), () {
          Navigator.of(builderContext)
              .pop(); // Close the dialog after 3 seconds
        });

        return AlertDialog(
          title: Text(text),
        );
      },
    );
  }
}
