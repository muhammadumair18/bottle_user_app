import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/view/screens/screen_user_login.dart';
import 'package:bottle_user_app/view/screens/screen_user_phone_verification.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ScreenUserSplash extends StatelessWidget {
  const ScreenUserSplash({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(
            image: DecorationImage(
                image: AssetImage('assets/images/img.png'), fit: BoxFit.fill)),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            SizedBox(),
            InkWell(onTap: (){
              print('The Current user uid is ----------------------------- ');
                print(FirebaseAuth.instance.currentUser?.uid);
              },
              child: Text(
                'Share Bottel',
                style: TextStyle(fontWeight: FontWeight.w700, fontSize: 33.sp,color: Colors.white),
              ),
            ),
            Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    GestureDetector(
                      onTap: (){
                        Get.to(ScreenUserLogin());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5.sp, horizontal: 30.sp),
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF).withOpacity(0.33),
                            borderRadius: BorderRadius.circular(22.sp)),
                        child: Center(
                            child: Text(
                              LocaleKeys.login.tr,
                          style:
                              TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600,color: Colors.white),
                        )),
                      ),
                    ),
                    GestureDetector(
                      onTap: (){
                        Get.to(()=>ScreenUserPhoneVerification());
                      },
                      child: Container(
                        padding:
                            EdgeInsets.symmetric(vertical: 5.sp, horizontal: 30.sp),
                        decoration: BoxDecoration(
                            color: Color(0xffFFFFFF).withOpacity(0.33),
                            borderRadius: BorderRadius.circular(22.sp)),
                        child: Center(
                            child: Text(
                              LocaleKeys.signup.tr,
                          style:
                              TextStyle(fontSize: 18.sp, fontWeight: FontWeight.w600,color: Colors.white),
                        )),
                      ),
                    ),
                  ],
                ),
                SizedBox(height: 15.sp,),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.error_outline,color: Colors.white,),
                    Text(' ${LocaleKeys.youmustbe22yearsold.tr}',style: TextStyle(color: Colors.white,fontWeight: FontWeight.w400,fontSize: 15),),
                    SizedBox(height: 4.sp,)
                  ],
                )
              ],
            )
          ],
        ),
      ),
    );
  }
}
