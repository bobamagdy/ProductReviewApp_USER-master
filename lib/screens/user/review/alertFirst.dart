import 'package:flutter/material.dart';

class AlertFirstDialogWidget extends StatefulWidget {
  @override
  _AlertFirstDialogWidgetState createState() => _AlertFirstDialogWidgetState();
}

class _AlertFirstDialogWidgetState extends State<AlertFirstDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thank you ♥'),
      content: Text(
        "Your comment has been added from now, you can edit or delete the comment, it is saved sucessfully,\n Warning, you can not add more than one comment for the same product ",
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
