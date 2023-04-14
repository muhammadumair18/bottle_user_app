import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/view/screens/screen_user_about.dart';
import 'package:bottle_user_app/view/screens/screen_user_help.dart';
import 'package:bottle_user_app/view/screens/screen_user_notification_settings.dart';
import 'package:bottle_user_app/view/screens/screen_user_terms_and_conditions.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ScreenUserSettings extends StatelessWidget {
  const ScreenUserSettings({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(centerTitle: true,elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back,color: Colors.black,)),
        title: Text(LocaleKeys.settiings.tr,style: TextStyle(color: Colors.black),),
      ),
      body: Column(
        children: [
          SizedBox(height: 12,),
          ListTile(onTap: (){
            Get.to(ScreenUserNotificationSettings());
          },
            leading: Container(
              padding: EdgeInsets.symmetric(vertical: 3.5,horizontal: 3.5),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Icons.notifications_none,color: Colors.black,size: 35,),
            ),
            title: Text(LocaleKeys.notificationssettings.tr,style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          SizedBox(height: 9,),
          ListTile(onTap: (){
            Get.to(ScreenUserTermsAndConditions());
          },
            leading: Container(
              padding: EdgeInsets.symmetric(vertical: 3.5,horizontal: 3.5),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Icons.document_scanner_outlined,color: Colors.black,size: 35,),
            ),
            title: Text(LocaleKeys.termsandconditions.tr,style: TextStyle(
                color: Colors.black,
                fontWeight: FontWeight.bold,
                fontSize: 18
            ),),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
          SizedBox(height: 9,),
          ListTile(onTap: (){
            Get.to(ScreenUserHelp());
          },
            leading: Container(
              padding: EdgeInsets.symmetric(vertical: 3.5,horizontal: 3.5),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Icons.help_outline,color: Colors.black,size: 35,),
            ),
            title: Text(LocaleKeys.help.tr,style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold

            ),),
            trailing: Icon(Icons.arrow_forward_ios,),
          ),
          SizedBox(height: 9,),
          ListTile(onTap: (){
            Get.to(ScreenUserAbout());
          },
            leading: Container(
              padding: EdgeInsets.symmetric(vertical: 3.5,horizontal: 3.5),
              decoration: BoxDecoration(
                  color: Colors.grey.withOpacity(0.15),
                  borderRadius: BorderRadius.circular(5)
              ),
              child: Icon(Icons.error_outline,color: Colors.black,size: 35,),
            ),
            title: Text(LocaleKeys.about.tr,style: TextStyle(
                color: Colors.black,
                fontSize: 18,
              fontWeight: FontWeight.bold
            ),),
            trailing: Icon(Icons.arrow_forward_ios),
          ),
        ],
      ),
    );
  }
}
