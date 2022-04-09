import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/controllers/localDB/local_db.dart';
import 'package:doctor_app/reviews_model.dart';
import 'package:doctor_app/screens/pages/reviews/reviews.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';

class ReviewController extends GetxController {
  List<ReviewsModel> reviewsList = [];

  getReview() async {
    await FirebaseFirestore.instance.collection("review").get().then((value) {
      value.docs.forEach((element) {
        reviewsList.add(ReviewsModel.fromMap(element.data()));
      });
    });
    update();
  }

  getLocalData(){
    return LocalDB.getData("user");
  }

  @override
  void onInit() {
    super.onInit();

    getReview();
  }
}
