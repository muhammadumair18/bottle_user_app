import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/view/layout/layout_chat_page.dart';
import 'package:bottle_user_app/view/layout/layout_home_page.dart';
import 'package:bottle_user_app/view/layout/layout_profile_page.dart';
import 'package:bottle_user_app/view/layout/layout_search_page.dart';
import 'package:bottle_user_app/view/screens/screen_user_new_post_camera.dart';
import 'package:bottle_user_app/view/screens/screen_user_new_post_description.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenUserHomePage extends StatefulWidget {

  @override
  _ScreenUserHomePageState createState() => _ScreenUserHomePageState();
}

class _ScreenUserHomePageState extends State<ScreenUserHomePage> {
  PageController controller=PageController(initialPage: 0);
  int selectedPage=0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Get.to(()=>ScreenUserRecordVideoScreen());
        },backgroundColor: Colors.black,
        child: Icon(Icons.add,color: Colors.white,),),
      body: SafeArea(
        child: PageView(
          physics: NeverScrollableScrollPhysics(),
          onPageChanged: (nvalue){
            setState(() {
              selectedPage=nvalue;
            });
          },
          controller: controller,
          children: [
            LayoutHomePage(),
            LayoutSearchPage(),
            LayoutChatPage(),
            LayoutProfilePage()
          ],
        ),
      ),
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: Get.height/13,
          child: Row(
            // crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              GestureDetector(onTap: (){
                controller.jumpToPage(0);
              },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.home,color: Colors.black,),
                    Container(child: selectedPage==0 ? Text(LocaleKeys.home.tr,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 12),):null,)
                  ],
                ),
              ),
              GestureDetector(onTap: (){
                controller.jumpToPage(1);
              },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.search,color: Colors.black,),
                    Container(child: selectedPage==1 ? Text(LocaleKeys.search.tr,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 12),):null,)

                  ],
                ),
              ),
              Container(),
              GestureDetector(onTap: (){
                controller.jumpToPage(2);
              },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.chat,color: Colors.black,),
                    Container(child: selectedPage==2 ? Text(LocaleKeys.chat.tr,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 12),):null,)

                  ],
                ),
              ),
              GestureDetector(onTap: (){
                controller.jumpToPage(3);
              },
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Icon(Icons.person,color: Colors.black,),
                    Container(child: selectedPage==3 ? Text(LocaleKeys.profile.tr,style: TextStyle(color: Colors.black,fontWeight: FontWeight.w600,fontSize: 12),):null,)

                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
