import 'package:admin/models/product.dart';
import 'package:admin/screens/user/home/navigationBar.dart';
import 'package:admin/screens/user/review/old_reviews.dart';
import 'package:flutter/material.dart';

class ChatScreen extends StatelessWidget {
  Product sendProduct;
  ChatScreen({Key key, @required this.sendProduct}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Chat Screen'),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_outlined,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (_) => MyBottomNavigationBar()));
          },
        ),
      ),
      body: Container(
        child: Column(
          children: [
            Expanded(
              child: MakeReview(),
            ),
            MakeReview(),
          ],
        ),
      ),
    );
  }
}
