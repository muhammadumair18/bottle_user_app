import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/model/messgengertab.dart';
import 'package:bottle_user_app/view/layout/item_video_view.dart';
import 'package:bottle_user_app/view/screens/screen_user_chat_screen.dart';
import 'package:bottle_user_app/view/screens/screen_user_person_profile.dart';
import 'package:bottle_user_app/view/screens/screen_user_video_view.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:bottle_user_app/model/user.dart' as model;

class ItemHomePagePosts extends StatefulWidget {
  String videoLink,personid;
  int postTime;

  @override
  _ItemHomePagePostsState createState() => _ItemHomePagePostsState();

  ItemHomePagePosts({
    required this.videoLink,
    required this.personid,
    required this.postTime,
  });
}

class _ItemHomePagePostsState extends State<ItemHomePagePosts> {




  @override
  Widget build(BuildContext context) {
    return FutureBuilder<model.User>(future: getUserData(widget.personid),builder: (context,snashots){
      if(!snashots.hasData || snashots.connectionState==ConnectionState.waiting){
        return Center(child: Text('Loading...',style: TextStyle(color: Colors.red,fontSize: 12),));
      }
      if(snashots.hasData){
        model.User user=snashots.data!;
        // var userrrr=snashots.data;
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
              padding: EdgeInsets.symmetric(vertical: 10),
              // height: Get.height * .2,
              child: ListTile(
                tileColor: Colors.white,
                leading: InkWell(
                  onTap: (){
                    Get.to(ScreenUserPersonProfile(personID: widget.personid));
                  },
                  child: Container(
                    height: Get.height * .09.sp,
                    width: Get.width * .09.sp,
                    decoration: BoxDecoration(
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.cover,
                            image: AssetImage("assets/images/image ${user.profilePicNo}.png"))),
                  ),
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
                              fontWeight: FontWeight.w400),
                        ),
                        Text('.  ',style: TextStyle(fontWeight: FontWeight.bold),),
                        InkWell(
                            onTap: () {},
                            child: Text(
                              'Follow',
                              style: TextStyle(
                                  color: Colors.black, fontSize: 17),
                            )),
                      ],
                    ),
                    Text(
                      '7:50',
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
                decoration: BoxDecoration(
                  // image: DecorationImage(
                  //     image: NetworkImage(
                  //         'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80'),
                  //     fit: BoxFit.cover)
                ),
                child: Stack(
                  children: [
                    Column(
                      children: [
                        Expanded(
                          child: ItemVideoView(videoLink: widget.videoLink,),
                        ),
                      ],
                    ),
                    Visibility(
                      visible: !(FirebaseAuth.instance.currentUser!.uid==widget.personid),
                      child: Padding(
                        padding: EdgeInsets.only(left: 30),
                        child: Row(
                          mainAxisSize: MainAxisSize.max,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            IconButton(
                                onPressed: () {
                                  _createTAbHead(widget.personid);
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

              // Stack(
              //   children: [
              //     Image(
              //       image: NetworkImage("https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80"),
              //       fit: BoxFit.fill,
              //     ),
              //     IconButton(onPressed: (){}, icon: Icon(Icons.chat,color: Colors.black,))
              //   ],
              // ),
            ),
            SizedBox(
              height: 5.sp,
            )
          ],
        );
      }
      return Text('No data',style: TextStyle(color: Colors.red,fontSize: 12),);

    });
  }

  Future<void> _createTAbHead(String ussi) async{
    bool checking= await _checkcheck(ussi);
    if(!checking){
      var persondata=await userref.doc(ussi).get();
      MessengerTab tb=MessengerTab(name: persondata["Name"], phototid: persondata["profilePicNo"], id: persondata["id"]);
      // var persoid= await userref.doc(FirebaseAuth.instance.currentUser!.uid).snapshots().map((event) => model.User.fromMap(event.data() as Map<String,dynamic>)).toList();
      var persoid= await userref.doc(FirebaseAuth.instance.currentUser!.uid).get();
      MessengerTab bt=MessengerTab(name: persoid["Name"], phototid: persoid["profilePicNo"], id: persoid["id"]);
      await userref.doc(FirebaseAuth.instance.currentUser!.uid).collection("messagetab").doc(persondata["id"]).set(tb.toMap());
      await userref.doc(persondata["id"]).collection("messagetab").doc(FirebaseAuth.instance.currentUser!.uid).set(bt.toMap());
      Get.to(ScreenUserChatScreen(toWhomChat: ussi));
    }
    else{
      Get.to(ScreenUserChatScreen(toWhomChat: ussi));
    }
  }

  Future<bool> _checkcheck(String ussi)async{
    final ssss=await userref.doc(FirebaseAuth.instance.currentUser!.uid).collection('messagetab').doc(ussi).get();
    return ssss.exists;
  }


}
