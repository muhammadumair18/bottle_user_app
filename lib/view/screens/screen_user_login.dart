import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/view/screens/screen_user_otp_verification.dart';
import 'package:bottle_user_app/view/screens/screen_user_phone_verification.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ScreenUserLogin extends StatefulWidget {
  @override
  _ScreenUserLoginState createState() => _ScreenUserLoginState();
}

class _ScreenUserLoginState extends State<ScreenUserLogin> {

  String contrycode = '+92';
  String phnumber='';
  GlobalKey<FormState> _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.white,
        body: SingleChildScrollView(
          child: SafeArea(
            child: Form(
              key: _formkey,
              child: Column(
                children: [
                  Container(
                    height: Get.height * .2,
                    padding: EdgeInsets.only(
                      left: 25,
                    ),
                    child: Row(
                      children: [
                        Text(
                          'Login',
                          style: TextStyle(
                              color: Colors.black,
                              fontSize: 25.sp,
                              fontWeight: FontWeight.w600),
                        ),
                      ],
                    ),
                  ),
                  Text(
                    'Share Bottel',
                    style: TextStyle(
                        color: Color(0xff767676),
                        fontSize: 28.sp,
                        fontWeight: FontWeight.w700),
                  ),
                  SizedBox(
                    height: 25.sp,
                  ),
                  Text(
                    'Welcome Back',
                    style: TextStyle(
                        color: Colors.black,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w300),
                  ),
                  Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(30),
                        boxShadow: [
                          BoxShadow(
                              color: Colors.grey,
                              blurRadius: 5,
                              spreadRadius: 2,
                              offset: Offset(1.5, 1.5))
                        ]),
                    margin:
                        EdgeInsets.symmetric(vertical: 25.sp, horizontal: 20.sp),
                    child: TextFormField(autovalidateMode: AutovalidateMode.onUserInteraction,validator: (value){
                      if(value!.length > 10){
                        return 'The number is greatar';

                      }

                    },enableSuggestions: false,autocorrect: false,
                      onChanged: (value){
                        phnumber=value;
                      },
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(fillColor: Colors.white,filled: true,
                          hintText: "Enter Number",
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(32.0)),
                          ),
                          prefixIcon: CountryCodePicker(
                            initialSelection: 'PK',
                            onChanged: (value) {
                              contrycode = value.dialCode.toString();
                              print(contrycode);
                            },
                          )),
                    ),
                  ),
                  SizedBox(
                    height: 25.sp,
                  ),
                  GestureDetector(onTap: (){
                    var user=inituser();
                    if(phnumber.isEmpty){
                      Get.snackbar("Phone Number", 'The phone number is empty',backgroundColor: Colors.red,colorText: Colors.black);
                      return;
                    }
                    if(phnumber.length>10 || phnumber.length<10){
                      Get.snackbar('Invalid', 'Please enter a valid phone number.',backgroundColor: Colors.red,colorText: Colors.black);
                      return;
                    }
                    Get.to(ScreenUserOtpVerification(
                        user: user.copyWith(countrycode: contrycode,phoneNumber: phnumber)));
                  },
                    child: Container(
                      alignment: Alignment.center,
                      width: Get.width * .6,
                      padding: EdgeInsets.symmetric(vertical: 8.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Colors.black),
                      child: Text(
                        'Login',
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            color: Colors.white),
                      ),
                    ),
                  ),
                  Container(
                    padding: EdgeInsets.symmetric(horizontal: Get.width * .3),
                    alignment: Alignment.center,
                    height: Get.height * .11,
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Expanded(
                            child: Divider(
                          height: 5.sp,
                          color: Colors.black,
                        )),
                        SizedBox(
                          width: 2.sp,
                        ),
                        Text('or'),
                        SizedBox(
                          width: 2.sp,
                        ),
                        Expanded(
                            child: Divider(
                          height: 5.sp,
                          color: Colors.black,
                        )),
                      ],
                    ),
                  ),
                  Container(
                    alignment: Alignment.center,
                    width: Get.width * .6,
                    padding: EdgeInsets.symmetric(vertical: 8.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        color: Colors.black),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Image(
                          image: AssetImage('assets/images/apple_logo.png'),
                          height: 18.sp,
                          width: 18.sp,
                        ),
                        Text(
                          'Apple',
                          style: TextStyle(
                              fontWeight: FontWeight.w600,
                              fontSize: 18.sp,
                              color: Colors.white),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 35,),
                  Row(
                    mainAxisSize: MainAxisSize.max,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                          alignment: Alignment.centerLeft,
                          child: Text('Don\'t have an account ')),
                      // VerticalDivider(thickness: 2,color: Colors.grey,),
                      InkWell(onTap: (){
                        Get.to(ScreenUserPhoneVerification());
                      },
                        child: Text(
                          'Signup',
                          style: TextStyle(
                              color: Colors.black, fontWeight: FontWeight.bold),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ));
  }
}
