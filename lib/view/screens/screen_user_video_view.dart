import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
import 'package:get/get.dart';
import 'package:video_player/video_player.dart';

class ScreenUserVideoView extends StatefulWidget {
  @override
  _ScreenUserVideoViewState createState() => _ScreenUserVideoViewState();
}

class _ScreenUserVideoViewState extends State<ScreenUserVideoView> {
  late VideoPlayerController _controller;
  bool pauseVisibility = false;


  @override
  void initState() {
    // TODO: implement initState
    _controller = VideoPlayerController.network(
        "https://firebasestorage.googleapis.com/v0/b/bottle-app-67d11.appspot.com/o/videoplayback.mp4?alt=media&token=86984841-3fb4-4e2e-809f-3d3bb87b22e5");
    _controller.initialize().then((value) {
      _controller.play();
      _controller.setVolume(1);
      _controller.setLooping(true);
    });
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.green,
      body: Container(
        height: Get.height,
        width: Get.width,
        decoration: BoxDecoration(color: Colors.black,
            // image: DecorationImage(
            //     fit: BoxFit.cover,
            //     image: NetworkImage(
            //         'https://images.unsplash.com/photo-1503023345310-bd7c1de61c7d?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8aHVtYW58ZW58MHx8MHx8&w=1000&q=80')
            // )
            ),
        child: Stack(
          children: [
            Container(
              // height: Get.height,
              // width: Get.width,
              child: Center(
                  child: AspectRatio(
                      aspectRatio: _controller.value.aspectRatio,
                      child: GestureDetector(
                          onTap: () {
                            if (_controller.value.isPlaying) {
                              setState(() {
                                _controller.pause();
                                pauseVisibility = true;
                              });
                            } else {
                              setState(() {
                                _controller.play();
                                pauseVisibility = false;
                              });
                            }
                            print(
                                'Play/Pause/Play/Pause/Play/Pause/Play/Pause/Play/Pause/Play/Pause/Play/Pause/');
                          },
                          child: Stack(
                            children: [
                              VideoPlayer(_controller),
                              Visibility(
                                  visible: pauseVisibility,
                                  child: Center(
                                      child: Icon(
                                    Icons.pause,
                                    color: Colors.red,
                                    size: 70,
                                  )))
                            ],
                          )))),
            ),
            Positioned(
              right: 13,
              bottom: 80,
              child: Column(
                children: [
                  GestureDetector(
                    onTap: () {
                      print('Go to Profile');
                    },
                    child: Container(
                      height: Get.height * .07,
                      width: Get.width * .10,
                      padding: EdgeInsets.all(2),
                      decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          border: Border.all(width: 1.sp, color: Colors.black)),
                      child: Container(
                        decoration: BoxDecoration(
                            shape: BoxShape.circle,
                            image: DecorationImage(
                                image: AssetImage('assets/images/img_1.png'),
                                fit: BoxFit.contain)),
                      ),
                    ),
                  ),
                  SizedBox(
                    height: 14.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Liked');
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.favorite,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                        Text(
                          'Like',
                          style: TextStyle(color: Colors.white),
                          textAlign: TextAlign.center,
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Requested');
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.chat,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                        Text(
                          'Request',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                  SizedBox(
                    height: 15.sp,
                  ),
                  GestureDetector(
                    onTap: () {
                      print('Shared');
                    },
                    child: Column(
                      children: [
                        Icon(
                          Icons.share,
                          color: Colors.white,
                          size: 28.sp,
                        ),
                        Text(
                          'Share',
                          style: TextStyle(color: Colors.white),
                        )
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
