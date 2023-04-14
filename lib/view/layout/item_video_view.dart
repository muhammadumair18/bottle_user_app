import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';
import 'package:cached_video_player/cached_video_player.dart';


class ItemVideoView extends StatefulWidget {
  String videoLink;

  @override
  _ItemVideoViewState createState() => _ItemVideoViewState();

  ItemVideoView({
    required this.videoLink,
  });
}

class _ItemVideoViewState extends State<ItemVideoView> {
  late CachedVideoPlayerController _controller;
  bool pauseVisibility=false;


  @override
  void initState() {
    // TODO: implement initState
    _controller = CachedVideoPlayerController.network(widget.videoLink)
      ..initialize().then((value) {
        setState(() {});
        _controller.play();
        _controller.setVolume(1);
        _controller.setLooping(true);
      });
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
    _controller.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return Container(

      color: Colors.blueGrey,
      // height: Get.height,
      // width: Get.width,
      child: _controller.value.isInitialized
          ? Center(
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
                    CachedVideoPlayer(_controller),
                    Visibility(
                        visible: pauseVisibility,
                        child: Center(
                            child: Icon(
                              Icons.pause,
                              color: Colors.red,
                              size: 70,
                            )))
                  ],
                ))),
          )
          : Center(child: CircularProgressIndicator(color: Colors.red,),),

    );
  }


  // Future<void> initiliza()async{
  //   _controller =await VideoPlayerController.network(widget.videoLink)
  //   ..initialize().then((value) {
  //     // _chewircontroller=ChewieController(
  //     //   videoPlayerController: _controller,
  //     //   autoPlay: false,
  //     //   looping: false,
  //     //   aspectRatio: _controller.value.aspectRatio
  //     // );
  //     _controller.play();
  //     _controller.setVolume(1);
  //     _controller.setLooping(true);
  //   });
  // }
}




// "https://firebasestorage.googleapis.com/v0/b/bottle-app-67d11.appspot.com/o/videoplayback.mp4?alt=media&token=86984841-3fb4-4e2e-809f-3d3bb87b22e5"


// FutureBuilder(future: initiliza(),builder: (context,snapshot){
//   if(snapshot.connectionState==ConnectionState.done){
//     return Center(
//         child: AspectRatio(
//             aspectRatio: _controller!.value.aspectRatio,
//             child: GestureDetector(
//                 onTap: () {
//                   if (_controller!.value.isPlaying) {
//                     setState(() {
//                       _controller?.pause();
//                       pauseVisibility = true;
//                     });
//                   } else {
//                     setState(() {
//                       _controller?.play();
//                       pauseVisibility = false;
//                     });
//                   }
//                   print(
//                       'Play/Pause/Play/Pause/Play/Pause/Play/Pause/Play/Pause/Play/Pause/Play/Pause/');
//                 },
//                 child: Stack(
//                   children: [
//                     VideoPlayer(_controller!),
//                     Visibility(
//                         visible: pauseVisibility,
//                         child: Center(
//                             child: Icon(
//                               Icons.pause,
//                               color: Colors.red,
//                               size: 70,
//                             )))
//                   ],
//                 )))
//     );
//   }
//   return Center(
//     child: CircularProgressIndicator(
//       color: Colors.white,
//     ),
//   );
// }),