import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/model/messaagdetails.dart';
import 'package:bottle_user_app/view/layout/item_chat_message.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ScreenUserChatScreen extends StatefulWidget {

  String toWhomChat;

  @override
  _ScreenUserChatScreenState createState() => _ScreenUserChatScreenState();

  ScreenUserChatScreen({
    required this.toWhomChat,
  });
}

class _ScreenUserChatScreenState extends State<ScreenUserChatScreen> {
  TextEditingController messageSendController = TextEditingController();

  String messageText='';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: Get.height * .09,
        shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(12),
                bottomRight: Radius.circular(12))),
        centerTitle: true,
        leading: IconButton(
          onPressed: () {
            Get.back();
          },
          icon: Icon(
            Icons.arrow_back_ios,
            color: Colors.black,
          ),
        ),
        title: Text(
          'Ryan Sellers',
          style: TextStyle(
              fontWeight: FontWeight.w500, fontSize: 20, color: Colors.black),
        ),
        actions: [
          Row(
            children: [
              Container(
                height: Get.height * .11,
                width: Get.width * .11,
                decoration: BoxDecoration(
                    // border: Border.all(width: 1.sp, color: Colors.red),
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        fit: BoxFit.cover,
                        image: NetworkImage(
                            'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80'))),
              ),
              SizedBox(
                width: 8,
              )
            ],
          )
        ],
      ),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: SingleChildScrollView(
                reverse: true,
                child: Column(
                  mainAxisSize: MainAxisSize.max,
                  children: [
                    StreamBuilder<QuerySnapshot>(stream: userref.doc(FirebaseAuth.instance.currentUser!.uid).collection("messagetab").doc(widget.toWhomChat).collection("messagedetails").snapshots(),builder: (context,snapshots){
                      if(!snapshots.hasData||snapshots.connectionState==ConnectionState.waiting)
                      {
                        return Center(
                          child: Text(LocaleKeys.loadingornodata.tr,style: TextStyle(color: Colors.red,fontSize: 20),),
                        );
                      }
                      var innerdata=snapshots.data!.docs.map((e) => messaagdetails.fromMap(e.data() as Map<String,dynamic>)).toList();
                      return ListView.builder(scrollDirection: Axis.vertical,shrinkWrap: true,itemCount: innerdata.length,itemBuilder: (context,index){
                        var innervar=innerdata[index];

                        return ItemChatMessage(mySelf: FirebaseAuth.instance.currentUser!.uid==innervar.senderId, message: innervar.messagebody, time: "${DateTime.now()}");
                      });
                    }),
                    // Row(
                    //   mainAxisAlignment: MainAxisAlignment.start,
                    //   children: [
                    //     Container(
                    //         width: Get.width,
                    //         height: Get.height / 5,
                    //         child: GestureDetector(onTap: (){},
                    //           child: FlareActor(
                    //             'assets/flare/typing.flr',
                    //             animation: 'typing',
                    //             color: Colors.amber,
                    //             isPaused: true,
                    //           ),
                    //         )),
                    //   ],
                    // ),
                    SizedBox(
                      height: Get.height / 30,
                    )
                  ],
                ),
              ),
            ),
            Container(
              padding: EdgeInsets.symmetric(vertical: 15),
              decoration: BoxDecoration(
                  color: Colors.white,
                  boxShadow: [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 5,
                        spreadRadius: 2,
                        offset: Offset(1.5, 1.5))
                  ],
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  )),
              height: Get.height / 10,
              child: Row(
                children: [
                  SizedBox(
                    width: 10,
                  ),
                  Expanded(
                      child: TextFormField(
                        onChanged: (value){
                          messageText=value;
                        },
                    controller: messageSendController,
                    decoration: InputDecoration(
                      contentPadding: EdgeInsets.symmetric(horizontal: 25),
                      fillColor: Color(0xffD9D9D9),
                      filled: true,
                      hintText: LocaleKeys.entermessage.tr,
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      enabledBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 1.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide:
                            BorderSide(color: Colors.white, width: 2.0),
                        borderRadius: BorderRadius.all(Radius.circular(15.0)),
                      ),
                    ),
                  )),
                  IconButton(
                    onPressed: () {},
                    icon: Icon(
                      Icons.attach_file,
                      color: Colors.black,
                      size: (Get.height / 10) / 3,
                    ),
                  ),
                  GestureDetector(
                    onTap: () async{
                      messageSendController.text = '';
                       await _generateMessage();
                    },
                    child: Container(
                      padding:
                          EdgeInsets.symmetric(vertical: 8, horizontal: 8),
                      decoration: BoxDecoration(
                          color: Colors.black,
                          borderRadius: BorderRadius.circular(6)),
                      child: Text(
                        LocaleKeys.send.tr,
                        style: TextStyle(color: Colors.white, fontSize: 15),
                      ),
                    ),
                  ),
                  SizedBox(
                    width: 6,
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }






  Future<void> _generateMessage() async{
    var messege=await FirebaseFirestore.instance.collection('users').doc(FirebaseAuth.instance.currentUser!.uid).collection("messagetab").doc(widget.toWhomChat).collection('messagedetails').get();
    int length=messege.docs.length;
    if(messageText.isEmpty)
      {
        Get.snackbar('Warning', 'No text has been written.',
            colorText: Colors.black,
            backgroundColor: Colors.deepPurpleAccent);
      }
    else{
      int date=DateTime.now().microsecondsSinceEpoch;
      messaagdetails mess=messaagdetails(senderId: FirebaseAuth.instance.currentUser!.uid, messagebody: messageText, sendtime: date);
      await userref.doc(FirebaseAuth.instance.currentUser!.uid).collection("messagetab").doc(widget.toWhomChat).collection('messagedetails').doc('message ${length}').set(mess.toMap());
      await userref.doc(widget.toWhomChat).collection("messagetab").doc(FirebaseAuth.instance.currentUser!.uid).collection('messagedetails').doc('message ${length}').set(mess.toMap());
    }

  }


}
