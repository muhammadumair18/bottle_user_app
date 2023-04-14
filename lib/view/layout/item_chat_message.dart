import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ItemChatMessage extends StatelessWidget {

  bool mySelf;
  String message,time;

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: mySelf?MainAxisAlignment.start:MainAxisAlignment.end,
      children: [
        ConstrainedBox(
          constraints: BoxConstraints(maxWidth: Get.width * 0.8),
          child: Container(
            // alignment: Alignment.centerLeft,
            decoration: BoxDecoration(
            //     boxShadow: [
            //   BoxShadow(
            //     color: Colors.black,
            //     blurRadius: 4,
            //     offset: Offset(4, 8),
            //   )
            // ],
                color: mySelf?Colors.blue:Color(0xffD7D7D7),
                borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(10),
                    topRight: Radius.circular(10),
                    bottomRight: Radius.circular(10))),
            margin: EdgeInsets.symmetric(vertical: 15, horizontal: 8),
            // alignment: Alignment.topRight,
            padding: EdgeInsets.symmetric(vertical: 10, horizontal: 20),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                ExpandableText(
                  message,
                  widgetTextStyle: TextStyle(
                      color: mySelf?Colors.white:Colors.black,
                      fontSize: 12.sp,
                      fontWeight: FontWeight.w400),
                  trimLines: 3,
                  read_more_textStyle: TextStyle(
                      color: Colors.white.withOpacity(.7)
                  ),
                ),
                SizedBox(
                  height: 4,
                ),
                Text(
                  '${time} ${LocaleKeys.ago.tr}',
                  style: TextStyle(
                      color: mySelf?Colors.white:Colors.black,
                      fontSize: 8.sp,
                      fontWeight: FontWeight.w400),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

  ItemChatMessage({
    required this.mySelf,
    required this.message,
    required this.time,
  });
}
