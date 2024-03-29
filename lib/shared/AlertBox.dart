import 'package:flutter/material.dart';

class Alert{
  Future<void> showAlert(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Any unsaved changes might be lost, please ensure that you have saved your recipe as a draft.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  Future<void> showAlertforEditDraft(BuildContext context) async {
    return showDialog<void>(
      context: context,
      barrierDismissible: true, // user must tap button!
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(
            'Alert!',
            style: TextStyle(fontWeight: FontWeight.bold),
          ),
          content: SingleChildScrollView(
            child: ListBody(
              children: <Widget>[
                Text('Any unsaved changes might be lost, please ensure that you have saved your recipe as a draft.'),
              ],
            ),
          ),
          actions: <Widget>[
            FlatButton(
              child: Text('Yes'),
              onPressed: () {
                Navigator.of(context).pop();
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }
}
