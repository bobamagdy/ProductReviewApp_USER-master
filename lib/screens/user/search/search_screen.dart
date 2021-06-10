import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'search.dart';

class Search extends StatefulWidget {
  static const roteName = '/search';
  @override
  _SearchState createState() => _SearchState();
}

class _SearchState extends State<Search> {
  final TextEditingController searchcontroller = TextEditingController();
  QuerySnapshot snapshotData;
  bool IsExcecuted = false;
  @override
  Widget build(BuildContext context) {
    Widget searchedData() {
      return ListView.builder(
          itemCount: snapshotData.docs.length,
          itemBuilder: (BuildContext context, int index) {
            return ListTile(
              leading: CircleAvatar(
                backgroundImage:
                    NetworkImage(snapshotData.docs[index].data()['image']),
              ),
              title: Text(snapshotData.docs[index].data()['name'],
                  style: TextStyle(
                      color: Colors.black,
                      fontWeight: FontWeight.bold,
                      fontSize: 24)),
            );
          });
    }

    return Scaffold(
        floatingActionButton: FloatingActionButton(
          child: Icon(Icons.clear),
          onPressed: () {
            setState(() {
              IsExcecuted = false;
            });
          },
        ),
        appBar: AppBar(
          actions: [
            GetBuilder<DataController>(
              init: DataController(),
              builder: (val) {
                return IconButton(
                    icon: Icon(Icons.search, color: Colors.black),
                    onPressed: () {
                      val.queryData(searchcontroller.text).then((Value) {
                        snapshotData = Value;
                        setState(() {
                          IsExcecuted = true;
                        });
                      });
                    });
              },
            )
          ],
          title: TextField(
            style: TextStyle(color: Colors.orange),
            decoration: InputDecoration(
                hintText: 'search.....',
                hintStyle: TextStyle(color: Colors.lightBlue)),
            controller: searchcontroller,
          ),
          backgroundColor: Colors.white,
          elevation: 2,
        ),
        body: IsExcecuted
            ? searchedData()
            : Container(
                child: Center(
                  child: Text(
                    'search any product or category',
                    style: TextStyle(fontSize: 15, color: Colors.lightBlue),
                  ),
                ),
              ));
  }
}
