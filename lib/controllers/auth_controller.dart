import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/controllers/localDB/local_db.dart';
import 'package:doctor_app/screens/pages/bottom_bar.dart';
import 'package:doctor_app/screens/pages/login_signup/otp.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

class AuthController extends GetxController {
  String phoneNumber = '';
  String? phoneIsoCode;
  String? dialCode;
  String verificationId = "";
  String otp1 = "", otp2 = "", otp3 = "", otp4 = "", otp5 = "", otp6 = "";
  bool finishTarget = false;

  onPhoneNumberChange({required String number, required String dialCode}) {
    phoneNumber = number;
    this.dialCode = dialCode;
    print(number);
    update();
  }

  sendOTP() async {
    finishTarget = false;
    update();
    print(phoneNumber);
    FirebaseFirestore.instance
        .collection("Doctors")
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get()
        .then((value) {
      if (value.docs.length == 0) {
        Get.snackbar(
            "Message", "This phone is not found , please enter valid number");
      } else {
        print(value.docs[0].data());
        FirebaseAuth.instance.verifyPhoneNumber(
          phoneNumber: "$phoneNumber",
          verificationCompleted: (PhoneAuthCredential credential) {},
          verificationFailed: (FirebaseAuthException e) {
            Get.snackbar("Message", "Some thing error");
            print(e);
          },
          codeSent: (String verificationId, int? resendToken) {
            this.verificationId = verificationId;
            Get.to(() => OTPScreen());
          },
          codeAutoRetrievalTimeout: (String verificationId) {
            this.verificationId = verificationId;
          },
        );
      }
    });
    finishTarget = true;
    update();
  }

  verifyOTp(String otp) async {
    print(otp);
    var credential = await FirebaseAuth.instance.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: this.verificationId, smsCode: otp),
    );
    print(credential.user);
    if (credential.user != null) {
      await saveUser();
      Get.to(() => BottomBar());
    } else {
      Get.snackbar("Message", "Please enter valid OTP");
    }
  }

  saveUser() async {
    await FirebaseFirestore.instance
        .collection('Doctors')
        .where("phoneNumber", isEqualTo: phoneNumber)
        .get()
        .then((value) {
      LocalDB.setData("user", value.docs[0].data());
    });
  }
}
