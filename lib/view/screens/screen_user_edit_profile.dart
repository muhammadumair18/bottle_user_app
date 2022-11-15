import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

class ScreenUserEditProfile extends StatefulWidget {

  @override
  _ScreenUserEditProfileState createState() => _ScreenUserEditProfileState();
}

class _ScreenUserEditProfileState extends State<ScreenUserEditProfile> {
TextEditingController usernameController=TextEditingController();
TextEditingController emailController=TextEditingController();
TextEditingController dateofbirthController=TextEditingController();

_pickvideo(ImageSource src, BuildContext context) async {
  XFile? image = await ImagePicker().pickImage(source: src);
  if (image != null) {
    print('The image has been selectes ${image.path}');
    }
}

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(shadowColor: Colors.grey.withOpacity(.2),centerTitle: true,elevation: 4,
        leading: IconButton(
            onPressed: () {
              Get.back();
            },
            icon: Icon(Icons.arrow_back,color: Colors.black,)),
        title: Text('Profile',style: TextStyle(color: Colors.black),),
        actions: [
          Center(
            child: InkWell(
              onTap: (){},
              child: Text("Edit",style: TextStyle(
                color: Color(0xffEB141B),
                fontSize: 19,
                fontWeight: FontWeight.w400
              ),),
            ),
          ),
          SizedBox(width: 10,)
        ],
      ),
      backgroundColor: Colors.white,
      body: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15.sp),
        child: Column(
          children: [
            SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(height: 12.sp,),
                  Container(
                    height: Get.height * .15,
                    width: Get.width * .30,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        border: Border.all(width: 1.sp, color: Colors.black)),
                    child: Stack(
                      children: [
                        Container(
                          // margin: EdgeInsets.all(8),
                          decoration: BoxDecoration(
                              shape: BoxShape.circle,
                              image: DecorationImage(
                                  image: AssetImage(
                                      'assets/images/image 1.png'),
                                  fit: BoxFit.contain)),
                        ),
                        Positioned(
                          bottom: 1,
                          right: 10,
                          child: GestureDetector(
                            onTap: () {
                              _pickvideo(ImageSource.gallery, context);
                            },
                            child: Container(
                              padding: EdgeInsets.all(5),
                              decoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle),
                              child: Icon(
                                Icons.camera_alt,
                                color: Colors.white,
                              ),
                            ),
                          ),
                        )
                      ],
                    ),
                  ),
                  SizedBox(height: 12.sp,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('UserName',style: TextStyle(color: Color(0xff5F5E5E),fontSize: 12,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: usernameController,
                      style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 17),
                            fillColor: Colors.grey.withOpacity(.11),
                            filled: true,
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                            enabledBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 1.0),
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                            focusedBorder: OutlineInputBorder(
                              borderSide: BorderSide(color: Colors.white, width: 2.0),
                              borderRadius: BorderRadius.all(Radius.circular(4.0)),
                            ),
                        )),
                  ),
                  SizedBox(height: 4,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Email',style: TextStyle(color: Color(0xff5F5E5E),fontSize: 12,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: emailController,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 17),
                          fillColor: Colors.grey.withOpacity(.11),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                        )),
                  ),
                  SizedBox(height: Get.height * .04,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Text('Date of Birth',style: TextStyle(color: Color(0xff5F5E5E),fontSize: 12,fontWeight: FontWeight.w400),textAlign: TextAlign.start,),
                    ],
                  ),
                  Container(
                    margin: EdgeInsets.symmetric(vertical: 8),
                    child: TextFormField(
                      controller: dateofbirthController,
                        style: TextStyle(color: Colors.black,fontWeight: FontWeight.w400,fontSize: 15),
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.symmetric(horizontal: 15,vertical: 17),
                          fillColor: Colors.grey.withOpacity(.11),
                          filled: true,
                          border: OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          enabledBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 1.0),
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderSide: BorderSide(color: Colors.white, width: 2.0),
                            borderRadius: BorderRadius.all(Radius.circular(4.0)),
                          ),
                        )),
                  ),
                  // SizedBox(height: 40.sp,),
                ],
              ),
            ),
            // GestureDetector(
            //   onTap: () {
            //     showDialog(
            //         context: context,
            //         builder: (context) {
            //           return AlertDialog(
            //             content: Column(
            //               mainAxisSize: MainAxisSize.min,
            //               mainAxisAlignment: MainAxisAlignment.center,
            //               children: [
            //                 Container(height: 100.sp,
            //                   width: 100.sp,
            //                   decoration: BoxDecoration(
            //                     image: DecorationImage(
            //                         image: AssetImage('assets/images/tick.png')
            //                     ),
            //                     borderRadius: BorderRadius.circular(60.sp),
            //                   ),
            //                   // child: Icon(
            //                   //   Icons.check_circle_outline,
            //                   //   size: 55.sp,
            //                   // )
            //                 ),
            //                 SizedBox(
            //                   height: 6.sp,
            //                 ),
            //                 Text(
            //                   'Added!',
            //                   style: TextStyle(fontSize: 20.sp,fontWeight: FontWeight.w500),
            //                 )
            //               ],
            //             ),
            //           );
            //         });
            //   },
            //   child: Container(
            //     decoration: BoxDecoration(
            //         borderRadius: BorderRadius.circular(22),
            //         color: Colors.black),
            //     padding: EdgeInsets.symmetric(
            //         vertical: 5.sp, horizontal: 55.sp),
            //     child: Text(
            //       'Add',
            //       style: TextStyle(
            //           color: Colors.white,
            //           fontSize: 18.sp,
            //           fontWeight: FontWeight.w600),
            //     ),
            //   ),
            // ),
            // SizedBox(height: 20.sp,)
          ],
        ),
      ),
    );
  }
}
