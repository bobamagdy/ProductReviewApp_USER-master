import 'package:flutter/material.dart';

class favorite extends StatefulWidget {
  static const roteName = '/favorite';

  @override
  State<StatefulWidget> createState() {
    // TODO: implement createState
    throw UnimplementedError();
  }
}

class _favoriteState extends State<favorite> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Favorite Items'),
          elevation: 0,
          backgroundColor: Colors.blueGrey[500],
          iconTheme: IconThemeData(
            color: Colors.white,
          ),
        ),
        body: SingleChildScrollView(
          child: Text("HELLLLLLLLLLO"),
        ));
  }
}
