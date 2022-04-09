import 'dart:math';

import 'package:doctor_app/controllers/review_controller.dart';
import 'package:doctor_app/screens/widget/column_builder.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';

import '../../../constant.dart';

class Reviews extends StatefulWidget {
  @override
  _ReviewsState createState() => _ReviewsState();
}

class _ReviewsState extends State<Reviews> {
  @override
  Widget build(BuildContext context) {
    return GetBuilder<ReviewController>(
      init: ReviewController(),
      builder: (controller) {
        return Scaffold(
          backgroundColor: const Color(0xFFFAFAFF),
          appBar: AppBar(
            backgroundColor: whiteColor,
            automaticallyImplyLeading: false,
            centerTitle: true,
            elevation: 1.0,
            title: Text(
              'Reviews',
              style: appBarTitleTextStyle,
            ),
          ),
          body: ListView(
            physics: BouncingScrollPhysics(),
            children: [
              doctorDetail(controller),
              recentReview(controller),
            ],
          ),
        );
      },
    );
  }

  doctorDetail(ReviewController controller) {
    Random random = Random();
    return Padding(
      padding: EdgeInsets.all(fixPadding * 2.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 170.0,
            width: 110.0,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20.0),
              color: darkBlueColor,
              boxShadow: <BoxShadow>[
                BoxShadow(
                  color: Colors.black54,
                  blurRadius: 10.0,
                ),
              ],
            ),
            child: Container(
              height: 170.0,
              width: 110.0,
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20.0),
                image: DecorationImage(
                  image: NetworkImage(controller.getLocalData()["image"]),
                  fit: BoxFit.cover,
                ),
              ),
            ),
          ),
          widthSpace,
          widthSpace,
          Container(
            height: 170.0,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      heightSpace,
                      Text(
                        controller.getLocalData()["name"],
                        style: blackHeadingTextStyle,
                      ),
                      Text(
                        controller.getLocalData()["typeDoctor"],
                        style: greyNormalTextStyle,
                      ),
                    ],
                  ),
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: whiteColor,
                            ),
                            child: Icon(
                              Icons.star,
                              color: Colors.yellow[800],
                            ),
                          ),
                        ),
                        widthSpace,
                        widthSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Rating',
                              style: greyNormalTextStyle,
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              '${random.nextInt(2) + 3} out of 5',
                              style: blackNormalBoldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                    heightSpace,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Material(
                          elevation: 3.0,
                          borderRadius: BorderRadius.circular(10.0),
                          child: Container(
                            height: 40.0,
                            width: 40.0,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10.0),
                              color: whiteColor,
                            ),
                            child: Icon(
                              Icons.group,
                              color: primaryColor,
                            ),
                          ),
                        ),
                        widthSpace,
                        widthSpace,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              'Patient',
                              style: greyNormalTextStyle,
                            ),
                            SizedBox(height: 2.0),
                            Text(
                              '${random.nextInt(100)}+',
                              style: blackNormalBoldTextStyle,
                            ),
                          ],
                        ),
                      ],
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  recentReview(ReviewController controller) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: EdgeInsets.symmetric(horizontal: fixPadding * 2.0),
          child: Text(
            'Recent reviews',
            style: blackHeadingTextStyle,
          ),
        ),
        heightSpace,
        ColumnBuilder(
          itemCount: controller.reviewsList.length,
          itemBuilder: (context, index) {
            final item = controller.reviewsList[index];
            return Padding(
              padding: EdgeInsets.fromLTRB(
                  fixPadding * 2.0, 0.0, fixPadding * 2.0, fixPadding),
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
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          width: 40.0,
                          height: 40.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20.0),
                            image: DecorationImage(
                              image: NetworkImage(item.image),
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
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.name,
                                    style: blackHeadingTextStyle,
                                  ),
                                  SizedBox(height: 5.0),
                                  ratingBar(int.parse(item.numberStar)),
                                ],
                              ),
                              Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    item.pain,
                                    style: blackNormalTextStyle,
                                  ),
                                  SizedBox(height: 5.0),
                                  Text(
                                    item.date,
                                    style: greyNormalTextStyle,
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    heightSpace,
                    Text(
                      item.content,
                      style: blackNormalTextStyle,
                      overflow: TextOverflow.fade,
                    ),
                  ],
                ),
              ),
            );
          },
        ),
      ],
    );
  }

  ratingBar(rating) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        (rating == 1 ||
                rating == 2 ||
                rating == 3 ||
                rating == 4 ||
                rating == 5)
            ? Icon(
                Icons.star,
                color: Colors.yellow[800],
                size: 15.0,
              )
            : Icon(
                Icons.star,
                color: Colors.grey[400],
                size: 15.0,
              ),
        SizedBox(width: 1.0),
        (rating == 2 || rating == 3 || rating == 4 || rating == 5)
            ? Icon(
                Icons.star,
                color: Colors.yellow[800],
                size: 15.0,
              )
            : Icon(
                Icons.star,
                color: Colors.grey[400],
                size: 15.0,
              ),
        SizedBox(width: 1.0),
        (rating == 3 || rating == 4 || rating == 5)
            ? Icon(
                Icons.star,
                color: Colors.yellow[800],
                size: 15.0,
              )
            : Icon(
                Icons.star,
                color: Colors.grey[400],
                size: 15.0,
              ),
        SizedBox(width: 1.0),
        (rating == 4 || rating == 5)
            ? Icon(
                Icons.star,
                color: Colors.yellow[800],
                size: 15.0,
              )
            : Icon(
                Icons.star,
                color: Colors.grey[400],
                size: 15.0,
              ),
        SizedBox(width: 1.0),
        (rating == 5)
            ? Icon(
                Icons.star,
                color: Colors.yellow[800],
                size: 15.0,
              )
            : Icon(
                Icons.star,
                color: Colors.grey[400],
                size: 15.0,
              ),
        SizedBox(width: 1.0),
      ],
    );
  }
}
