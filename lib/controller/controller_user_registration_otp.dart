import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/model/user.dart' as model;
import 'package:bottle_user_app/view/screens/screen_user_add_more_details.dart';
import 'package:bottle_user_app/view/screens/screen_user_home_page.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ControllerUserRegistrationOtp extends GetxController {
  ControllerUserRegistrationOtp({
    required this.controluser,
  });

  model.User controluser;
  final _auth = FirebaseAuth.instance;
  final piputController = TextEditingController().obs;
  String _verificationid = '';
  int _resendtoken = 0;
  RxBool loadingpinputscreen=false.obs;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    _sendVerificationCode();
  }

  Future<void> verifyclickpin(String smscode) async {
    loadingpinputscreen.value=true;
    PhoneAuthCredential phoneAuthCredential = PhoneAuthProvider.credential(
        verificationId: _verificationid, smsCode: smscode);
    try {
      await _auth.signInWithCredential(phoneAuthCredential).then((value) async{
        await _verificationCompleted(value);
        loadingpinputscreen.value=false;
      });
    } on FirebaseAuthException catch (e) {
      Get.snackbar('Signup Error', e.toString(),
          colorText: Colors.black, backgroundColor: Colors.deepPurpleAccent);
      Get.back();
      loadingpinputscreen.value=false;
    }
  }



  Future<void> _sendVerificationCode() async {
    String _phonenumber = controluser.countrycode + controluser.phoneNumber;
    String response;
    _auth.verifyPhoneNumber(
        phoneNumber: _phonenumber,
        timeout: const Duration(seconds: 30),
        verificationCompleted: (PhoneAuthCredential authCredential) async {
          await _auth.signInWithCredential(authCredential).then((value) {
            piputController.value.text = authCredential.smsCode ?? '';
            _verificationCompleted(value);
          }).catchError((onError) {
            Get.snackbar('Signup Error', onError,
                colorText: Colors.black,
                backgroundColor: Colors.deepPurpleAccent);
          });
        },
        verificationFailed: (FirebaseAuthException e) {
          Get.snackbar('Verification Failed', e.toString(),
              colorText: Colors.black,
              backgroundColor: Colors.deepPurpleAccent);
        },
        codeSent: (String verificationID, int? resendToken) {
          _verificationid = verificationID;
          _resendtoken = resendToken ?? 0;
        },
        codeAutoRetrievalTimeout: (String verificationId) {
          _verificationid = verificationId;
        });
  }



  Future<void> _verificationCompleted(UserCredential credential) async {
    if (await userAlreadyExists(credential.user!.uid)) {
      Get.offAll(() => ScreenUserHomePage());
    } else {
      controluser.id = credential.user!.uid;
      String respo = await setdatabase(controluser);
      if (respo == 'success') {
        Get.to(ScreenUserAddMoreDetails(
          userid: controluser.id,
        ));
      }
    }
  }



  Future<bool> userAlreadyExists(String id) async {
    final doc = await userref.doc(id).get();
    return doc.exists;
  }



  Future<String> setdatabase(model.User user) async {
    String responce = '';
    await userref.doc(user.id).set(user.toMap()).then((value) {
      responce = 'success';
    }).catchError((onError) {
      Get.snackbar('Signup Error', onError,
          colorText: Colors.black, backgroundColor: Colors.deepPurpleAccent);
    });
    return responce;
  }


}
