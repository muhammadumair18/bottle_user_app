import 'dart:convert';
import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/model/posts.dart';
import 'package:bottle_user_app/model/user.dart' as model;
import 'package:bottle_user_app/view/layout/item_admin_top_10_story.dart';
import 'package:bottle_user_app/view/layout/item_home_page_posts.dart';
import 'package:bottle_user_app/view/screens/screen_user_person_profile.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:http/http.dart' as http;

class LayoutHomePage extends StatefulWidget {
  @override
  _LayoutHomePageState createState() => _LayoutHomePageState();
}

class _LayoutHomePageState extends State<LayoutHomePage> {
  TextEditingController homeSearchController = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    homeSearchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.white,
        toolbarHeight: Get.height / 13,
        title: Column(
          children: [
            SizedBox(
              height: 5.sp,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Expanded(
                  child: TextFormField(
                      controller: homeSearchController,
                      decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(vertical: 1),
                          fillColor: Color(0xffD9D9D9),
                          filled: true,
                          hintText: "What are you seeing?",
                          border: OutlineInputBorder(
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 1.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                                BorderSide(color: Colors.white, width: 2.0),
                            borderRadius:
                                BorderRadius.all(Radius.circular(32.0)),
                          ),
                          prefixIcon: Icon(
                            Icons.search,
                            color: Colors.black,
                          ))),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () async {
                    // Position lati=await _getCurrentPosition();
                    // print(lati);
                    // print(FirebaseAuth.instance.currentUser?.uid);

                    // bool value=await examplecheckPermissionStatus();
                    // print(value);
                    // await callOnFcmApiSendPushNotifications(title: 'Hello', body: 'Body');
                    Get.snackbar(
                        'Notifications', 'There are no notifications available',
                        backgroundColor: Colors.black54,
                        colorText: Colors.white);
                  },
                  child: Icon(
                    Icons.notifications,
                    color: Colors.black,
                    size: Get.height / 24,
                  ),
                ),
                SizedBox(
                  width: 8,
                ),
                GestureDetector(
                  onTap: () {
                    Get.to(ScreenUserPersonProfile(
                      personID: FirebaseAuth.instance.currentUser!.uid,
                    ));
                  },
                  child: Container(
                    width: Get.width / 12,
                    height: Get.height / 23,
                    decoration: BoxDecoration(
                        color: Colors.blue,
                        borderRadius: BorderRadius.circular(3),
                        image: DecorationImage(
                            image: AssetImage('assets/images/img_1.png'),
                            fit: BoxFit.contain)),
                  ),
                )
              ],
            ),
          ],
        ),
      ),
      body: Container(
        height: Get.height,
        width: Get.width,
        child: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                // alignment: Alignment.center,
                // color: Colors.red,
                height: Get.height * .18,
                child: Row(
                  children: [
                    ItemTop10Story(
                      profilePic: 'assets/images/image 1.png',
                      userName: 'Roy Jason',
                      forChat: false,
                    ),
                    Flexible(
                      child: ListView.builder(
                        shrinkWrap: true,
                        scrollDirection: Axis.horizontal,
                        itemCount: 10,
                        itemBuilder: (BuildContext context, int index) {
                          return ItemTop10Story(
                            profilePic: 'assets/images/img_1.png',
                            userName: 'Jason Roy',
                            forChat: false,
                          );
                        },
                      ),
                    ),
                  ],
                ),
              ),
              StreamBuilder<QuerySnapshot>(
                  stream: postref.snapshots(),
                  builder: (context, snapshots) {
                    if (snapshots.connectionState == ConnectionState.waiting) {
                      return Center(
                        child: CircularProgressIndicator.adaptive(),
                      );
                    }
                    if (snapshots.hasData) {
                      print('snapshots has data -----------------------------');
                      var data = snapshots.data!.docs
                          .map((e) =>
                              posts.fromMap(e.data() as Map<String, dynamic>))
                          .toList();
                      if (data.length == 0) {
                        return Center(
                            child: Text(
                          'No Data Available',
                          style: TextStyle(color: Colors.red, fontSize: 20),
                        ));
                      }
                      return ListView.builder(
                          physics: ScrollPhysics(),
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: data.length,
                          itemBuilder: (BuildContext context, int index) {
                            var innerdata = data[index];
                            return ItemHomePagePosts(
                              videoLink: innerdata.videoUrl,
                              personid: innerdata.userID,
                              postTime: innerdata.uploadTime,
                            );
                          });
                    }
                    return Center(
                      child: Text(
                        'No Snapshots Data Available',
                        style: TextStyle(color: Colors.black, fontSize: 12),
                      ),
                    );
                  })
            ],
          ),
        ),
      ),
    );
  }

  Future<Position> _getCurrentPosition() async {
    await Geolocator.requestPermission()
        .then((value) {})
        .onError((error, stackTrace) {
      Get.snackbar('Location Error', 'The Location permission is canceled');
    });

    return Geolocator.getCurrentPosition();
  }

  Future<bool> callOnFcmApiSendPushNotifications(
      {required String title, required String body}) async {
    const postUrl = 'https://fcm.googleapis.com/fcm/send';
    final data = {
      "notification": {"body": "this is a body", "title": "this is a title"},
      "priority": "high",
      "data": {
        "click_action": "FLUTTER_NOTIFICATION_CLICK",
        "id": "1",
        "status": "done"
      },
      "to":
          "ePyhQLo9TdyyuDXWDgP6vx:APA91bEP_B7Ltox0xEdOMiMTwGa7GPTu2xfFrPKP1sEyELO8W9pGJRqyEJSNp5ak0MnMZAr5rDp0MXbKE5sjJj0Yd0VFiyMBn7gAehwlMcZMsf9xwlwJMKv1bRqCe8ibcxAOAm8SDPd9"
    };

    final headers = {
      'content-type': 'application/json',
      'Authorization':
          'key=AAAAUfx6dOY:APA91bFxxHCGO0VgcPk4G3WNz1K0QZkMhlufgOQTEzElGDp58CK8lcbDh9v7VodMc2XSbsYT0u10BIQfRx-jSmfhbX-wbe7P0gEZWpcUDaGx4Cq1bFQfymWFu6wY3ixmwZx_qSNYk_2K'
      // 'key=YOUR_SERVER_KEY'
    };

    final response = await http.post(Uri.parse(postUrl),
        body: json.encode(data),
        encoding: Encoding.getByName('utf-8'),
        headers: headers);

    if (response.statusCode == 200) {
      // on success do sth
      print('test ok push CFM');
      return true;
    } else {
      print(' CFM error');
      // on failure do sth
      return false;
    }
  }
}
