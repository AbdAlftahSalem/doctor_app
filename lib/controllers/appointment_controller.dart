import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:doctor_app/controllers/localDB/local_db.dart';
import 'package:get/get.dart';

import '../models/appointment_model.dart';

class AppointmentController extends GetxController {
  List<AppointmentModel> appointmentList = [];
  List<AppointmentModel> todayAppointmentList = [];
  List<AppointmentModel> tomorrowAppointmentList = [];
  bool finishGetAppointment = false;

  getLocalDB() {
    return LocalDB.getData("user");
  }

  getAppointment() async {
    await FirebaseFirestore.instance
        .collection("Doctors")
        .doc(getLocalDB()["id"])
        .collection("Appointments")
        .get()
        .then((value) {
      value.docs.forEach((element) {
        appointmentList.add(AppointmentModel.fromMap(element.data()));
      });
    });

    for (var i in appointmentList) {
      DateTime dateTime = DateTime.now();
      print(i.date[0]);
      if (dateTime.day.toString() == i.date[0]) {
        todayAppointmentList.add(i);
      } else if ((dateTime.day + 1).toString() == i.date[0]) {
        tomorrowAppointmentList.add(i);
      }
    }

    finishGetAppointment = true;
    update();
  }

  @override
  void onInit() {
    super.onInit();
    getAppointment();
  }
}
