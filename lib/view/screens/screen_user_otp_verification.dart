import 'package:bottle_user_app/controller/controller_user_registration_otp.dart';
import 'package:bottle_user_app/view/screens/screen_user_add_more_details.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:pinput/pinput.dart';
import 'package:sizer/sizer.dart';
import 'package:bottle_user_app/model/user.dart' as model;

class ScreenUserOtpVerification extends StatefulWidget {

  model.User user;

  @override
  _ScreenUserOtpVerificationState createState() =>
      _ScreenUserOtpVerificationState();

  ScreenUserOtpVerification({
    required this.user,
  });
}

class _ScreenUserOtpVerificationState extends State<ScreenUserOtpVerification> {


  String _pinputcode = '';


  @override
  Widget build(BuildContext context) {
    return GetBuilder<ControllerUserRegistrationOtp>(
      init: ControllerUserRegistrationOtp(controluser: widget.user),
      builder: (controller) {
        return CustomProgressWidget(
          loading: false,
          child: Scaffold(
            body: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.only(
                    left: 20, right: 20, top: 40, bottom: 8),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                        alignment: Alignment.center,
                        height: Get.height * .3,
                        child: Image(
                            image:
                            AssetImage(
                                'assets/images/otp_verification_logo.png'))),
                    Text(
                      'Verification',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 24,
                          fontWeight: FontWeight.w600),
                    ),
                    SizedBox(
                      height: 8,
                    ),
                    Text(
                      'Enter the OTP code send to your screen',
                      style: TextStyle(
                          color: Colors.black,
                          fontSize: 13.sp,
                          fontWeight: FontWeight.w400),
                    ),
                    SizedBox(height: Get.height * 0.07,),
                    Center(
                      child: Pinput(
                        length: 6,
                        controller: controller.piputController.value,
                        onChanged: (value) {
                          _pinputcode = value;
                        },

                      ),
                    ),
                    SizedBox(height: Get.height * 0.07,),
                    Container(alignment: Alignment.center,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        // crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Text('Did Not receive a code?', style: TextStyle(
                              fontWeight: FontWeight.w600, fontSize: 18),),
                          SizedBox(height: Get.height * 0.01,),
                          GestureDetector(onTap: () {},
                              child: Text('RESEND', style: TextStyle(
                                  fontWeight: FontWeight.w700, fontSize: 18),)),
                          SizedBox(height: Get.height * 0.07,),
                          Obx(() {
                            return Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                controller.loadingpinputscreen.value==false?GestureDetector(onTap: () {
                                  controller.verifyclickpin(_pinputcode);
                                },
                                  child: Container(
                                    alignment: Alignment.center,
                                    width: Get.width * .6,
                                    padding: EdgeInsets.symmetric(
                                        vertical: 8.sp),
                                    decoration: BoxDecoration(boxShadow: [
                                      BoxShadow(
                                          color: Colors.black.withOpacity(0.2),
                                          blurRadius: 8,
                                          spreadRadius: 8,
                                          offset: Offset(1.5, 1.5))
                                    ],
                                        borderRadius: BorderRadius.circular(
                                            20.sp),
                                        color: Colors.black),
                                    child: Text(
                                      'Done',
                                      style: TextStyle(
                                          fontWeight: FontWeight.w600,
                                          fontSize: 18.sp,
                                          color: Colors.white),
                                    ),
                                  ),
                                ):Container(
                                  alignment: Alignment.center,
                                  width: Get.width * .6,
                                  padding: EdgeInsets.symmetric(
                                      vertical: 8.sp),
                                  decoration: BoxDecoration(boxShadow: [
                                    BoxShadow(
                                        color: Colors.black.withOpacity(0.2),
                                        blurRadius: 8,
                                        spreadRadius: 8,
                                        offset: Offset(1.5, 1.5))
                                  ],
                                      borderRadius: BorderRadius.circular(
                                          20.sp),
                                      color: Colors.black),
                                  child: CircularProgressIndicator(color: Colors.white,),
                                ),
                              ],
                            );
                          }),
                          SizedBox(height: Get.height * 0.07,),
                          GestureDetector(onTap: () {},
                              child: Text('Change Phone Number?',
                                style: TextStyle(color: Colors.blue,
                                    fontWeight: FontWeight.w400,
                                    fontSize: 15),)),

                        ],
                      ),
                    )
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
