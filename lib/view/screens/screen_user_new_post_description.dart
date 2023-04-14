import 'dart:io';
import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:bottle_user_app/model/posts.dart';
import 'package:bottle_user_app/view/screens/screen_user_home_page.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:custom_utils/custom_utils.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:path_provider/path_provider.dart';
import 'package:video_compress/video_compress.dart';
import 'package:video_player/video_player.dart';



class ScreenUserNewPostDescription extends StatefulWidget {
  String videoPath;

  @override
  _ScreenUserNewPostDescriptionState createState() =>
      _ScreenUserNewPostDescriptionState();

  ScreenUserNewPostDescription({
    required this.videoPath,
  });
}

class _ScreenUserNewPostDescriptionState
    extends State<ScreenUserNewPostDescription> {


  late VideoPlayerController _videoPlayController;
  File? checkingPath;
  File? uppfile;
  var uuID = FirebaseAuth.instance.currentUser!.uid;
  String description='';
  bool isloading=false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    // processPlayer();
    checkingPath = File(widget.videoPath);
    File fv = File(widget.videoPath);
    _videoPlayController = VideoPlayerController.file(fv)
    ..initialize().then((value) {
      setState(() {});
      _videoPlayController.play();
      _videoPlayController.setLooping(false);
    });
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _videoPlayController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return CustomProgressWidget(
      loading: isloading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          backgroundColor: Colors.white,
          leading: IconButton(
              onPressed: () {
                Get.offAll(ScreenUserHomePage());
              },
              icon: Icon(
                Icons.arrow_back,
                color: Colors.black,
              )),
          title: Text(
            LocaleKeys.newstory.tr,
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Container(
                height: Get.height * .5,
                child: _videoPlayController.value.isInitialized?
                AspectRatio(
                    aspectRatio:_videoPlayController.value.aspectRatio,
                    child: VideoPlayer(_videoPlayController)):
                Center(child: CircularProgressIndicator(color: Colors.black,)),
              ),
              Container(
                  margin: EdgeInsets.symmetric(horizontal: 4.sp),
                  child: CustomInputField(onChange: (value){
                    description=value.toString();
                  },
                    isPasswordField: false,
                    hint: LocaleKeys.mentionhere.tr,
                    maxLines: 2,
                    limit: 25,
                  )),
              GestureDetector(
                onTap: () async {
                  bool checki=await checkPermissionStatus();
                  if(checki==true){
                    isloading=true;
                    setState(() {});
                    var myPosition = await Geolocator.getCurrentPosition();
                    String responce='';
                    responce=await _uploadPost(LatLng(myPosition.latitude, myPosition.longitude));
                    if(responce=="success"){
                      Get.offAll(ScreenUserHomePage());
                      Get.snackbar(LocaleKeys.uploaded.tr, LocaleKeys.thevideouploadedsuccessfully);
                    }else{
                      Get.offAll(ScreenUserHomePage());
                      Get.snackbar("error", responce);
                    }
                    isloading=false;
                  }
                  else{
                    Get.snackbar(LocaleKeys.locationerror.tr, LocaleKeys.pleaseturnonyourlocationto.tr,
                        colorText: Colors.red,backgroundColor: Colors.amber);
                  }

                },
                child: Container(
                  decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(22),
                      color: Colors.black),
                  padding:
                      EdgeInsets.symmetric(vertical: 5.sp, horizontal: 65.sp),
                  child: Text(
                    LocaleKeys.publish.tr,
                    style: TextStyle(
                        color: Colors.white,
                        fontSize: 18.sp,
                        fontWeight: FontWeight.w600),
                  ),
                ),
              ),
              Text(
                'This is video path coming from another screen ${widget.videoPath}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              Text(
                'This is video path created here before deleting ${checkingPath?.path}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
              InkWell(

                  onTap: () async {
                    await checkingPath?.delete();
                    print(checkingPath?.path);
                    File fjvafvvafk=File(widget.videoPath);
                    fjvafvvafk.delete();
                    File(widget.videoPath).delete();
                    setState(() {});
                  },
                  child: Text(
                    'Delete',
                    style: TextStyle(color: Colors.red, fontSize: 20),
                  )),
              Text(
                'This is video path after deleting ${checkingPath?.path}',
                style: TextStyle(color: Colors.black, fontSize: 15),
              ),
            ],
          ),
        ),
      ),
    );
  }

  // void processPlayer() async {
  //   File fv = File(widget.videoPath);
  //   _videoPlayController = VideoPlayerController.file(fv);
  //   await _videoPlayController.initialize().then((value) async{
  //     await _videoPlayController.play();
  //     await _videoPlayController.setLooping(false);
  //   });
  // }

  Future<String> _getVideoUrl(String id) async {
    uppfile = File(widget.videoPath);
    Reference rf = FirebaseStorage.instance.ref().child('videos').child(id);
    UploadTask uploadTask = rf.putFile(uppfile!);
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }

  _getthumbnail() async {
    final thumbnail = await VideoCompress.getFileThumbnail(widget.videoPath);
    return thumbnail;
  }

  Future<String> _getThumbnailUrl(String id) async {
    Reference re = FirebaseStorage.instance.ref().child('thumbnails').child(id);
    UploadTask uploadTask = re.putFile(await _getthumbnail());
    TaskSnapshot snap = await uploadTask;
    String downloadurl = await snap.ref.getDownloadURL();
    return downloadurl;
  }

  Future<String> _uploadPost(LatLng lalo) async {
    String responce='';
    var allposts = await FirebaseFirestore.instance.collection('posts').get();
    int legth = allposts.docs.length;
    String _videourl = await _getVideoUrl('Video ${legth}');
    String _thumbnailurl = await _getThumbnailUrl('Video ${legth}');
    int uploadVideoTime = DateTime.now().millisecondsSinceEpoch;
    posts poss = posts(
        videoUrl: _videourl,
        userID: uuID,
        description: description,
        thumbnail: _thumbnailurl,
        uploadTime: uploadVideoTime,
        likes: [],
        documentName: 'Video ${legth}',
        longitude: lalo.longitude,
        latitude: lalo.latitude);
    await FirebaseFirestore.instance.collection('posts').doc('Video ${legth}').set(poss.toMap()).then((value){
      responce='success';
    }).catchError((onError){
      responce=onError;
    });
    return responce;
  }
}



