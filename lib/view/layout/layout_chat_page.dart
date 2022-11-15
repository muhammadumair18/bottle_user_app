import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/model/messgengertab.dart';
import 'package:bottle_user_app/model/user.dart' as model;
import 'package:bottle_user_app/view/layout/item_admin_top_10_story.dart';
import 'package:bottle_user_app/view/layout/item_message_tab.dart';
import 'package:bottle_user_app/view/screens/screen_user_chat_screen.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';


class LayoutChatPage extends StatefulWidget {

  @override
  _LayoutChatPageState createState() => _LayoutChatPageState();
}

class _LayoutChatPageState extends State<LayoutChatPage> {


  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(top: 10,left: 5,right: 5),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.only(top: 12,left: 8,right: 8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text('Chat',style: TextStyle(fontSize: 35,fontWeight: FontWeight.w600),),
                SizedBox(height: 5,),
                Container(
                  height: Get.height * .06,
                  child: TextFormField(textAlignVertical: TextAlignVertical.center,
                    decoration: InputDecoration(
                        // contentPadding: EdgeInsets.zero,
                        fillColor: Color(0xffD9D9D9),
                        filled: true,
                        hintText: "Search",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 1.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderSide:
                          BorderSide(color: Colors.white, width: 2.0),
                          borderRadius: BorderRadius.all(Radius.circular(32.0)),
                        ),
                        suffixIcon: Icon(Icons.search,color: Colors.black,)
                    ),
                  ),
                ),
              ],
            ),
          ),
          Container(
            // color: Colors.red,
            height: Get.height * .18,
            child: StreamBuilder<QuerySnapshot>(
              stream: userref.where("id",isNotEqualTo: FirebaseAuth.instance.currentUser!.uid).snapshots(),
              builder: (context,snapshot) {
              if(snapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(),);
              }
              if(snapshot.hasData){
                var postts=snapshot.data!.docs.map((e) => model.User.fromMap(e.data() as Map<String,dynamic>)).toList();
                return ListView.builder(
                  scrollDirection: Axis.horizontal,
                  itemCount: postts.length,
                  itemBuilder: (BuildContext context, int index) {
                    var innerposts=postts[index];
                    return GestureDetector(
                      onTap: () async{
                        await _createTAbHead(innerposts);
                      },
                      child: ItemTop10Story(
                        profilePic: 'assets/images/image ${innerposts.profilePicNo}.png',
                        userName: innerposts.Name,
                        forChat: true,),
                    );
                  },
                );
              }
              return Center(child: Text('No Data Available',style: TextStyle(color: Colors.red,fontSize: 15),),);
            },),
          ),
          Text('  Recent',style: TextStyle(fontWeight: FontWeight.w500,fontSize: 22),),
          Expanded(
            child: StreamBuilder<QuerySnapshot>(
              stream: userref.doc(FirebaseAuth.instance.currentUser!.uid).collection("messagetab").snapshots(),
              builder: (context,snapshots){
                if(snapshots.connectionState==ConnectionState.waiting)
                  {
                    return Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                if(snapshots.hasData){
                  var innerdata=snapshots.data!.docs.map((e) => MessengerTab.fromMap(e.data() as Map<String,dynamic>)).toList();
                  return ListView.builder(physics: BouncingScrollPhysics(),
                      scrollDirection: Axis.vertical,shrinkWrap: true,
                      itemCount: innerdata.length,
                      itemBuilder: (BuildContext context,int index){
                        var innervar=innerdata[index];
                        return GestureDetector(onTap: (){
                          Get.to(ScreenUserChatScreen(toWhomChat: innervar.id,));
                        },child: ItemMessageTab(Name: innervar.name,picNo: innervar.phototid,));
                      });
                }
                return Center(child: Text('No Data',style: TextStyle(color: Colors.red,fontSize: 15),),);
              },
            ),
          )
        ],
      ),
    );
  }

  Future<void> _createTAbHead(model.User ussi) async{
   bool checking= await _checkcheck(ussi);
    if(!checking){
      MessengerTab tb=MessengerTab(name: ussi.Name, phototid: ussi.profilePicNo, id: ussi.id);
      // var persoid= await userref.doc(FirebaseAuth.instance.currentUser!.uid).snapshots().map((event) => model.User.fromMap(event.data() as Map<String,dynamic>)).toList();
      var persoid= await userref.doc(FirebaseAuth.instance.currentUser!.uid).get();
      MessengerTab bt=MessengerTab(name: persoid["Name"], phototid: persoid["profilePicNo"], id: persoid["id"]);
      await userref.doc(FirebaseAuth.instance.currentUser!.uid).collection("messagetab").doc(ussi.id).set(tb.toMap());
      await userref.doc(ussi.id).collection("messagetab").doc(FirebaseAuth.instance.currentUser!.uid).set(bt.toMap());
    }
    else{
      Get.snackbar('Reminder', 'The Chat Head is already created',
          colorText: Colors.black,
          backgroundColor: Colors.deepPurpleAccent);
    }
  }

  Future<bool> _checkcheck(model.User ussi)async{
    final ssss=await userref.doc(FirebaseAuth.instance.currentUser!.uid).collection('messagetab').doc(ussi.id).get();
    return ssss.exists;
  }


}
