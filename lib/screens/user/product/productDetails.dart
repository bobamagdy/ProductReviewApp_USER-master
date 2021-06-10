import 'package:admin/models/product.dart';
import 'package:admin/screens/user/review/new_review.dart';
import 'package:admin/screens/user/review/old_reviews.dart';
import 'package:admin/services/authentication.dart';
import 'package:flutter/material.dart';

class productDetails extends StatelessWidget {
  String userid;
  final Product product;
  productDetails({Key key, @required this.product}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    // Use the Todo to create the UI.
    return Scaffold(
        backgroundColor: Color.fromRGBO(222, 186, 186, 1),
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0.0,
          leading: Padding(
              padding: const EdgeInsets.all(4.0),
              child: IconButton(icon: Icon(Icons.menu), onPressed: null)),
          title: Text(
            product.name.toUpperCase(),
            style: const TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.w500,
                fontFamily: "Montserrat",
                fontSize: 18.0),
          ),
          centerTitle: true,
        ),
        body: SingleChildScrollView(
          child: FutureBuilder(
              future: GetCurrentUID(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  userid = snapshot.data;
                  print("userid " + userid);
                  print("snaaaaaaaaaaaaaaaap " + snapshot.data);
                  return Column(
                    children: [
                      Image(
                        image: NetworkImage(
                          product.image,
                        ),
                        fit: BoxFit.fill,
                        width: 120,
                        height: 200,
                      ),
                      Text("Ctegory Name" + "    " + product.category,
                          style: const TextStyle(
                              //color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              fontSize: 18.0)),
                      Text("Product Name" + "    " + product.name,
                          style: const TextStyle(
                              //color: Colors.white,
                              fontWeight: FontWeight.w500,
                              fontFamily: "Montserrat",
                              fontSize: 18.0)),
                      //
                      MakeReview(product: product, userid: userid),
                      NewReview(product: product, userid: userid),
                    ],
                  );
                }
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return CircularProgressIndicator();
                }
              }),
        ));
  }
}
