import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ScreenUserNotificationSettings extends StatefulWidget {

  @override
  _ScreenUserNotificationSettingsState createState() =>
      _ScreenUserNotificationSettingsState();
}

class _ScreenUserNotificationSettingsState
    extends State<ScreenUserNotificationSettings> {

  bool allNotifications=true;
  bool postNotifications=true;
  bool chatNotifications=true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(centerTitle: true,elevation: .8,
          leading: IconButton(
              onPressed: () {
                Get.back();
              },
              icon: Icon(Icons.arrow_back,color: Colors.black,)),
          title: Text('Notification Settings',style: TextStyle(color: Colors.black),),
        ),
      body: Theme(
        data: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
        ),
        child: Column(
          children: [
            SizedBox(height: 7.sp,),
            SwitchListTile(activeColor: Colors.green,title: Text('All Notifications',style: TextStyle(color: Colors.black,fontSize: 23),),value: allNotifications, onChanged: (nvalue){
              setState(() {
                allNotifications=nvalue;
              });
            }),
            Divider(color: Colors.grey.withOpacity(0.5),thickness: 0.5,),
            SwitchListTile(activeColor: Colors.green,title: Text('Post Notifications',style: TextStyle(color: Colors.black,fontSize: 23),),value: postNotifications, onChanged: (nvalue){
              setState(() {
                postNotifications=nvalue;
              });
            }),
            Divider(color: Colors.grey.withOpacity(0.5),thickness: 0.5,),
            SwitchListTile(activeColor: Colors.green,title: Text('Chat Notifications',style: TextStyle(color: Colors.black,fontSize: 23),),value: chatNotifications, onChanged: (nvalue){
              setState(() {
                chatNotifications=nvalue;
              });
            }),
          ],
        ),
      ),
    );
  }
}
