import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/view/screens/screen_user_allow_location.dart';
import 'package:bottle_user_app/view/screens/screen_user_home_page.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ScreenUserAddMoreDetails extends StatefulWidget {
  String userid;

  @override
  _ScreenUserAddMoreDetailsState createState() =>
      _ScreenUserAddMoreDetailsState();

  ScreenUserAddMoreDetails({
    required this.userid,
  });
}

class _ScreenUserAddMoreDetailsState extends State<ScreenUserAddMoreDetails> {
  DateTime? selectedDate;
  String? username;
  TextEditingController nameController = TextEditingController();
  int selectedavatarindex = 1;

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
        context: context,
        initialDate: DateTime.now(),
        firstDate: DateTime(2015, 8),
        lastDate: DateTime(2101));
    if (picked != null && picked != selectedDate) {
      setState(() {
        selectedDate = picked;
      });
    }
  }

  // Future<String> updateDatabase() async{
  //   String responce="";
  //   await userref.doc(widget.userid).update({
  //     "Name": nameController.text,
  //     "DateofBirth":selectedDate?.millisecondsSinceEpoch
  //   }).then((value) {
  //     Get.snackbar('Data Updated', "Successfuly Updated",
  //         colorText: Colors.black,
  //         backgroundColor: Colors.deepPurpleAccent);
  //     responce="success";
  //   }).onError((error, stackTrace) {
  //     Get.snackbar('Signup Error', error.toString(),
  //         colorText: Colors.black,
  //         backgroundColor: Colors.deepPurpleAccent);
  //   });
  //   print(responce);
  //   return responce;
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        title: Text(
          '    ${LocaleKeys.addmoredetails.tr}',
          style: TextStyle(color: Colors.black, fontSize: 25),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: EdgeInsets.only(top: 25.sp, left: 12.sp, right: 12.sp),
          child: Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Container(
                  height: Get.height * .15,
                  width: Get.width * .30,
                  decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(width: 1.sp, color: Colors.black)),
                  child: Stack(
                    children: [
                      Container(
                        margin: EdgeInsets.all(8),
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage(
                                    'assets/images/image ${selectedavatarindex}.png'),
                                fit: BoxFit.contain)),
                      ),
                      Positioned(
                        bottom: 8,
                        right: 10,
                        child: GestureDetector(
                          onTap: () {
                            showDialog(
                                context: context,
                                builder: (context) {
                                  return AlertDialog(
                                    title: Center(
                                        child: Text(
                                      LocaleKeys.selectanavatar.tr,
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.bold),
                                    )),
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        Container(
                                          height: Get.height * .3,
                                          width: Get.width * .7,
                                          child: GridView(
                                            physics: BouncingScrollPhysics(),
                                            gridDelegate:
                                                SliverGridDelegateWithFixedCrossAxisCount(
                                                    crossAxisCount: 4,
                                                    mainAxisSpacing: 3.sp,
                                                    crossAxisSpacing: 10,
                                                    childAspectRatio: 0.8
                                                    // childAspectRatio: (2 / 3)
                                                    ),
                                            children: [
                                              for (int i = 1; i < 19; i++)
                                                GestureDetector(
                                                    onTap: () {
                                                      setState(() {
                                                        selectedavatarindex = i;
                                                      });
                                                      Get.back();
                                                    },
                                                    child: Image(
                                                        image: AssetImage(
                                                            'assets/images/image ${i}.png')))
                                            ],
                                          ),
                                        )
                                      ],
                                    ),
                                  );
                                });
                          },
                          child: Container(
                            decoration: BoxDecoration(
                                color: Colors.limeAccent,
                                shape: BoxShape.circle),
                            child: Icon(
                              Icons.add,
                              color: Colors.red,
                            ),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
                SizedBox(
                  height: 8.sp,
                ),
                TextField(
                  keyboardType: TextInputType.emailAddress,
                  onChanged: (value) {
                    username = value;
                  },
                  controller: nameController,
                  decoration: InputDecoration(
                    hintText: LocaleKeys.username.tr,
                    hintStyle: TextStyle(color: Color(0xFFA0A2A8)),
                    fillColor: Color(0xFFF6F6F6),
                    filled: true,
                    contentPadding:
                        EdgeInsets.symmetric(vertical: 25.0, horizontal: 20.0),
                    border: OutlineInputBorder(
                        // borderRadius: BorderRadius.all(Radius.circular(10.0)),
                        borderRadius: BorderRadius.circular(30.sp)),
                    enabledBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 1.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                    focusedBorder: OutlineInputBorder(
                      borderSide: BorderSide(color: Colors.white, width: 2.0),
                      borderRadius: BorderRadius.all(Radius.circular(10.0)),
                    ),
                  ),
                ),
                SizedBox(
                  height: 8.sp,
                ),
                GestureDetector(
                    onTap: () {
                      _selectDate(context);
                    },
                    child: Container(
                      padding: EdgeInsets.symmetric(
                          vertical: 21.0, horizontal: 20.0),
                      decoration: BoxDecoration(
                          color: Color(0xFFF6F6F6),
                          borderRadius: BorderRadius.circular(10)),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            selectedDate == null
                                ? LocaleKeys.dateofbirth.tr
                                : DateFormat.yMMMMEEEEd()
                                    .format(selectedDate!)
                                    .toString(),
                            style: TextStyle(
                                color: selectedDate == null
                                    ? Color(0xFFA0A2A8)
                                    : Colors.black),
                          ),
                          Icon(
                            Icons.keyboard_arrow_down_outlined,
                            color: Color(0xFFA0A2A8),
                          )
                        ],
                      ),
                    )),
                Expanded(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      GestureDetector(
                        onTap: () async {
                          await userref.doc(widget.userid).update({
                            "Name": nameController.text,
                            "DateofBirth": selectedDate?.millisecondsSinceEpoch,
                            "profilePicNo":selectedavatarindex
                          }).then((value) {
                            Get.snackbar('Data Updated', "Successfully Updated",
                                colorText: Colors.black,
                                backgroundColor: Colors.deepPurpleAccent);
                            Get.offAll(() => ScreenUserHomePage());
                          }).onError((error, stackTrace) {
                            Get.snackbar(LocaleKeys.signuperror.tr, error.toString(),
                                colorText: Colors.black,
                                backgroundColor: Colors.deepPurpleAccent);
                          });
                        },
                        child: Container(
                          alignment: Alignment.center,
                          width: Get.width * .6,
                          padding: EdgeInsets.symmetric(vertical: 8.sp),
                          decoration: BoxDecoration(
                              boxShadow: [
                                BoxShadow(
                                    color: Colors.black.withOpacity(0.2),
                                    blurRadius: 13,
                                    spreadRadius: 8,
                                    offset: Offset(1.5, 1.5))
                              ],
                              borderRadius: BorderRadius.circular(20.sp),
                              color: Colors.black),
                          child: Text(
                            LocaleKeys.finish.tr,
                            style: TextStyle(
                                fontWeight: FontWeight.w600,
                                fontSize: 18.sp,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}












// TextField(
//   keyboardType: TextInputType.none,
//   // onChanged: (value) {
//   //   title = value;
//   // },
//   showCursor: false,
//   decoration: InputDecoration(suffixIcon: Icon(Icons.keyboard_arrow_down,color: Colors.black,),
//     hintText: 'Date of Birth',
//     fillColor: Color(0xFFF6F6F6),
//     filled: true,
//     contentPadding: EdgeInsets.symmetric(
//         vertical: 25.0, horizontal: 20.0),
//     border: OutlineInputBorder(
//       // borderRadius: BorderRadius.all(Radius.circular(10.0)),
//         borderRadius: BorderRadius.circular(30.sp)),
//     enabledBorder: OutlineInputBorder(
//       borderSide:
//       BorderSide(color: Colors.white, width: 1.0),
//       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//     ),
//     focusedBorder: OutlineInputBorder(
//       borderSide:
//       BorderSide(color: Colors.white, width: 2.0),
//       borderRadius: BorderRadius.all(Radius.circular(10.0)),
//     ),
//   ),
// ),
