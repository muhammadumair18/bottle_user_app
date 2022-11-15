import 'package:bottle_user_app/view/layout/item_user_notification.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ScreenUserNotificationScreen extends StatefulWidget {

  @override
  _ScreenUserNotificationScreenState createState() =>
      _ScreenUserNotificationScreenState();
}

class _ScreenUserNotificationScreenState
    extends State<ScreenUserNotificationScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        // elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text('Notifications',style: TextStyle(color: Colors.black),),
      ),
      body: ListView.builder(itemCount: 25,itemBuilder: (BuildContext context,int index){
        return ItemUserNotification(notificationTitle: 'Chat', notificationDescription: 'Jack just send you a message');
      }),
    );
  }
}
