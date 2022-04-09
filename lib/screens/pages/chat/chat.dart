import 'dart:async';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../constant.dart';
import '../../../controllers/detail_chat_screen_controller.dart';
import '../../../models/chat_model.dart';

class ChatScreen extends StatefulWidget {
  String idUser;

  ChatScreen({required this.idUser});

  @override
  _ChatScreenState createState() => _ChatScreenState();
}

class _ChatScreenState extends State<ChatScreen> {
  final msgController = TextEditingController();
  DateTime now = DateTime.now();
  ScrollController _scrollController = new ScrollController();
  String? amPm;
  final chatData = [
    {'role': 'sender', 'msg': 'Hello', 'time': '9:36 AM', 'read': 'read'},
    {'role': 'me', 'msg': 'Hello Doctor', 'time': '9:35 AM', 'read': 'read'},
  ];

  @override
  void initState() {
    super.initState();
    _scrollToBottom();
  }

  void _scrollToBottom() {
    if (_scrollController.hasClients) {
      _scrollController.animateTo(0.0,
          duration: Duration(milliseconds: 300), curve: Curves.elasticOut);
    } else {
      Timer(Duration(milliseconds: 400), () => _scrollToBottom());
    }
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return SafeArea(
      child: GetBuilder<DetailChatScreenController>(
          init: DetailChatScreenController(),
          builder: (controller) {
            controller.getUser(widget.idUser);
            controller.getMessage(widget.idUser);
            return controller.user.userName.isEmpty
                ? Scaffold(body: Center(child: CircularProgressIndicator()))
                : Scaffold(
                    backgroundColor: whiteColor,
                    appBar: AppBar(
                      backgroundColor: whiteColor,
                      centerTitle: true,
                      elevation: 1.0,
                      title: Text(
                        controller.user.userName,
                        style: appBarTitleTextStyle,
                      ),
                      leading: IconButton(
                        icon: Icon(
                          Icons.arrow_back,
                          color: blackColor,
                        ),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                      ),
                    ),
                    body: (chatData.length == 0)
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.chat,
                                  color: greyColor,
                                  size: 70.0,
                                ),
                                heightSpace,
                                Text(
                                  'No Messages',
                                  style: greyNormalTextStyle,
                                ),
                              ],
                            ),
                          )
                        : Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: <Widget>[
                              Expanded(
                                child: ListView.builder(
                                  controller: _scrollController,
                                  itemCount: controller.listChatMessages.length,
                                  physics: BouncingScrollPhysics(),
                                  // reverse: true,
                                  itemBuilder: (context, index) {
                                    final item =
                                        controller.listChatMessages[index];
                                    final time = DateFormat.jm()
                                        .format(DateTime.parse(item.dateTime));
                                    return Container(
                                      width: width,
                                      child: Column(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment: (item.senderId ==
                                                controller.user.userId)
                                            ? CrossAxisAlignment.start
                                            : CrossAxisAlignment.end,
                                        children: <Widget>[
                                          Wrap(
                                            children: <Widget>[
                                              Padding(
                                                padding: (item.senderId ==
                                                        controller.user.userId)
                                                    ? EdgeInsets.only(
                                                        right: 100.0)
                                                    : EdgeInsets.only(
                                                        left: 100.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment: (item
                                                              .senderId ==
                                                          controller
                                                              .user.userId)
                                                      ? CrossAxisAlignment.start
                                                      : CrossAxisAlignment.end,
                                                  children: <Widget>[
                                                    Container(
                                                      padding: EdgeInsets.all(
                                                          fixPadding),
                                                      margin:
                                                          EdgeInsets.symmetric(
                                                              horizontal:
                                                                  fixPadding),
                                                      decoration: BoxDecoration(
                                                        borderRadius:
                                                            (item.senderId ==
                                                                    controller
                                                                        .user
                                                                        .userId)
                                                                ? BorderRadius
                                                                    .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5.0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            0.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            5.0),
                                                                  )
                                                                : BorderRadius
                                                                    .only(
                                                                    topLeft: Radius
                                                                        .circular(
                                                                            5.0),
                                                                    topRight: Radius
                                                                        .circular(
                                                                            5.0),
                                                                    bottomLeft:
                                                                        Radius.circular(
                                                                            5.0),
                                                                    bottomRight:
                                                                        Radius.circular(
                                                                            0.0),
                                                                  ),
                                                        color: (item.senderId ==
                                                                controller.user
                                                                    .userId)
                                                            ? Colors.grey[300]
                                                            : primaryColor,
                                                      ),
                                                      child: Text(
                                                        item.content,
                                                        style: (item.senderId ==
                                                                controller.user
                                                                    .userId)
                                                            ? blackNormalTextStyle
                                                            : whiteColorNormalTextStyle,
                                                      ),
                                                    ),
                                                    Padding(
                                                      padding:
                                                          EdgeInsets.all(10.0),
                                                      child: Row(
                                                        mainAxisAlignment: (item
                                                                    .senderId ==
                                                                controller.user
                                                                    .userId)
                                                            ? MainAxisAlignment
                                                                .start
                                                            : MainAxisAlignment
                                                                .end,
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .center,
                                                        children: <Widget>[
                                                          SizedBox(
                                                            width: 7.0,
                                                          ),
                                                          Text(
                                                            time,
                                                            style:
                                                                greySmallTextStyle,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    );
                                  },
                                ),
                              ),
                              Container(
                                width: width,
                                height: 70.0,
                                padding: EdgeInsets.all(10.0),
                                child: Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: <Widget>[
                                    Expanded(
                                      child: Container(
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(10.0),
                                          color: primaryColor,
                                        ),
                                        child: TextField(
                                          controller: msgController,
                                          style: TextStyle(
                                            fontSize: 13.0,
                                            color: Colors.white,
                                          ),
                                          cursorColor: whiteColor,
                                          decoration: InputDecoration(
                                            hintText: 'Type a Message',
                                            hintStyle: whiteColorSmallTextStyle,
                                            contentPadding:
                                                EdgeInsets.only(left: 10.0),
                                            border: InputBorder.none,
                                          ),
                                        ),
                                      ),
                                    ),
                                    SizedBox(width: 10.0),
                                    InkWell(
                                      borderRadius: BorderRadius.circular(20.0),
                                      onTap: () {
                                        if (msgController.text != '') {
                                          controller.sendMessage(
                                            MessageModel(
                                              receiverId:
                                                  controller.user.userId,
                                              dateTime:
                                                  DateTime.now().toString(),
                                              content: msgController.text,
                                              senderId:
                                                  controller.getIdUser()["id"],
                                              index: 0,
                                              nameSender: controller
                                                  .getIdUser()["name"],
                                              nameReceiver:
                                                  controller.user.userName,
                                              idMessage: '0',
                                              profileImageSender: controller
                                                  .getIdUser()["image"],
                                              profileImageReceiver: "",
                                            ),
                                            controller.user,
                                          );
                                          setState(() {
                                            msgController.clear();
                                          });
                                        }
                                      },
                                      child: Container(
                                        width: 40.0,
                                        height: 40.0,
                                        alignment: Alignment.center,
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(20.0),
                                          color: greyColor.withOpacity(0.40),
                                        ),
                                        child: Icon(
                                          Icons.send,
                                          color: primaryColor,
                                          size: 18.0,
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            ],
                          ),
                  );
          }),
    );
  }
}
