import 'package:admin/screens/user/userFunctionality/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class BlockAlertDialogWidget extends StatefulWidget {
  @override
  _BlockAlertDialogWidgetState createState() => _BlockAlertDialogWidgetState();
}

class _BlockAlertDialogWidgetState extends State<BlockAlertDialogWidget> {
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Text('Thank you ♥'),
      content: Text(
        "From now you are blocked from your application",
      ),
      actions: [
        OutlineButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => LoginScreen(),
                ));
          },
          child: Text('Close'),
        )
      ],
    );
  }
}
