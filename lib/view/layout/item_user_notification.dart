import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
class ItemUserNotification extends StatelessWidget {

  String notificationTitle,notificationDescription;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(onTap: (){

    },
      child: Container(
        margin: EdgeInsets.symmetric(horizontal: 13,vertical: 12),
        padding: EdgeInsets.symmetric(vertical: 13,horizontal: 7),
        decoration: BoxDecoration(color: Colors.white,
            boxShadow: [
              BoxShadow(color: Colors.grey.withOpacity(0.5),
                  blurRadius: 1,
                  spreadRadius: 2,
                  offset: Offset(1.5,1.5)
              )
            ]
        ),
        child: ListTile(
          title: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(notificationTitle,style: TextStyle(color: Colors.black,fontSize: 18,fontWeight: FontWeight.bold),),
              SizedBox(height: 5.sp,),
              Text(notificationDescription,style: TextStyle(color: Colors.black.withOpacity(.5),fontSize: 15),),
            ],
          ),
          trailing: Icon(Icons.email_outlined,color: Colors.black,),
        ),
      ),
    );
  }

  ItemUserNotification({
    required this.notificationTitle,
    required this.notificationDescription,
  });
}
