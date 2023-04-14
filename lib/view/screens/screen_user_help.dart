import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';

class ScreenUserHelp extends StatefulWidget {

  @override
  _ScreenUserHelpState createState() => _ScreenUserHelpState();
}

class _ScreenUserHelpState extends State<ScreenUserHelp> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(centerTitle: true,elevation: .8,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back,color: Colors.black,)),
        title: Text(LocaleKeys.help.tr,style: TextStyle(color: Colors.black),),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.symmetric(vertical: 12,horizontal: 12),
          child: Column(
            children: [
              Container(margin: EdgeInsets.only(bottom: 25),height: Get.height * .55,
                padding: EdgeInsets.symmetric(vertical: 10,horizontal: 10),
                decoration: BoxDecoration(border: Border.all(width: 1,color: Colors.grey.withOpacity(0.5)),
                  borderRadius: BorderRadius.circular(5),
                  // boxShadow: [
                  //   BoxShadow(color: Colors.grey,
                  //       blurRadius: 10,
                  //       spreadRadius: 1,
                  //       offset: Offset(1.5,1.5)
                  //   )
                  // ]
                ),
                child: Column(mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(LocaleKeys.contactus.tr,style: TextStyle(
                      color: Colors.black,
                      fontSize: 18.sp,
                      // fontWeight: FontWeight.bold
                    ),),
                    TextFormField(
                        decoration: InputDecoration(
                            // fillColor: Color(0xffD9D9D9),
                            filled: true,
                            hintText: LocaleKeys.yourname.tr,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide:
                              BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(12.0)),
                            ),
                            )),
                    TextFormField(
                        decoration: InputDecoration(
                          // fillColor: Color(0xffD9D9D9),
                          filled: true,
                          hintText: LocaleKeys.yourcontactnumber.tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                        )),
                    TextFormField(
                        decoration: InputDecoration(
                          // fillColor: Color(0xffD9D9D9),
                          filled: true,
                          hintText: LocaleKeys.youremail.tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                        )),
                    TextFormField(maxLines: 4,
                        decoration: InputDecoration(
                          // fillColor: Color(0xffD9D9D9),
                          filled: true,
                          hintText: LocaleKeys.description.tr,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(12.0)),
                          ),
                        )),
                    Container(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(22),
                          color: Colors.black),
                      padding:
                      EdgeInsets.symmetric(vertical: 5.sp, horizontal: Get.width/7),
                      child: Text(
                        LocaleKeys.send.tr,
                        style: TextStyle(
                            color: Colors.white,
                            fontSize: 18.sp,
                            fontWeight: FontWeight.w600),
                      ),
                    )
                  ],
                ),
              ),
              Column(
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
                      Text('ww.sharebottel.com',style: TextStyle(color: Colors.black.withOpacity(0.5),fontSize: 18),)
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
              )
            ],
          ),
        ),
      ),
    );
  }
}
