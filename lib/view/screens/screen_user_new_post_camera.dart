
import 'dart:async';
import 'dart:io';
import 'dart:math' as math;

import 'package:bottle_user_app/controller/controller_video_controller.dart';
import 'package:bottle_user_app/view/screens/screen_user_new_post_description.dart';
import 'package:camera/camera.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:native_device_orientation/native_device_orientation.dart';
import 'package:sizer/sizer.dart';

import '../../main.dart';

class ScreenUserRecordVideoScreen extends StatefulWidget {
  const ScreenUserRecordVideoScreen({Key? key}) : super(key: key);

  @override
  _ScreenUserRecordVideoScreenState createState() =>
      _ScreenUserRecordVideoScreenState();
}

class _ScreenUserRecordVideoScreenState
    extends State<ScreenUserRecordVideoScreen>  with WidgetsBindingObserver{
  late CameraController controller;
  bool _isRecording=false;
  late Timer _timer;
  int _start = 0;

  void startTimer() {
    const oneSec = const Duration(seconds: 1);
    _timer = new Timer.periodic(
      oneSec,
          (Timer timer) {
        if (_start == 10) {
          setState(() {
            timer.cancel();
            _recordVideo();
          });
        } else {
          setState(() {
            _start++;
          });
        }
      },
    );
  }



  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    controller = CameraController(cameras[0], ResolutionPreset.max);
    controller.initialize().then((_) {
      if (!mounted) {
        return;
      }
      setState(() {});
    }).catchError((Object e) {
      if (e is CameraException) {
        switch (e.code) {
          case 'CameraAccessDenied':
            print('User denied camera access.');
            break;
          default:
            print('Handle other errors.');
            break;
        }
      }
    });
  }


  _recordVideo() async {
    if (_isRecording) {
      final xfile = await controller.stopVideoRecording();
      print('File path is this/File path is this/File path is this/File path is this/File path is this/');
      print(xfile.path);
      print(xfile.runtimeType);
      setState(() => _isRecording = false);
      Get.to(()=>ScreenUserNewPostDescription(videoPath: xfile.path));
    } else {
      await controller.prepareForVideoRecording();
      await controller.startVideoRecording();
      setState(() => _isRecording = true);
    }
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {

    if (!controller.value.isInitialized) {
      return Container();
    }
    return MaterialApp(
      home: Scaffold(
          body: SafeArea(
            child: Stack(
              children: [
                Container(
                    height: Get.height,
                    width: Get.width,
                    child: CameraPreview(controller)),
                Positioned(
                  bottom: 0,
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.symmetric(vertical: 8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.flip_camera_ios_outlined,
                              color: Colors.white,
                            )),
                        GestureDetector(onTap: (){
                          _recordVideo();
                          startTimer();
                        },child: Icon(_isRecording ? Icons.stop : Icons.circle,size: 50,color: Colors.red,)),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.browse_gallery,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
                Positioned(
                  top: 0,
                  child: Container(
                    width: Get.width,
                    margin: EdgeInsets.symmetric(vertical: 8.sp),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.keyboard_arrow_down,
                              color: Colors.white,
                            )),
                        Text(
                          '00:${_start}',
                          style: TextStyle(
                              fontSize: 24.sp,
                              fontWeight: FontWeight.w400,
                              color: Colors.red),
                        ),
                        IconButton(
                            onPressed: () {},
                            icon: Icon(
                              Icons.settings,
                              color: Colors.white,
                            ))
                      ],
                    ),
                  ),
                ),
              ],
            ),
          )
      ),
    );
  }
}














//
// NativeDeviceOrientationReader(useSensor: true,builder: (ctx) {
// final orientation = NativeDeviceOrientationReader.orientation(ctx);
// int turns = 0;
// switch (orientation) {
// case NativeDeviceOrientation.portraitUp:
// turns = 0;
// break;
// case NativeDeviceOrientation.portraitDown:
// turns = 2;
// break;
// case NativeDeviceOrientation.landscapeLeft:
// turns = 1;
// break;
// case NativeDeviceOrientation.landscapeRight:
// turns = 3;
// break;
// case NativeDeviceOrientation.unknown:
// turns = 0;
// break;
// }
// return Container();
// },),
