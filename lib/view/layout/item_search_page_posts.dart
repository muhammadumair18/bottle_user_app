import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/model/posts.dart';
import 'package:bottle_user_app/view/layout/item_video_view.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sizer/sizer.dart';
import 'package:bottle_user_app/model/user.dart' as model;

class ItemSearchPagePosts extends StatefulWidget {
  String videoLink;
  int? profilePic;
  bool liked;
  String documentName;
  int dateUploaded;
  String userID;


  @override
  _ItemSearchPagePostsState createState() => _ItemSearchPagePostsState();

  ItemSearchPagePosts({
    required this.videoLink,
    this.profilePic,
    required this.liked,
    required this.documentName,
    required this.dateUploaded,
    required this.userID
  });
}

class _ItemSearchPagePostsState extends State<ItemSearchPagePosts> {

  DateTime? ddaattee;
  model.User? ussssi;
  @override
  void initState() {
    // TODO: implement initState
    ddaattee=DateTime.fromMillisecondsSinceEpoch(widget.dateUploaded);
    super.initState();
    // WidgetsBinding.instance!.addPostFrameCallback((_) {
    //   getuserdata(widget.userID);
    // });
    // Future.delayed(Duration.zero,()async{
    //   await getuserdata(widget.userID);
    // });

    getuserdata(widget.userID);
  }
  @override
  Widget build(BuildContext context) {
    return FutureBuilder<model.User>(
      future: getUserData(widget.userID),
      builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
        if(snapshot.hasData){
          return Column(
            children: [
              SizedBox(
                width: Get.width,
                height: 3.sp,
                child: Divider(
                  color: Color(0xffC4C4C4).withOpacity(.24),
                ),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 4),
                // height: Get.height * .2,
                child: ListTile(
                  tileColor: Colors.white,
                  leading: Container(
                    height: Get.height * .08.sp,
                    width: Get.width * .08.sp,
                    decoration: BoxDecoration(
                        border:
                        Border.all(width: 1.sp, color: Colors.red),
                        shape: BoxShape.circle,
                        image: DecorationImage(
                            fit: BoxFit.contain,
                            image: AssetImage("assets/images/image ${ussssi?.profilePicNo}.png"))),
                  ),
                  title: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "${ussssi?.Name}",
                            style: TextStyle(
                                fontSize: 15.sp,
                                fontWeight: FontWeight.w500),
                          ),

                        ],
                      ),
                      Text(
                        '${ddaattee}',
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
                height: Get.height * .5,
                child: ItemVideoView(videoLink: widget.videoLink,),
              ),
              Container(
                padding: EdgeInsets.symmetric(vertical: 3,horizontal: 3),
                child: Row(
                  children: [
                    IconButton(onPressed: ()async{
                      await checkILiked();
                    }, icon: Icon(Icons.favorite,color: widget.liked?Colors.red:Colors.black,),),
                    IconButton(onPressed: (){},icon: Icon(Icons.chat,color: Colors.black,),),
                    IconButton(onPressed: (){},icon: Icon(Icons.share,color: Colors.black,),),
                  ],
                ),
              )
            ],
          );
        }
      return Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text('.....',style: TextStyle(color: Colors.red,fontSize: 12),),
        ],
      );
    },);
  }

  Future<void> checkILiked() async{
    var postdata=await postref.doc(widget.documentName).get();
    posts postconverted=posts.fromMap(postdata.data() as Map<String,dynamic>);
    if(postconverted.likes.contains(FirebaseAuth.instance.currentUser!.uid)){
      await postref.doc(widget.documentName).update({
        'likes':FieldValue.arrayRemove([FirebaseAuth.instance.currentUser!.uid])
      });
    }
    else{
      await postref.doc(widget.documentName).update({
        'likes':FieldValue.arrayUnion([FirebaseAuth.instance.currentUser!.uid])
      });
    }
  }

  // Future<model.User> getuserdata(String id)async{
  //   var perondata=await userref.doc(id).get();
  //    model.User iner=model.User.fromMap(perondata.data() as Map<String,dynamic>);
  //    return iner;
  // }

  void getuserdata(String id)async{
    var perondata=await userref.doc(id).get();
    ussssi=model.User.fromMap(perondata.data() as Map<String,dynamic>);
  }

}


