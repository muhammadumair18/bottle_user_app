import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:place_picker/entities/localization_item.dart';
import 'package:place_picker/widgets/place_picker.dart';
import 'package:sizer/sizer.dart';

class ScreenUserAllowLocation extends StatefulWidget {
  const ScreenUserAllowLocation({Key? key}) : super(key: key);

  @override
  _ScreenUserAllowLocationState createState() =>
      _ScreenUserAllowLocationState();
}

class _ScreenUserAllowLocationState extends State<ScreenUserAllowLocation> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
            height: Get.height,
            width: Get.width,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                    height: Get.height / 2.5,
                    child: Image(
                      image:
                          AssetImage('assets/images/otp_verification_logo.png'),
                    )),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "Allow Share Bottle to",
                    ),
                    Text(
                      "use your location",
                    ),
                  ],
                ),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      "This app requires access to your",
                    ),
                    Text(
                      "location to match with the nearest",
                    ),
                    Text(
                      "Clubs",
                    ),
                  ],
                ),
                GestureDetector(
                  onTap: () async {
                    await Navigator.of(context).push(MaterialPageRoute(
                        builder: (context) => PlacePicker(
                              'AIzaSyBSNAcxrBVFuPCBTUGQ9rhzFM8lrpNVIOY',
                              displayLocation:
                                  LatLng(32.593426114554106, 51.65810321495997),
                              localizationItem: LocalizationItem(),
                            )));
                  },
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width / 2,
                    padding: EdgeInsets.symmetric(vertical: 8.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        color: Colors.black),
                    child: Text(
                      'Allow',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 17.sp,
                          color: Colors.white),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width / 2,
                    padding: EdgeInsets.symmetric(vertical: 8.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        border: Border.all(width: 1.sp, color: Colors.black),
                        color: Colors.white),
                    child: Text(
                      'Allow While using app',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 12.sp,
                          color: Colors.black),
                    ),
                  ),
                ),
                GestureDetector(
                  onTap: () {},
                  child: Container(
                    alignment: Alignment.center,
                    width: Get.width / 2,
                    padding: EdgeInsets.symmetric(vertical: 8.sp),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(20.sp),
                        border: Border.all(width: 1.sp, color: Colors.black),
                        color: Colors.white),
                    child: Text(
                      'Dont Allow',
                      style: TextStyle(
                          fontWeight: FontWeight.w600,
                          fontSize: 14.sp,
                          color: Colors.black),
                    ),
                  ),
                ),
                SizedBox(
                  height: 4,
                )
              ],
            )),
      ),
    );
  }
}
