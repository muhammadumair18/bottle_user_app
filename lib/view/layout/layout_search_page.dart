import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/view/layout/layout_search_map.dart';
import 'package:bottle_user_app/view/layout/layout_search_posts.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

import '../../helpers/helpers.dart';

class LayoutSearchPage extends StatefulWidget {
  @override
  _LayoutSearchPageState createState() => _LayoutSearchPageState();
}

class _LayoutSearchPageState extends State<LayoutSearchPage> {
  int radiusMiles = 4;
  bool location = true;

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [
          Padding(
            padding: EdgeInsets.only(left: 12, right: 12, top: 14),
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Expanded(
                      child: Container(
                        height: Get.height * .068,
                        child: TextFormField(
                            decoration: InputDecoration(
                                fillColor: Color(0xffD9D9D9),
                                filled: true,
                                hintText: LocaleKeys.whatareyouseeing.tr,
                                border: OutlineInputBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 1.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Colors.white, width: 2.0),
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(15.0)),
                                ),
                                prefixIcon: Icon(
                                  Icons.search,
                                  color: Colors.black,
                                ))),
                      ),
                    ),
                    SizedBox(
                      width: 8,
                    ),
                    GestureDetector(
                      onTap: () {
                        location = false;
                        setState(() {});
                      },
                      child: Container(
                        height: Get.height * .045,
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: location == false
                                ? Border.all(width: 1, color: Colors.black)
                                : null),
                        child: Icon(
                          Icons.format_list_numbered,
                          color: Colors.black,
                          size: Get.height * .03,
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 9.sp,
                    ),
                    GestureDetector(
                      onTap: () {
                        location = true;
                        setState(() {});
                      },
                      child: Container(
                        height: Get.height * .045,
                        // width: Get.width / 12,
                        // height: Get.height / 23,
                        padding:
                            EdgeInsets.symmetric(vertical: 3, horizontal: 3),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(5),
                            border: location
                                ? Border.all(width: 1, color: Colors.black)
                                : null),
                        child: Icon(
                          Icons.location_on,
                          color: Colors.black,
                          size: Get.height * .03,
                        ),
                      ),
                    )
                  ],
                ),
                Padding(
                  padding: EdgeInsets.only(left: 10.sp, right: 10.sp, top: 5),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        LocaleKeys.inradius.tr,
                        style: TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                            fontWeight: FontWeight.w600),
                      ),
                      Text(
                        "${radiusMiles} ${LocaleKeys.miles.tr}",
                        style: TextStyle(
                            color: Colors.black,
                            fontWeight: FontWeight.w400,
                            fontSize: 14),
                      )
                    ],
                  ),
                ),
                Row(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    Expanded(
                      child: Slider(
                          thumbColor: Colors.black,
                          activeColor: Colors.black,
                          max: 10,
                          min: 0,
                          divisions: 10,
                          value: radiusMiles.toDouble(),
                          onChanged: (nvalue) {
                            setState(() {
                              radiusMiles = nvalue.round();
                            });
                          }),
                    ),
                  ],
                ),
              ],
            ),
          ),
          FutureBuilder(
              future: examplecheckPermissionStatus(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Expanded(
                      child: Center(child: CircularProgressIndicator(
                      color: Colors.red,
                    ),
                  ));
                }
                if (snapshot.data == true) {
                  print("Snapshot data si sisis    ${snapshot.data}");
                  return Expanded(child: location?LayoutSearchMap(betweenRange: radiusMiles,):LayoutSearchPosts(betweenRange: radiusMiles,));
                }
                return Expanded(
                    child: Center(
                  child: Text(LocaleKeys.nodata.tr),
                ));
              })
        ],
      ),
    );
  }
}

// Expanded(child: location?LayoutSearchMap(betweenRange: radiusMiles,):LayoutSearchPosts(betweenRange: radiusMiles,))

// FutureBuilder(
// future: examplecheckPermissionStatus(),
// builder: (context, snapshot) {
// if(snapshot.connectionState==ConnectionState.waiting){
// return Expanded(child: Center(child: CircularProgressIndicator(color: Colors.red,),));
// }
// if(snapshot.data == true){
// print( "Snapshot data si sisis    ${snapshot.data}");
// return Expanded(child:Center(
// child: Text('Data Available',style: TextStyle(color: Colors.red,fontSize: 25),),
// ) );
// }
// return Expanded(child: Center(child: Text('No data'),));
// }
// )
