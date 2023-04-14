import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ScreenUserAbout extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        elevation: 0,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.black,
            )),
        title: Text(LocaleKeys.about.tr,style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SizedBox(height: 10.h,),
            Align(
              alignment: Alignment.center,
              child: Text(
                "Share Bottle",
                style: heading1_style.copyWith(color: Color(0xFF767676), fontFamily: 'Comfortaa'),

              ),
            ),
            SizedBox(height: 8.h,),

            Padding(
              padding: const EdgeInsets.only(left: 20.0,right: 20,top: 20),
              child: Align(alignment: Alignment.center,
                child: Text("${LocaleKeys.helpprotectyourwebside.tr} "
                ),
              ),
            ),
            Align(alignment: Alignment.center,
              child: Text(LocaleKeys.andfairwebsite.tr
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  SizedBox(height: 4.h,),

                  Text(LocaleKeys.version.tr,style: normal_h2Style_bold,),
                  SizedBox(height: 10,),
                  Text("2.1.0"),
                  SizedBox(height: 10,),

                  Text(LocaleKeys.poweredby.tr,style: normal_h2Style_bold,),
                  SizedBox(height: 10,),

                  Text("Share Bottle"),
                  SizedBox(height: 10,),

                  Text(LocaleKeys.contactus.tr,style: normal_h2Style_bold,),
                ],),
            ),
            SizedBox(height: 2.h,),
            Padding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              child: Column(
                // mainAxisAlignment: MainAxisAlignment.start,
                // crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Text(LocaleKeys.weareavailableon.tr,style: TextStyle(color: Colors.black,fontSize: 25),),
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.circle,size: Get.height * .05,),
                      SizedBox(width: 5,),
                      Text('www.sharebottel.com',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 18),)
                    ],
                  ),
                  SizedBox(height: 8,),
                  Row(
                    children: [
                      Icon(Icons.email,size: Get.height * .05,),
                      SizedBox(width: 5,),

                      Text('contact@sharebpttel.com',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 18),)
                    ],
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
