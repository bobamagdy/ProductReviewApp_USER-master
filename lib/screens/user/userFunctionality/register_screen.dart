import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:admin/services/authentication.dart';
import 'package:image_picker/image_picker.dart';
import 'package:flutter/material.dart';
import 'package:admin/models/user.dart';
import 'login_screen.dart';
import 'package:admin/screens/user/home/home_screen.dart';

class RegisterScreen extends StatefulWidget {
  static const roteName = '/register';

  @override
  State<StatefulWidget> createState() {
    return RegisterScreenState();
  }
}

class RegisterScreenState extends State<RegisterScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey();
  final TextEditingController _passwordController = new TextEditingController();
  final TextEditingController _usernameController = new TextEditingController();
  final TextEditingController _emailController = new TextEditingController();
  final TextEditingController _cpasswordController =
      new TextEditingController();
  final TextEditingController _phoneController = new TextEditingController();

  UserClass newUser;
  Map<String, String> _authData = {
    'username': '',
    'email': '',
    'password': '',
    'phone': '',
    'image': ''
  };
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
      userSetup(_authData['email'], _authData['password'], _authData['phone'],
          _authData['username'], _image);
      Navigator.of(context).pushNamed(slider1.roteName);
      print("Are created???");
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        var errorMessage = 'The password is too weak';
        _showErrorDialog(errorMessage);
      } else if (e.code == 'email-already-in-use') {
        var errorMessage = 'The account is already exist';
        _showErrorDialog(errorMessage);
      }
    } catch (e) {
      var errorMessage = 'Authentication Failed, Please try again Later!';
      _showErrorDialog(errorMessage);
    }
  }

  File _image;
  final picker = ImagePicker();

  Future getImage() async {
    final pickedFile = await picker.getImage(source: ImageSource.gallery);
    setState(() {
      if (pickedFile != null) {
        _image = File(pickedFile.path);
      } else {
        _showErrorDialog('No image selected.');
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    double _screenWidth = MediaQuery.of(context).size.width,
        _screenheight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        title: Text('Register Form'),
        actions: <Widget>[
          FlatButton(
            child: Row(
              children: <Widget>[Text('Login'), Icon(Icons.person)],
            ),
            textColor: Colors.white,
            onPressed: () {
              Navigator.of(context).pushReplacementNamed(LoginScreen.roteName);
            },
          )
        ],
      ),
      body: Stack(
        children: <Widget>[
          Container(
            decoration: BoxDecoration(
                gradient: LinearGradient(
                    colors: [Colors.pinkAccent, Colors.redAccent])),
          ),
          Center(
            child: Card(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10.0)),
              child: Container(
                height: 600,
                width: 300,
                padding: EdgeInsets.all(16),
                child: Form(
                  key: _formKey,
                  child: SingleChildScrollView(
                    child: Column(
                      children: <Widget>[
                        InkWell(
                            onTap: () => {getImage()},
                            child: CircleAvatar(
                              radius: _screenWidth * 0.15,
                              backgroundColor: Colors.white,
                              backgroundImage:
                                  _image == null ? null : FileImage(_image),
                              child: _image == null
                                  ? Icon(Icons.add_photo_alternate,
                                      size: _screenWidth * 0.15,
                                      color: Colors.grey)
                                  : null,
                            )),
                        SizedBox(
                          height: 30,
                        ),

                        //Username
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Username'),
                          keyboardType: TextInputType.name,
                          validator: (value) {
                            if (value.isEmpty ||
                                value.length > 20 ||
                                value.length < 3) {
                              return 'invalid Username';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['username'] = value;
                          },
                        ),

                        //email
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Email'),
                          keyboardType: TextInputType.emailAddress,
                          validator: (value) {
                            if (value.isEmpty || !value.contains('@')) {
                              return 'invalid email';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['email'] = value;
                          },
                        ),

                        //phone
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Phone'),
                          keyboardType: TextInputType.phone,
                          validator: (value) {
                            if (value.isEmpty || value.length > 11) {
                              return 'invalid PhoneNumber';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['phone'] = value;
                          },
                        ),

                        //password
                        TextFormField(
                          decoration: InputDecoration(labelText: 'Password'),
                          obscureText: true,
                          controller: _passwordController,
                          validator: (value) {
                            if (value.isEmpty || value.length <= 5) {
                              return 'invalid password';
                            }
                            return null;
                          },
                          onSaved: (value) {
                            _authData['password'] = value;
                          },
                        ),

                        //confirmpassword
                        TextFormField(
                          decoration:
                              InputDecoration(labelText: 'Confirm Password'),
                          obscureText: true,
                          validator: (value) {
                            if (value.isEmpty ||
                                value != _passwordController.text)
                              return 'invalid password';
                            return null;
                          },
                          onSaved: (value) {},
                        ),

                        //submit
                        RaisedButton(
                          child: Text('SignUp'),
                          onPressed: () {
                            _submit();
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
}

// if (!_formKey.currentState.validate()) {
//   return;
// }
// _formKey.currentState.save();
// try {
//   await Provider.of<Authntication>(context, listen: false)
//       .register(_authData['email'], _authData['password']);
//   Navigator.of(context).pushReplacementNamed(HomeScreen.roteName);
// } catch (error) {
//   var errorMessage = 'Authentication Failed, Please try again Later!';
//   _showErrorDialog(errorMessage);
// }          ده realtime database
//   String _userImageUrl;
//File _imageFile;
// Future<void> _pickImage() async {
//   _imageFile = (await ImagePicker().getImage(source: ImageSource.gallery)).path;
// }

// Future<void> _uploadAndSaveImage() async {
//   if (_imageFile == null) {
//     _showErrorDialog("Please select an image");
//   } else {
//     _passwordController.text == _cpasswordController.text
//         ? _passwordController.text.isNotEmpty &&
//                 _cpasswordController.text.isNotEmpty &&
//                 _emailController.text.isNotEmpty &&
//                 _usernameController.text.isNotEmpty &&
//                 _phoneController.text.isNotEmpty
//             ? _uploadToStorage()
//             : _showErrorDialog("Please fill up the registration form")
//         : _showErrorDialog("Password don't match");
//   }
// }

// Future<void> _uploadToStorage() async {
//   String imageFileName = DateTime.now().millisecondsSinceEpoch.toString();
//   Reference storageReference =
//       FirebaseStorage.instance.ref().child(imageFileName);
//   UploadTask uploadTask = storageReference.putFile(_imageFile);
//   TaskSnapshot taskSnapshot = await uploadTask.whenComplete(() => null);
//   await taskSnapshot.ref
//       .getDownloadURL()
//       .then((value) => _userImageUrl = value);
// }
