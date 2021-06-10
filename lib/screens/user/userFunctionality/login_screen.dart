import 'package:admin/screens/user/home/slider.dart';
import 'package:admin/screens/user/home/navigationBar.dart';
import 'package:admin/screens/user/review/blockAlert.dart';
import 'package:admin/screens/user/search/search_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'package:admin/models/user.dart';
import '../../../services/authentication.dart';
import 'package:admin/screens/user/home/home_screen.dart';

class LoginScreen extends StatefulWidget {
  static const roteName = '/login';

  @override
  State<StatefulWidget> createState() {
    return LoginScreenState();
  }
}

class LoginScreenState extends State<LoginScreen> {
  UserClass newUser;
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();

  Map<String, String> _authData = {'email': '', 'password': ''};
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

  Future<void> _submit() async {
    if (!_formKey.currentState.validate()) {
      return;
    }
    _formKey.currentState.save();
    try {
      login(_authData['email'], _authData['password']);
      print(_authData['email']);
      verifiedUser();
      Navigator.push(
          context, MaterialPageRoute(builder: (_) => MyBottomNavigationBar()));
    } catch (error) {
      var errorMessage = "Login failed";
      _showErrorDialog(errorMessage);
    }
  }
//   "i am sorry for tell you,you are blocked from application because you are broken rules of application";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Login Form'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[Text('Register'), Icon(Icons.person_add)],
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context)
                  .pushReplacementNamed(RegisterScreen.roteName);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient:
                    LinearGradient(colors: [Colors.blueGrey, Colors.blue])),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: 260,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        SizedBox(
                          height: 30,
                        ),
                        //email
                        TextFormField(
                          controller: _emailController,
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@'))
                              return 'invalid email';
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = value;
                          },
                          showCursor: true,
                        ),

                        //password
                        TextFormField(
                          controller: _passwordController,
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty || value.length <= 5)
                              return 'invalid password';
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                        ),

                        //submit
                        RaisedButton(
                          child: Text('Login'),
                          onPressed: () {
                            if (_emailController.text.isNotEmpty &&
                                _passwordController.text.isNotEmpty) {
                              check();
                            } else
                              _showErrorDialog(
                                  "Please enter your username and password!");
                          },
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(30)),
                          color: Colors.blue,
                          textColor: Colors.white,
                        )
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }

  User user = FirebaseAuth.instance.currentUser;

  verifiedUser() {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .set({'state': "verified"}, SetOptions(merge: true));
  }

  check() {
    FirebaseFirestore.instance.collection('User').get().then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          if (docs.docs[i].data()['email'] == _emailController) {
            if (docs.docs[i].data()['state'] == "verified") {
              _submit();
              MyBottomNavigationBar();
            } else if (docs.docs[i].data()['state'] == "blocked") {
              BlockAlertDialogWidget();
            } else {
              _submit();
            }
          } else {
            _submit();
          }
        }
      } else {
        print("new user");
      }
    });
  }
}
