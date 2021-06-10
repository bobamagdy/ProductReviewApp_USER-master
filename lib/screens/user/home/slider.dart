import 'package:flutter/material.dart';

class listview extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      //width: double.infinity,
      child: ListView(
        scrollDirection: Axis.horizontal,
        children: [
          MyListView(
            img_location: 'assets/1.jpg',
          ),
          MyListView(
            img_location: 'assets/2.jpg',
          ),
          MyListView(
            img_location: 'assets/3.jpg',
          ),
          MyListView(
            img_location: 'assets/4.jpg',
          ),
        ],
      ),
    );
  }
}

class MyListView extends StatelessWidget {
  final String img_location;

  const MyListView({this.img_location});
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 300,
      child: InkWell(
        onTap: () {},
        child: ListTile(
          title: Image.asset(img_location),
        ),
      ),
    );
  }
}
