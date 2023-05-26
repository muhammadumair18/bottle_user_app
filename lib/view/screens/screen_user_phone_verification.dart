import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/view/screens/screen_user_otp_verification.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:country_picker/country_picker.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ScreenUserPhoneVerification extends StatefulWidget {
  const  ScreenUserPhoneVerification({Key? key}) : super(key: key);

  @override
  _ScreenUserPhoneVerificationState createState() =>
      _ScreenUserPhoneVerificationState();
}

class _ScreenUserPhoneVerificationState
    extends State<ScreenUserPhoneVerification> {
  String contrycode = '+92';
  bool agreetoterms=false;
  String phnumber='';

  GlobalKey<FormState> _formkey=GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height * .10,
        elevation: 0,
        backgroundColor: Colors.white,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          LocaleKeys.signup.tr,
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: Container(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: SingleChildScrollView(
          child: Form(
            key: _formkey,
            autovalidateMode: AutovalidateMode.onUserInteraction,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  height: Get.height * .07,
                ),
                Text(
                  'Phone Verification',
                  style: TextStyle(
                      color: Colors.black,
                      fontSize: 22.sp,
                      fontWeight: FontWeight.w600),
                ),
                SizedBox(
                  height: Get.height * .01,
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      LocaleKeys.addyourphonenumberwewill.tr,
                      style: TextStyle(
                          color: Color(0xff353535),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                    Text(
                      LocaleKeys.verificationcodeweknow.tr,
                      style: TextStyle(
                          color: Color(0xff353535),
                          fontWeight: FontWeight.w400,
                          fontSize: 14.sp),
                    ),
                  ],
                ),
                Container(
                  margin: EdgeInsets.symmetric(vertical: 15.sp),
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.all(Radius.circular(32.0)),
                      // boxShadow: [
                      //   BoxShadow(color: Colors.grey,
                      //       blurRadius: 3,
                      //       spreadRadius: 1,
                      //       offset: Offset(1.5,1.5)
                      //   )
                      // ]
                  ),
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
                        hintText: LocaleKeys.enternumber.tr,
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
                        prefixIcon:
                        // InkWell(
                        //     onTap: (){
                        //       showCountryPicker(
                        //           context: context,
                        //           onSelect: (Country value) {
                        //             contrycode = value.phoneCode.toString();
                        //             print(contrycode);
                        //           });
                        //     },
                        //     child: Icon(Icons.map))
                        CountryCodePicker(
                          initialSelection: 'PK',
                          onChanged: (value) {
                            contrycode = value.dialCode.toString();
                            print(contrycode);
                          },
                        )
                    ),
                  ),
                ),
                Row(children: [
                  Expanded(
                    child: CheckboxListTile(
                      title: Row(
                        children: [
                          Text('${LocaleKeys.agreewith.tr} ',style: TextStyle(color: Colors.black,fontSize: 14,fontWeight: FontWeight.w400),),
                          Text(LocaleKeys.termsandconditions.tr,style: TextStyle(color: Colors.blue,fontSize: 14,fontWeight: FontWeight.w400),),
                        ],
                      ),
                      value: agreetoterms,
                      onChanged: (newValue) {
                        setState(() {
                          agreetoterms = newValue!;
                        });
                      },
                      controlAffinity: ListTileControlAffinity.leading,  //  <-- leading Checkbox
                    ),
                  )
                ],),
                SizedBox(height: 3.h,),
                Center(
                  child: GestureDetector(onTap: (){
                    if(phnumber.length<10)
                      {
                        Get.snackbar(LocaleKeys.invalidnumber.tr, LocaleKeys.pleaseentervalidphonenumber.tr,backgroundColor: Colors.red,colorText: Colors.black);
                      }
                    else{
                      var phveruser=inituser();
                      print(phveruser);
                      phveruser.countrycode=contrycode;
                      phveruser.phoneNumber=phnumber;
                      Get.to(()=>ScreenUserOtpVerification(
                        user: phveruser,
                      ));
                    }
                  },
                    child: Container(
                      alignment: Alignment.center,
                      width: Get.width * .6,
                      padding: EdgeInsets.symmetric(vertical: 8.sp),
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20.sp),
                          color: Colors.black),
                      child: Text(
                        LocaleKeys.sendotp.tr,
                        style: TextStyle(
                            fontWeight: FontWeight.w600,
                            fontSize: 18.sp,
                            color: Colors.white),
                      ),
                    ),
                  ),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
