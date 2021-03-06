import 'package:admin/models/review.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class ReviewFirebase {
  final FirebaseFirestore _firebaseFirestore = FirebaseFirestore.instance;

  addReview(Review review) {
    _firebaseFirestore.collection('Review').add({
      'id': review.id,
      'comment': review.comment,
      'createAt': review.createAt,
      'productId': review.productId,
      'userId': review.userId,
    });
  }

  Stream<QuerySnapshot> loadReviews() {
    return _firebaseFirestore.collection('Review').snapshots();
  }
}
