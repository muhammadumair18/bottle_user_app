import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/model/posts.dart';
import 'package:bottle_user_app/view/layout/item_video_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:bottle_user_app/model/user.dart' as model;

class ScreenUserPersonProfile extends StatefulWidget {

  String personID;


  @override
  _ScreenUserPersonProfileState createState() =>
      _ScreenUserPersonProfileState();

  ScreenUserPersonProfile({
    required this.personID,
  });
}

class _ScreenUserPersonProfileState extends State<ScreenUserPersonProfile> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.black,
        leading: IconButton(icon: Icon(Icons.arrow_back_ios_rounded,color: Colors.white,),onPressed: (){
          Get.back();
        },),
        actions: [
          PopupMenuButton(
            onSelected: choiceAction,
              itemBuilder: (BuildContext context){
            return ChoicesofMenu.map((e){
              return PopupMenuItem<String>(
                child: Text(e),
                value: e,);
            }).toList();
          }),
          // Icon(Icons.more_vert,color: Colors.white,),
          SizedBox(width: 8,)
        ],
      ),
      body: FutureBuilder(
        future: getUserData(widget.personID),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if(snapshot.connectionState==ConnectionState.waiting){
            return Center(child: CircularProgressIndicator(color: Colors.blue,));
          }
          if(snapshot.hasData){
            model.User user=snapshot.data;
            return Column(
              children: [
                Container(padding: EdgeInsets.only(left: 15,right: 20,top: 15),
                  height: Get.height * .35,
                  width: Get.width,
                  decoration: BoxDecoration(
                      color: Colors.black,
                      borderRadius: BorderRadius.only(
                          bottomRight: Radius.circular(90)
                      )
                  ),
                  child: Column(
                    children: [
                      Row(
                        children: [
                          Container(
                            height: Get.height * .12,
                            width: Get.width * .30,
                            decoration: BoxDecoration(
                                shape: BoxShape.circle,
                                image: DecorationImage(
                                    image: AssetImage('assets/images/image ${user.profilePicNo}.png'),
                                    fit: BoxFit.contain
                                )
                            ),
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(user.Name,style: TextStyle(color: Colors.white,fontSize: 20,fontWeight: FontWeight.bold),),
                              SizedBox(height: 4,),
                              Text('Doctor,  Student ❤',style: TextStyle(color: Colors.white),),
                            ],
                          )
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.end,
                        children: [
                          Container(
                            padding: EdgeInsets.symmetric(vertical: 4,horizontal: 5),
                            decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(width: 1,color: Colors.white)
                            ),
                            child: Row(
                              children: [
                                Icon(Icons.add,color: Colors.white,),
                                Text(LocaleKeys.follow.tr,style: TextStyle(color: Colors.white,fontSize: 18,fontWeight: FontWeight.w500),)
                              ],
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
                Expanded(
                  child: Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(90)
                        )
                    ),
                    child: StreamBuilder<QuerySnapshot>(
                      stream: postref.where('userID',isEqualTo: widget.personID).snapshots(),
                      builder: (context, streamsnapshot) {
                      if(streamsnapshot.connectionState==ConnectionState.waiting){
                        return CircularProgressIndicator(color: Colors.red,);
                      }
                      if(streamsnapshot.hasData){
                        var videoData=streamsnapshot.data!.docs.map((e) => posts.fromMap(e.data() as Map<String,dynamic>)).toList();
                        return ListView.builder(
                            physics: BouncingScrollPhysics(),
                            itemCount: videoData.length,
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemBuilder: (BuildContext context,int index){
                              var innerdata=videoData[index];
                              return Column(
                                children: [
                                  SizedBox(
                                    width: Get.width,
                                    height: 0.5.sp,
                                    child: Divider(
                                      color: Colors.black,
                                    ),
                                  ),
                                  Container(
                                    padding: EdgeInsets.symmetric(vertical: 4),
                                    // height: Get.height * .2,
                                    child: ListTile(
                                      tileColor: Colors.white,
                                      leading: Container(
                                        height: Get.height * .09.sp,
                                        width: Get.width * .09.sp,
                                        decoration: BoxDecoration(
                                            border:
                                            Border.all(width: 1.sp, color: Colors.red),
                                            shape: BoxShape.circle,
                                            image: DecorationImage(
                                                fit: BoxFit.cover,
                                                image: AssetImage("assets/images/image ${user.profilePicNo}.png"))),
                                      ),
                                      title: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Row(
                                            children: [
                                              Text(
                                                user.Name,
                                                style: TextStyle(
                                                    fontSize: 15.sp,
                                                    fontWeight: FontWeight.w500),
                                              ),
                                              Text('.  '),
                                              InkWell(
                                                  onTap: () {},
                                                  child: Text(
                                                    LocaleKeys.follow.tr,
                                                    style: TextStyle(
                                                        color: Colors.black, fontSize: 17),
                                                  )),
                                            ],
                                          ),
                                          Text(
                                            DateTime.fromMillisecondsSinceEpoch(innerdata.uploadTime).toString(),
                                            style: TextStyle(
                                                fontSize: 12.sp,
                                                fontWeight: FontWeight.w400),
                                          ),
                                        ],
                                      ),
                                      trailing: IconButton(
                                        onPressed: () {},
                                        icon: Icon(Icons.more_horiz_outlined),
                                      ),
                                    ),
                                  ),
                                  Container(
                                      width: Get.width,
                                      height: Get.height * .7,
                                      child: Stack(
                                        children: [
                                          Column(
                                            children: [
                                              Expanded(
                                                child: ItemVideoView(videoLink: innerdata.videoUrl,),
                                              ),
                                            ],
                                          ),
                                          Visibility(
                                            visible: !(FirebaseAuth.instance.currentUser!.uid==user.id),
                                            child: Padding(
                                              padding: EdgeInsets.only(left: 30),
                                              child: Row(
                                                mainAxisSize: MainAxisSize.max,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                mainAxisAlignment: MainAxisAlignment.end,
                                                children: [
                                                  IconButton(
                                                      onPressed: () {
                                                      },
                                                      icon: Icon(
                                                        Icons.chat,
                                                        color: Colors.white,
                                                        size: 35,
                                                      )),
                                                  SizedBox(
                                                    width: 8,
                                                  )
                                                ],
                                              ),
                                            ),
                                          ),
                                        ],
                                      )

                                  ),
                                  SizedBox(
                                    height: 5.sp,
                                  )
                                ],
                              );
                            });
                      }
                      return Text(LocaleKeys.nodataavailable.tr,style: TextStyle(color: Colors.red,fontSize: 15),);
                    },),
                  ),
                )
              ],
            );
          }
        return Center(child: Text(LocaleKeys.nodataavailable.tr,style: TextStyle(color: Colors.red,fontSize: 20),),);
      },),
    );
  }
}
