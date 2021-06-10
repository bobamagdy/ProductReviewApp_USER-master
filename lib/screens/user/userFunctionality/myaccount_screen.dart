import 'dart:io';
import 'package:admin/services/authentication.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:admin/services/authentication.dart';
import 'package:admin/screens/user/home/navigationBar.dart';

class MyaccountScreen extends StatefulWidget {
  static const roteName = '/profile';
  @override
  MyaccountScreenState createState() => MyaccountScreenState();
}

class MyaccountScreenState extends State<MyaccountScreen> {
  void _showErrorDialog(String msg) {
    showDialog(
      context: context,
      builder: (ctx) => AlertDialog(
        title: Text('An error occured'),
        content: Text(msg),
        actions: <Widget>[
          FlatButton(
            child: Text('Okay'),
            onPressed: () {
              Navigator.of(ctx).pop();
            },
          )
        ],
      ),
    );
  }

  Future<void> _onClicked() async {
    File _image;
    final picker = ImagePicker();
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
        changePhoto(_image);
      } else {
        _showErrorDialog('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          elevation: 1,
          leading: IconButton(
            icon: Icon(
              Icons.arrow_back_ios_outlined,
              color: Colors.blueGrey[900],
            ),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (_) => MyBottomNavigationBar()));
            },
          ),
          title:
              Text('My Account', style: TextStyle(color: Colors.blueGrey[900])),
          centerTitle: true,
        ),
        body: FutureBuilder(
            future: retrieveUserData(),
            builder: (context, snapshot) {
              if (!(snapshot.connectionState == ConnectionState.done)) {
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
              } else {
                if (snapshot.hasError) {
                  return Text("ERRRRRRRRROOOOORRRRRR");
                }
                if (snapshot.hasData) {
                  return SingleChildScrollView(
                      child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 20),
                          child: Column(children: [
                            SizedBox(
                              height: 20,
                            ),
                            // Container(
                            //   height: 120,
                            //   width: 200,
                            //   child: new FlatButton(
                            //       // onPressed:var arg = '${snapshot.data['Username']}';_onClicked,
                            //       child: Column(
                            //           crossAxisAlignment: CrossAxisAlignment
                            //               .stretch, // add this
                            //           children: <Widget>[
                            //         ClipRRect(
                            //           borderRadius: BorderRadius.only(
                            //               topLeft: Radius.circular(10.0),
                            //               topRight: Radius.circular(10.0),
                            //               bottomLeft: Radius.circular(10.0),
                            //               bottomRight: Radius.circular(10.0)),
                            //           child: Image.network(
                            //               '${snapshot.data['ImageUrl']}',
                            //               width: 200,
                            //               height: 118,
                            //               fit: BoxFit.fill),
                            //         ),
                            //       ])),
                            // ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                              height: 280,
                              width: 350,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                    width: 1,
                                    color: Colors.grey,
                                  ),
                                  borderRadius: BorderRadius.circular(15)),
                              child: Padding(
                                padding: const EdgeInsets.only(right: 130),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 20,
                                    ),
                                    Row(
                                      children: [
                                        SizedBox(
                                          width: 20,
                                        ),
                                        Text('PERSONAL INFORMATION'),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    Text(
                                      'User Name :' +
                                          '${snapshot.data['Username']}',
                                      style: TextStyle(
                                          color: Colors.blueGrey[900],
                                          fontWeight: FontWeight.w500,
                                          fontFamily: "Montserrat",
                                          fontSize: 15.0),
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        'Phone :' + '${snapshot.data['Phone']}',
                                        style: TextStyle(
                                            color: Colors.blueGrey[900],
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 15.0)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Text(
                                        'Email :' + '${snapshot.data['Email']}',
                                        style: TextStyle(
                                            color: Colors.blueGrey[900],
                                            fontWeight: FontWeight.w500,
                                            fontFamily: "Montserrat",
                                            fontSize: 15.0)),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    SizedBox(
                                      height: 30,
                                    ),
                                    FlatButton(
                                      onPressed: () {},
                                      color: Colors.lightGreen,
                                      child: Text('Edit'),
                                      textColor: Colors.white,
                                    )
                                  ],
                                ),
                              ),
                            ),
                            SizedBox(
                              height: 20,
                            ),
                            Container(
                                height: 125,
                                width: 350,
                                decoration: BoxDecoration(
                                    border: Border.all(
                                      width: 1,
                                      color: Colors.grey,
                                    ),
                                    borderRadius: BorderRadius.circular(15)),
                                child: Padding(
                                  padding: const EdgeInsets.only(right: 140),
                                  child: Column(
                                    children: [
                                      SizedBox(
                                        height: 15,
                                      ),
                                      Text('SECURITY INFORMATION'),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      FlatButton(
                                        onPressed: () {},
                                        color: Colors.lightGreen,
                                        child: Text('change password'),
                                        textColor: Colors.white,
                                      )
                                    ],
                                  ),
                                ))
                          ])));
                }
              }
            }));
  }
}
// static UserClass userclass;
// static DocumentSnapshot allDocuments;
// static getUser() async {
//   userclass = new UserClass();
//   try {
//     var document = (await retrieveUserData());
//     print("we are here");
//     print(document);
//     // print(document['Username'] + 'noooooooooooooooooooooour');
//     // userclass.username = document['Username'];
//     // userclass.email = document['Email'];
//     // userclass.image = document['ImageUrl'];
//     // userclass.phone = document['Phone'];
//     // userclass.uid = document['uid'];
//     // print("Retrievvvvvvvvvvvvvvved");
//     // print("hellooooooooooooo");
//   } catch (e) {
//     print("exception is" + e);
//   }
// }
