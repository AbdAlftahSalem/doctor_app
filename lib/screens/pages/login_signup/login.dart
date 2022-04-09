import 'dart:io';
import 'package:doctor_app/controllers/auth_controller.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:get/get.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';

import '../../../constant.dart';

class Login extends StatefulWidget {
  @override
  _LoginState createState() => _LoginState();
}

class _LoginState extends State<Login> {
  DateTime? currentBackPressTime;

  final TextEditingController controller = TextEditingController();
  String initialCountry = 'JO';
  PhoneNumber number = PhoneNumber(isoCode: 'JO');

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    double height = MediaQuery.of(context).size.height;
    return Container(
      decoration: BoxDecoration(
        image: DecorationImage(
            image: AssetImage('assets/signiamge.jpeg'), fit: BoxFit.cover),
      ),
      child: Stack(
        children: <Widget>[
          Positioned(
            top: 0.0,
            left: 0.0,
            child: Container(
              width: width,
              height: height,
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.1, 0.3, 0.5, 0.7, 0.9],
                  colors: [
                    Colors.black.withOpacity(0.4),
                    Colors.black.withOpacity(0.55),
                    Colors.black.withOpacity(0.7),
                    Colors.black.withOpacity(0.8),
                    Colors.black.withOpacity(1.0),
                  ],
                ),
              ),
            ),
          ),
          Positioned(
            child: WillPopScope(
              child: Scaffold(
                backgroundColor: Colors.transparent,
                body: ListView(
                  physics: BouncingScrollPhysics(),
                  children: <Widget>[
                    SizedBox(height: 30.0),
                    Padding(
                      padding: EdgeInsets.only(top: 20.0, left: 20.0),
                      child: Text(
                        'Welcome back',
                        style: loginBigTextStyle,
                      ),
                    ),
                    SizedBox(height: 10.0),
                    Padding(
                      padding: EdgeInsets.only(left: 20.0),
                      child: Text(
                        'Login in your account',
                        style: whiteSmallLoginTextStyle,
                      ),
                    ),
                    SizedBox(height: 70.0),
                    GetBuilder<AuthController>(
                        init: AuthController(),
                        builder: (ctr) {
                          return Padding(
                            padding: EdgeInsets.all(20.0),
                            child: Container(
                              padding: EdgeInsets.only(left: 10.0),
                              decoration: BoxDecoration(
                                color: Colors.grey[200]!.withOpacity(0.3),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20.0)),
                              ),
                              child: InternationalPhoneNumberInput(
                                textStyle: inputLoginTextStyle,
                                autoValidateMode: AutovalidateMode.disabled,
                                selectorTextStyle: TextStyle(
                                  color: Colors.white,
                                  fontSize: 16.0,
                                  fontWeight: FontWeight.w500,
                                ),
                                initialValue: number,
                                textFieldController: controller,
                                inputBorder: InputBorder.none,
                                inputDecoration: InputDecoration(
                                  contentPadding:
                                      EdgeInsets.only(left: 0, bottom: 13.0),
                                  hintText: 'Phone Number',
                                  hintStyle: inputLoginTextStyle,
                                  border: InputBorder.none,
                                ),
                                selectorConfig: SelectorConfig(
                                  selectorType: PhoneInputSelectorType.DIALOG,
                                ),
                                onInputChanged: (PhoneNumber number) {
                                  ctr.onPhoneNumberChange(
                                      number: number.phoneNumber.toString(),
                                      dialCode: number.dialCode.toString());
                                },
                              ),
                            ),
                          );
                        }),
                    SizedBox(height: 30.0),
                    GetBuilder<AuthController>(
                        init: AuthController(),
                        builder: (controller) {
                          return Padding(
                            padding: EdgeInsets.only(right: 20.0, left: 20.0),
                            child: InkWell(
                              borderRadius: BorderRadius.circular(30.0),
                              onTap: () async {
                                await controller.sendOTP();
                              },
                              child: Container(
                                height: 50.0,
                                width: double.infinity,
                                alignment: Alignment.center,
                                decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(30.0),
                                  gradient: LinearGradient(
                                    begin: Alignment.centerLeft,
                                    end: Alignment.bottomRight,
                                    stops: [0.1, 0.5, 0.9],
                                    colors: [
                                      Colors.blue[300]!.withOpacity(0.8),
                                      Colors.blue[500]!.withOpacity(0.8),
                                      Colors.blue[800]!.withOpacity(0.8),
                                    ],
                                  ),
                                ),
                                child: Text(
                                  'Continue',
                                  style: inputLoginTextStyle,
                                ),
                              ),
                            ),
                          );
                        }),
                    SizedBox(height: 10.0),
                    Text(
                      'We\'ll send OTP for Verification',
                      textAlign: TextAlign.center,
                      style: whiteSmallLoginTextStyle,
                    ),
                    SizedBox(height: 30.0),
                  ],
                ),
              ),
              onWillPop: () async {
                bool backStatus = onWillPop();
                if (backStatus) {
                  exit(0);
                }
                return false;
              },
            ),
          ),
        ],
      ),
    );
  }

  onWillPop() {
    DateTime now = DateTime.now();
    if (currentBackPressTime == null ||
        now.difference(currentBackPressTime!) > Duration(seconds: 2)) {
      currentBackPressTime = now;
      Fluttertoast.showToast(
        msg: 'Press Back Once Again to Exit.',
        backgroundColor: Colors.black,
        textColor: whiteColor,
      );
      return false;
    } else {
      return true;
    }
  }
}
