// Method that evaluates if the input value is a number.
import 'package:flutter/material.dart';

bool isNumber(String value) {
  return value.isNotEmpty && num.tryParse(value) != null;
}

// Method that shows an alert dialog.
void showAlert(BuildContext context, String title, String message) {
  showDialog(context: context, builder: (context) {
    return AlertDialog(
      title: Text(title),
      content: Text(message),
      actions: <Widget>[
        FlatButton(
          child: Text('Ok'),
          onPressed: () => Navigator.of(context).pop(),
        ),
      ],
    );
  });
}