import 'package:admin/models/product.dart';
import 'package:admin/models/review.dart';
import 'package:admin/services/rev.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class MakeReview extends StatelessWidget {
  final _store = ReviewFirebase();
  final Product product;
  final String userid;
  MakeReview({Key key, @required this.product, @required this.userid})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return StreamBuilder(
        stream: _store.loadReviews(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (snapshot.hasData) {
            // final docs = snapshot.data.docs;
            List<Review> reviews = [];
            for (var doc in snapshot.data.docs) {
              var data = doc.data();
              if (product.id == data['productId']) {
                print(data['productId']);
                reviews.add(Review(
                  id: doc.id,
                  productId: data['productId'],
                  comment: data['comment'],
                  createAt: data['createAt'],
                  userId: data['userId'],
                ));
              }
            }
            return reviews.isEmpty
                ? Center(child: Text('Empty'))
                : ListView.builder(
                    scrollDirection: Axis.vertical,
                    shrinkWrap: true,
                    reverse: true,
                    itemCount: reviews.length,
                    itemBuilder: (ctx, index) => Container(
                      width: 10,
                      height: 35,
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(color: Colors.grey)),
                      padding: EdgeInsets.all(5),
                      margin: EdgeInsets.only(top: 5, bottom: 5),
                      child: Text(reviews[index].comment),
                    ),
                  );
          }
        });
  }
}
// return Center(
//   child: Text(
//     'Loading....',
//     textAlign: TextAlign.center,
//     style: TextStyle(
//       fontSize: 40.0,
//       color: Colors.blueGrey[900],
//       fontWeight: FontWeight.bold,
//       fontStyle: FontStyle.italic,
//       shadows: [
//         Shadow(
//           blurRadius: 10.0,
//           color: Colors.black54,
//           offset: Offset(5.0, 5.0),
//         ),
//         Shadow(
//           color: Color(0xFFE0F7FA),
//           blurRadius: 10.0,
//           offset: Offset(-5.0, 5.0),
//         )
//       ],
//       letterSpacing: -1.0,
//       wordSpacing: 5.0,
//     ),
//   ),
// );
