import 'package:admin/screens/user/category/category_screen.dart';
import 'package:admin/screens/user/search/search_screen.dart';
import 'package:admin/screens/user/userFunctionality/myaccount_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:admin/models/category.dart';
//import 'package:team_gp/Screens/Admin/category/add.dart';
import 'package:admin/screens/user/userFunctionality/favorite_screen.dart';
import 'package:admin/services/categ.dart';
import 'package:admin/screens/Widget/button.dart';
//import 'package:team_gp/Screens/Admin/category/edit.dart';

import 'slider.dart';

class slider1 extends StatefulWidget {
  static const roteName = '/home';
  @override
  _slider1State createState() => _slider1State();
}

class _slider1State extends State<slider1> {
  final _store = Store();
  final navigatorKey = GlobalKey<NavigatorState>();
/*

@override
  void initState() {
    super.initState();
  }
  */
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //extendBodyBehindAppBar: true,

      appBar: AppBar(
        title: Text('HOME'),
        elevation: 0,
        backgroundColor: Colors.blueGrey[500],
        iconTheme: IconThemeData(
          color: Colors.white,
        ),
      ),

      backgroundColor: Colors.blueGrey[50], //Colors.pink[50],
      body: ListView(
        children: [
          Container(
            height: 200,
            child: ListView(
              padding: EdgeInsets.all(5),
              children: [
                listview(),
              ],
            ),
          ),
          SizedBox(
            height: 5,
          ),
          Container(
            padding: EdgeInsets.only(left: 10),
            child: Row(
              children: [
                Text('CATEGORY',
                    style:
                        TextStyle(fontSize: 15, fontWeight: FontWeight.bold)),
                SizedBox(
                  width: 170,
                ),
                RaisedButton(
                  onPressed: () {},
                  child: Text(
                    'MORE',
                    style: TextStyle(color: Colors.white),
                  ),
                  color: Colors.blueGrey[500],
                ) //(onPressed: (){}, child: Text('MORE'))
              ],
            ),
          ),
          Container(
            width: 400,
            height: 250,
            child: StreamBuilder<QuerySnapshot>(
                stream: _store.loadCategory(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    List<Category> categories = [];
                    for (var doc in snapshot.data.docs) {
                      var data = doc.data();
                      categories.add(Category(
                        id: doc.id,
                        name: data['name'],
                        image: data['image'],
                      ));
                    }

                    return StaggeredGridView.countBuilder(
                        padding:
                            EdgeInsets.symmetric(horizontal: 30, vertical: 30),
                        crossAxisCount: 1,
                        scrollDirection: Axis.horizontal,
                        crossAxisSpacing: 45,
                        mainAxisSpacing: 30,
                        itemCount: categories.length,
                        itemBuilder: (context, index) {
                          return Container(
                            decoration: BoxDecoration(
                              color: Colors.transparent,
                              borderRadius:
                                  BorderRadius.all(Radius.circular(30)),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black38,
                                  offset: const Offset(
                                    5.0,
                                    5.0,
                                  ),
                                  blurRadius: 10.0,
                                  spreadRadius: 2.0,
                                ),
                              ],
                            ),
                            child: Stack(
                              children: [
                                Positioned.fill(
                                  child: ClipRRect(
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(30)),
                                    child: Image(
                                      image: NetworkImage(
                                        categories[index].image,
                                      ),
                                      fit: BoxFit.fill,
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 30,
                                  child: Opacity(
                                    opacity: 0.9,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      height: 60,
                                      color: Colors.white,
                                      child: Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    right: 15.0, left: 2),
                                                child: IconButton(
                                                    icon: Icon(
                                                      Icons.category_rounded,
                                                      size: 40,
                                                    ),
                                                    onPressed: null),
                                              ),
                                              Text(
                                                categories[index]
                                                    .name
                                                    .toUpperCase(),
                                                textAlign: TextAlign.center,
                                                style: TextStyle(
                                                  color: Colors.blueGrey[900],
                                                  fontWeight: FontWeight.bold,
                                                  fontSize: 20,
                                                  letterSpacing: 1,
                                                  height: 2,
                                                ),
                                              )
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          );
                        },
                        staggeredTileBuilder: (index) {
                          return new StaggeredTile.count(
                              1, index.isEven ? 1.2 : 1.6);
                        });
                  } else {
                    return Center(
                      child: Text(
                        'Loading....',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          fontSize: 40.0,
                          color: Colors.blueGrey[900],
                          fontWeight: FontWeight.bold,
                          fontStyle: FontStyle.italic,
                          shadows: [
                            Shadow(
                              blurRadius: 10.0,
                              color: Colors.black54,
                              offset: Offset(5.0, 5.0),
                            ),
                            Shadow(
                              color: Color(0xFFE0F7FA),
                              blurRadius: 10.0,
                              offset: Offset(-5.0, 5.0),
                            )
                          ],
                          letterSpacing: -1.0,
                          wordSpacing: 5.0,
                        ),
                      ),
                    );
                  }
                }),
          ),
          SizedBox(
            height: 40,
          )
        ],
      ),
    );
  }
}
