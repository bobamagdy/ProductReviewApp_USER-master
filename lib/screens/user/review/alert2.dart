import 'package:flutter/material.dart';

class AlertSecondDialogWidget extends StatefulWidget {
  @override
  _AlertSecondDialogWidgetState createState() =>
      _AlertSecondDialogWidgetState();
}

class _AlertSecondDialogWidgetState extends State<AlertSecondDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thank you ♥'),
      content: Text(
        "sorry this is second review for u \n Warning, you can not add more than one comment for the same product but you can update it",
      ),
      actions: [
        OutlineButton(
          onPressed: () => Navigator.of(context).pop(),
          child: Text('Close'),
        )
      ],
    );
  }
}
