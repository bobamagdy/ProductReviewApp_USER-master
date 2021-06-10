import 'package:admin/models/product.dart';
import 'package:admin/models/review.dart';
import 'package:admin/screens/user/review/blockAlert.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:admin/services/authentication.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

import 'package:audioplayers/audio_cache.dart';
import 'alert2.dart';
import 'alertFirst.dart';

class NewReview extends StatefulWidget {
  final Product product;
  final Review review;
  final String userid;
  int count = 0;
  User user = FirebaseAuth.instance.currentUser;

  NewReview(
      {Key key, @required this.product, @required this.userid, this.review})
      : super(key: key);
  @override
  _NewReviewState createState() => _NewReviewState();
}

class _NewReviewState extends State<NewReview> {
  final _controller = TextEditingController();
  User user = FirebaseAuth.instance.currentUser;
  final player = AudioCache();
  int reviewCount = 0;
  String _enteredMessage = "";
  _sendMessage() {
    FocusScope.of(context).unfocus();
    FirebaseFirestore.instance.collection('Review').add({
      'comment': _enteredMessage,
      'createAt': Timestamp.now(),
      'productId': widget.product.id,
      'userId': user.uid,
    });
    _controller.clear();
  }

  blockedUser() {
    return FirebaseFirestore.instance
        .collection("User")
        .doc(user.uid)
        .set({'state': "blocked"}, SetOptions(merge: true));
  }

  _saveReview() {
    int count = 0;
    FirebaseFirestore.instance
        .collection('Product')
        .doc(widget.product.id)
        .collection('userANDreview')
        .get()
        .then((docs) {
      if (docs.docs.isNotEmpty) {
        for (int i = 0; i < docs.docs.length; i++) {
          if (docs.docs[i].data()['user'] == user.uid) {
            count++;
            print(count);
          } else {
            print("USER IS NOT FOUND IN REVIEW&USER lIST");
          }
        }
        if (count == 0) {
          _enteredMessage.trim().isEmpty
              ? () {
                  return null;
                }()
              : _sendMessage();
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertFirstDialogWidget());
          player.play('sound.mp3');
          print("this is first review for U");
          saveRealReview();
        } else if (count == 1) {
          showDialog(
              context: context,
              builder: (BuildContext context) => AlertSecondDialogWidget());
          player.play('sound.mp3');
          print("you make 1 review");
          _controller.clear();
          saveFakeReview();
        } else if (count == 2) {
          showDialog(
              context: context,
              builder: (BuildContext context) => BlockAlertDialogWidget());
          player.play('sound.mp3');
          print("you are blocked");
          _controller.clear();
          blockedUser();
        }
      } else {
        _enteredMessage.trim().isEmpty
            ? () {
                return null;
              }()
            : _sendMessage();
        showDialog(
            context: context,
            builder: (BuildContext context) => AlertFirstDialogWidget());
        player.play('sound.mp3');
        print("this is first review for U");
      }
    });
  }

/* for (int i = 0; i < docs.docs.length; i++) {
          if (docs.docs[i].data()['user'] == user.uid) {
            print("you can not make review");
          } else {
            print("you can  make review");
          }
        }*/
  Future saveRealReview() async {
    return FirebaseFirestore.instance
        .collection("Product")
        .doc(widget.product.id)
        .collection("userANDreview")
        .add({'user': user.uid, 'review': _enteredMessage, 'state': "Real"});
  }

  Future saveFakeReview() async {
    return FirebaseFirestore.instance
        .collection("Product")
        .doc(widget.product.id)
        .collection("userANDreview")
        .add({'user': user.uid, 'review': _enteredMessage, 'state': "Fake"});
  }

//.set({"userANDreview": {"userId": user.uid, "review": _enteredMessage});
  @override
  Widget build(BuildContext context) {
    return Container(
      color: Colors.red[700],
      margin: EdgeInsets.only(top: 8),
      padding: EdgeInsets.all(8),
      child: Row(
        children: [
          Expanded(
              child: TextField(
            controller: _controller,
            decoration: InputDecoration(
              labelText: 'write a review...',
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (val) {
              setState(() {
                _enteredMessage = val;
              });
            },
          )),
          IconButton(
            color: Colors.white,
            icon: Icon(
              Icons.send,
              color: Colors.white,
            ),
            onPressed: _enteredMessage.trim().isEmpty ? null : _saveReview,
          )
        ],
      ),
    );
  }
}
