import 'package:flutter/material.dart';

import '../../../constant.dart';
import '../../../controllers/localDB/local_db.dart';

class AccountSetting extends StatefulWidget {
  @override
  _AccountSettingState createState() => _AccountSettingState();
}

class _AccountSettingState extends State<AccountSetting> {
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  late String name, phone;

  getLocalData() {
    return LocalDB.getData("user");
  }

  @override
  void initState() {
    super.initState();
    name = getLocalData()["name"];
    phone = getLocalData()["phoneNumber"];
    nameController.text = name;
    phoneController.text = phone;
  }

  @override
  Widget build(BuildContext context) {
    double width = MediaQuery.of(context).size.width;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: whiteColor,
        automaticallyImplyLeading: false,
        centerTitle: true,
        elevation: 1.0,
        title: Text(
          'Account Settings',
          style: appBarTitleTextStyle,
        ),
        leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios,
            size: 12.0,
            color: blackColor,
          ),
          onPressed: () => Navigator.pop(context),
        ),
      ),
      body: ListView(
        children: [
          Container(
            padding: EdgeInsets.all(fixPadding * 2.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: 160.0,
                  alignment: Alignment.center,
                  child: Stack(
                    children: [
                      Container(
                        width: width - fixPadding * 4.0,
                        alignment: Alignment.center,
                        child: Container(
                          width: 140.0,
                          height: 140.0,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(70.0),
                            color: darkBlueColor,
                            image: DecorationImage(
                              image: NetworkImage(
                                getLocalData()["image"],
                              ),
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      ),
                      Positioned(
                        bottom: 0.0,
                        child: Container(
                          width: width - fixPadding * 4.0,
                          alignment: Alignment.center,
                          child: InkWell(
                            onTap: () {},
                            borderRadius: BorderRadius.circular(20.0),
                            child: Container(
                              width: 140.0,
                              padding: EdgeInsets.symmetric(
                                  vertical: fixPadding * 0.6),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(20.0),
                                color: Colors.orange,
                                border: Border.all(
                                  width: 2.0,
                                  color: whiteColor,
                                ),
                              ),
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    Icons.camera_alt,
                                    size: 16.0,
                                    color: whiteColor,
                                  ),
                                  SizedBox(width: 5.0),
                                  Text(
                                    'Change',
                                    style: whiteColorSmallTextStyle,
                                  ),
                                ],
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                heightSpace,

                // Name Field Start
                Container(
                  padding: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.grey[300],
                    ),
                    child: TextField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      style: blackNormalTextStyle,
                      decoration: InputDecoration(
                        labelText: 'Name',
                        labelStyle: blackNormalTextStyle,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300]!, width: 0.7),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          var user = getLocalData();
                          user["username"] = nameController.text;
                          LocalDB.setData("User", user);
                          name = nameController.text;
                          print(getLocalData());
                        });
                      },
                    ),
                  ),
                ),
                // Name Field End

                // Email Field Start
                // Container(
                //   padding: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                //   child: Theme(
                //     data: ThemeData(
                //       primaryColor: Colors.grey[300],
                //     ),
                //     child: TextField(
                //       controller: emailController,
                //       keyboardType: TextInputType.emailAddress,
                //       style: blackNormalTextStyle,
                //       decoration: InputDecoration(
                //         labelText: 'Email',
                //         labelStyle: blackNormalTextStyle,
                //         border: OutlineInputBorder(
                //           borderSide:
                //               BorderSide(color: Colors.grey[300]!, width: 0.7),
                //         ),
                //       ),
                //       onChanged: (value) {},
                //     ),
                //   ),
                // ),
                // Email Field End

                // Phone Number Field Start
                Container(
                  padding: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                  child: Theme(
                    data: ThemeData(
                      primaryColor: Colors.grey[300],
                    ),
                    child: TextField(
                      controller: phoneController,
                      keyboardType: TextInputType.number,
                      style: blackNormalTextStyle,
                      decoration: InputDecoration(
                        labelText: 'Phone Number',
                        labelStyle: blackNormalTextStyle,
                        border: OutlineInputBorder(
                          borderSide:
                              BorderSide(color: Colors.grey[300]!, width: 0.7),
                        ),
                      ),
                      onChanged: (value) {
                        setState(() {
                          var user = getLocalData();
                          user["phoneNumber"] = value;
                          LocalDB.setData("user", user);
                        });
                      },
                    ),
                  ),
                ),
                // Phone Number Field End

                // Password Field Start
                // Container(
                //   padding: EdgeInsets.only(top: fixPadding, bottom: fixPadding),
                //   child: Theme(
                //     data: ThemeData(
                //       primaryColor: Colors.grey[300],
                //     ),
                //     child: TextField(
                //       controller: passwordController,
                //       keyboardType: TextInputType.number,
                //       style: blackNormalTextStyle,
                //       decoration: InputDecoration(
                //         labelText: 'Password',
                //         labelStyle: blackNormalTextStyle,
                //         border: OutlineInputBorder(
                //           borderSide:
                //               BorderSide(color: Colors.grey[300]!, width: 0.7),
                //         ),
                //       ),
                //       obscureText: true,
                //       onChanged: (value) {
                //         setState(() {
                //           var user = getLocalData();
                //           user[""] = value;
                //           LocalDB.setData("user", user);
                //         });
                //       },
                //     ),
                //   ),
                // ),
                // Password Field End
                heightSpace,
                // Save Button Start
                InkWell(
                  onTap: () => Navigator.pop(context),
                  borderRadius: BorderRadius.circular(7.0),
                  child: Container(
                    width: width,
                    padding: EdgeInsets.all(fixPadding * 1.5),
                    alignment: Alignment.center,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(7.0),
                      color: primaryColor,
                    ),
                    child: Text(
                      'Save',
                      style: whiteColorNormalTextStyle,
                    ),
                  ),
                ),
                // Save Button End
              ],
            ),
          ),
        ],
      ),
    );
  }

  // Bottom Sheet for Select Options (Camera or Gallery) Start Here
  void _selectOptionBottomSheet() {
    double width = MediaQuery.of(context).size.width;
    showModalBottomSheet(
        context: context,
        builder: (BuildContext bc) {
          return Container(
            color: whiteColor,
            child: Wrap(
              children: <Widget>[
                Container(
                  child: Container(
                    padding: EdgeInsets.all(fixPadding),
                    child: Column(
                      children: <Widget>[
                        Container(
                          width: width,
                          padding: EdgeInsets.symmetric(horizontal: 10.0),
                          child: Text(
                            'Choose Option',
                            textAlign: TextAlign.center,
                            style: blackNormalTextStyle,
                          ),
                        ),
                        heightSpace,
                        Container(
                          margin: EdgeInsets.symmetric(horizontal: fixPadding),
                          width: width,
                          height: 1.0,
                          color: Colors.grey[300],
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.camera_alt,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text('Camera', style: blackNormalTextStyle),
                              ],
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Container(
                            width: width,
                            padding: EdgeInsets.all(10.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: <Widget>[
                                Icon(
                                  Icons.photo_album,
                                  color: Colors.black.withOpacity(0.7),
                                  size: 18.0,
                                ),
                                SizedBox(
                                  width: 10.0,
                                ),
                                Text(
                                  'Upload from Gallery',
                                  style: blackNormalTextStyle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          );
        });
  }
// Bottom Sheet for Select Options (Camera or Gallery) Ends Here
}
