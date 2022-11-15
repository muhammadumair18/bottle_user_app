import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';


class ItemMessageTab extends StatelessWidget {

  int picNo;
  String Name;


  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 8.sp,),
      child: ListTile(
          leading: Container(
            height: Get.height * .15,
            width: Get.width * .15,
            decoration: BoxDecoration(
              // border: Border.all(width: 1.sp, color: Colors.red),
                shape: BoxShape.circle,
                image: DecorationImage(
                    fit: BoxFit.contain,
                    image: AssetImage('assets/images/image ${picNo}.png'))),
          ),
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                Name,
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.bold),
              ),
              Text(
                'I have send you a message please read it.',
                style: TextStyle(fontSize: 15, fontWeight: FontWeight.w400,color: Color(0xff707070)),
              ),
            ],
          ),
          trailing:Text('5:03 am',style: TextStyle(fontSize: 10,fontWeight: FontWeight.w400,color:Color(0xff5C5C5C) ),)
      ),
    );
  }

  ItemMessageTab({
    required this.picNo,
    required this.Name,
  });
}
