import 'package:doctor_app/screens/pages/chat/chat.dart';
import 'package:doctor_app/screens/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:page_transition/page_transition.dart';

import '../../../constant.dart';
import '../../../controllers/appointment_controller.dart';
import '../../../models/appointment_model.dart';

class MyAppointment extends StatefulWidget {
  @override
  _MyAppointmentState createState() => _MyAppointmentState();
}

class _MyAppointmentState extends State<MyAppointment> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<AppointmentController>(
      init: AppointmentController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: scaffoldBgColor,
          appBar: AppBar(
            backgroundColor: whiteColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 1.0,
            title: Text(
              'My Appointment',
              style: appBarTitleTextStyle,
            ),
            actions: [
              IconButton(
                icon: Icon(
                  Icons.history,
                  color: greyColor,
                ),
                onPressed: () {},
              ),
            ],
          ),
          body: controller.finishGetAppointment
              ? controller.appointmentList.isEmpty
                  ? Center(
                      child: Text(
                      "No Appointment yet",
                      style: blackHeadingTextStyle,
                    ))
                  : ListView(
                      physics: BouncingScrollPhysics(),
                      children: [
                        nextAppointment(controller.appointmentList[0]),
                        upcomingAppointment(controller),
                      ],
                    )
              : Center(child: CircularProgressIndicator()),
        );
      },
    );
  }

  nextAppointment(AppointmentModel appointmentModel) {
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Material(
        borderRadius: BorderRadius.circular(15.0),
        elevation: 3.0,
        child: Container(
          padding: EdgeInsets.all(fixPadding * 2.0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(15.0),
            color: darkBlueColor,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    height: 60.0,
                    width: 60.0,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15.0),
                      image: DecorationImage(
                        image: NetworkImage(appointmentModel.userImage),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                  widthSpace,
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              appointmentModel.userName,
                              style: whiteColorHeadingTextStyle,
                            ),
                            SizedBox(height: 5.0),
                            Text(
                              appointmentModel.painUser,
                              style: whiteColorSmallTextStyle,
                            ),
                          ],
                        ),
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            IconButton(
                              icon: Icon(
                                Icons.videocam,
                                color: whiteColor,
                              ),
                              onPressed: () {},
                            ),
                            IconButton(
                              icon: Icon(
                                Icons.chat,
                                color: whiteColor,
                              ),
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  PageTransition(
                                    type: PageTransitionType.size,
                                    alignment: Alignment.center,
                                    child: ChatScreen(
                                      idUser: appointmentModel.idUser,
                                    ),
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              heightSpace,
              Row(
                children: [
                  Expanded(
                    child: Container(
                      padding: EdgeInsets.all(fixPadding * 2.0),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(10.0),
                        color: Colors.blue.withOpacity(0.25),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Icon(Icons.watch_later_outlined,
                              color: whiteColor.withOpacity(0.4), size: 20.0),
                          widthSpace,
                          Text(
                            'Today, ${appointmentModel.time}',
                            style: whiteColorNormalTextStyle,
                          ),
                        ],
                      ),
                    ),
                  ),
                  widthSpace,
                  widthSpace,
                  InkWell(
                    onTap: () {},
                    borderRadius: BorderRadius.circular(28.0),
                    child: Container(
                      height: 56.0,
                      width: 56.0,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(28.0),
                        color: Colors.blue.withOpacity(0.25),
                      ),
                      child: Icon(
                        Icons.check,
                        color: whiteColor,
                      ),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  upcomingAppointment(AppointmentController controller) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Upcoming Appointment',
            style: blackHeadingTextStyle,
          ),
          heightSpace,
          Text(
            'Today',
            style: blackColorButtonTextStyle,
          ),
          heightSpace,
          todayAppointmentList(controller.todayAppointmentList),
          heightSpace,
          Text(
            'Tomorrow',
            style: blackColorButtonTextStyle,
          ),
          heightSpace,
          tomorrowAppointmentList(controller.tomorrowAppointmentList),
        ],
      ),
    );
  }

  todayAppointmentList(List<AppointmentModel> todayAppointment) {
    return ColumnBuilder(
      itemCount: todayAppointment.length,
      itemBuilder: (context, index) {
        final item = todayAppointment[index];
        return Padding(
          padding: EdgeInsets.only(bottom: fixPadding),
          child: Container(
            padding: EdgeInsets.all(fixPadding * 1.5),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15.0),
              color: whiteColor,
              boxShadow: [
                BoxShadow(
                  spreadRadius: 1.0,
                  blurRadius: 1.0,
                  color: Colors.grey[300]!,
                ),
              ],
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  width: 68.0,
                  height: 68.0,
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(10.0),
                      image: DecorationImage(
                        image: NetworkImage(item.userImage),
                        fit: BoxFit.cover,
                      )),
                ),
                widthSpace,
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Container(
                        height: 90.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              item.userName,
                              style: blackColorButtonTextStyle,
                            ),
                            Text(
                              item.painUser,
                              style: greySmallTextStyle,
                            ),
                            Text(
                              'Today | ${item.time}',
                              style: blackNormalTextStyle,
                            ),
                          ],
                        ),
                      ),
                      Container(
                        height: 90.0,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            InkWell(
                              onTap: () {},
                              borderRadius: BorderRadius.circular(23.0),
                              child: Container(
                                height: 46.0,
                                width: 46.0,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(23.0),
                                  border: Border.all(
                                      width: 1.0, color: primaryColor),
                                  color: whiteColor,
                                ),
                                child: Icon(
                                  Icons.check,
                                  color: primaryColor,
                                ),
                              ),
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                InkWell(
                                  onTap: () {},
                                  child: Icon(
                                    Icons.videocam,
                                    color: primaryColor,
                                  ),
                                ),
                                widthSpace,
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      PageTransition(
                                        type: PageTransitionType.size,
                                        alignment: Alignment.center,
                                        child: ChatScreen(
                                          idUser: item.idUser,
                                        ),
                                      ),
                                    );
                                  },
                                  child: Icon(
                                    Icons.message,
                                    color: primaryColor,
                                  ),
                                ),
                              ],
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

  tomorrowAppointmentList(List<AppointmentModel> tomorrowAppointment) {
    return tomorrowAppointment.isEmpty
        ? Center(
            child: Padding(
            padding: EdgeInsets.only(top: 20),
            child: Text(
              "No Appointment yet",
              style: blackHeadingTextStyle,
            ),
          ))
        : ColumnBuilder(
            itemCount: tomorrowAppointment.length,
            itemBuilder: (context, index) {
              final item = tomorrowAppointment[index];
              return Padding(
                padding: EdgeInsets.only(bottom: fixPadding),
                child: Container(
                  padding: EdgeInsets.all(fixPadding * 1.5),
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(15.0),
                    color: whiteColor,
                    boxShadow: [
                      BoxShadow(
                        spreadRadius: 1.0,
                        blurRadius: 1.0,
                        color: Colors.grey[300]!,
                      ),
                    ],
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Container(
                        width: 68.0,
                        height: 68.0,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10.0),
                            image: DecorationImage(
                              image: NetworkImage(item.userImage),
                              fit: BoxFit.cover,
                            )),
                      ),
                      widthSpace,
                      Expanded(
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Container(
                              height: 90.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Expanded(
                                    child: Text(
                                      item.userName,
                                      style: blackColorButtonTextStyle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      item.painUser,
                                      style: greySmallTextStyle,
                                    ),
                                  ),
                                  Expanded(
                                    child: Text(
                                      'Tomorrow | ${item.time}',
                                      style: blackNormalTextStyle,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Container(
                              height: 90.0,
                              child: Column(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.end,
                                children: [
                                  InkWell(
                                    onTap: () {},
                                    borderRadius: BorderRadius.circular(23.0),
                                    child: Container(
                                      height: 46.0,
                                      width: 46.0,
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius:
                                            BorderRadius.circular(23.0),
                                        border: Border.all(
                                            width: 1.0, color: primaryColor),
                                        color: whiteColor,
                                      ),
                                      child: Icon(
                                        Icons.check,
                                        color: primaryColor,
                                      ),
                                    ),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      InkWell(
                                        onTap: () {},
                                        child: Icon(
                                          Icons.videocam,
                                          color: primaryColor,
                                        ),
                                      ),
                                      widthSpace,
                                      InkWell(
                                        onTap: () {
                                          Navigator.push(
                                            context,
                                            PageTransition(
                                              type: PageTransitionType.size,
                                              alignment: Alignment.center,
                                              child: ChatScreen(
                                                idUser: item.idUser,
                                              ),
                                            ),
                                          );
                                        },
                                        child: Icon(
                                          Icons.message,
                                          color: primaryColor,
                                        ),
                                      ),
                                    ],
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            },
          );
  }
}
