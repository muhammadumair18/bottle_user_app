import 'package:bottle_user_app/view/layout/item_search_page_posts.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:bottle_user_app/model/posts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../helpers/helpers.dart';

class LayoutSearchPosts extends StatefulWidget {
  int betweenRange;

  @override
  _LayoutSearchPostsState createState() => _LayoutSearchPostsState();

  LayoutSearchPosts({
    required this.betweenRange,
  });
}

class _LayoutSearchPostsState extends State<LayoutSearchPosts> {
  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: examplecheckPermissionStatus(),
      builder: (BuildContext context, AsyncSnapshot<dynamic> permissionsnapshot) {
        if(permissionsnapshot.connectionState==ConnectionState.waiting){
          return Center(child: CircularProgressIndicator(color: Colors.red,),);
        }
        if(permissionsnapshot.data ==true){
          return FutureBuilder(
            future: Geolocator.getCurrentPosition(),
            builder: (BuildContext context, AsyncSnapshot<Position> currentpositionsnapshot) {
              if(currentpositionsnapshot.connectionState==ConnectionState.waiting){
                return Center(child: CircularProgressIndicator(color: Colors.red,),);
              }

              if(currentpositionsnapshot.hasData){
                return Container(
                  child: StreamBuilder<QuerySnapshot>(
                      stream: postref.snapshots(),
                      builder: (context, streamsnapshots) {

                        if(streamsnapshots.connectionState == ConnectionState.waiting){
                          return Center(child: CircularProgressIndicator.adaptive());
                        }

                        var data = streamsnapshots.data!.docs
                            .map((e) =>
                            posts.fromMap(e.data() as Map<String, dynamic>))
                            .toList();
                        var radiusMiles=data.where((element){
                          var radiustolimit=Geolocator.distanceBetween(currentpositionsnapshot.data!.latitude, currentpositionsnapshot.data!.longitude, element.latitude, element.longitude);
                          return radiustolimit*0.000621371192 < widget.betweenRange;
                        }).toList();
                        
                        return ListView.builder(
                            physics: ScrollPhysics(),
                            scrollDirection: Axis.vertical,
                            shrinkWrap: true,
                            itemCount: radiusMiles.length,
                            itemBuilder: (BuildContext context, int index) {
                              var innerdata = radiusMiles[index];
                              return ItemSearchPagePosts(videoLink: innerdata.videoUrl,liked: innerdata.likes.contains(FirebaseAuth.instance.currentUser!.uid), documentName: innerdata.documentName,dateUploaded: innerdata.uploadTime, userID: innerdata.userID,);
                            });
                      }),
                );
              }
              return Center(
                child: Text('Location must be on to see the Posts Layout posts',
                  style: TextStyle(color: Colors.red,fontSize: 16),),);
            },);
        }
        return Center(child: Text('You must allow permission to get data Layout Posts',
          style: TextStyle(color: Colors.red,fontSize: 16),),);
    },);
  }
}
