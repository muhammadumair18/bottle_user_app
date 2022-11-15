import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';

class ItemTop10Story extends StatefulWidget {
  String profilePic,userName;
  bool forChat;




  @override
  _ItemTop10StoryState createState() => _ItemTop10StoryState();

  ItemTop10Story({
    required this.profilePic,
    required this.userName,
    required this.forChat
  });
}

class _ItemTop10StoryState extends State<ItemTop10Story> {
  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          margin: EdgeInsets.symmetric(horizontal: 6.sp),
          height: widget.forChat?Get.height * .10:Get.height * .10,
          width: widget.forChat?Get.width * .15:Get.width * .20,
          padding: EdgeInsets.all(3),
          decoration: BoxDecoration(
              shape: BoxShape.circle,
              border: Border.all(width: 1.sp, color: Colors.black)),
          child: Container(
            decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                    image: AssetImage(widget.profilePic),
                    fit: BoxFit.contain)),
          ),
        ),
        SizedBox(height: 5.sp,),
        Text(widget.userName,style: TextStyle(color: Colors.black,fontSize: 15),)
      ],
    );
  }
}




//
// height: Get.height * .10,
// width: Get.width * .15,