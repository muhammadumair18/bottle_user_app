import 'dart:typed_data';

import 'package:bottle_user_app/generated/locales.g.dart';
import 'package:bottle_user_app/helpers/helpers.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:geolocator/geolocator.dart';
import 'package:get/get.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:bottle_user_app/model/posts.dart';

class LayoutSearchMap extends StatefulWidget {
  int betweenRange;

  @override
  _LayoutSearchMapState createState() => _LayoutSearchMapState();

  LayoutSearchMap({
    required this.betweenRange,
  });
}

class _LayoutSearchMapState extends State<LayoutSearchMap> {

  CameraPosition _kGooglePlex = CameraPosition(
    target: LatLng(37.42796133580664, -122.085749655962),
    zoom: 14.4746,
  );

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<bool>(
      future: examplecheckPermissionStatus(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
      if(snapshot.connectionState==ConnectionState.waiting) {
          return Center(
            child: CircularProgressIndicator(color: Colors.blue,),
          );
        }
      if(snapshot.data == true){
        return FutureBuilder(
          future: Geolocator.getCurrentPosition(),
          builder: (context,AsyncSnapshot<Position> gettinglocationsnapshot) {
            if(!gettinglocationsnapshot.hasData || gettinglocationsnapshot.connectionState==ConnectionState.waiting){
              return Center(child: CircularProgressIndicator(color: Colors.yellow,),);
            }
            var posi=gettinglocationsnapshot.data!;
            print('${posi.latitude}    ${posi.longitude}');
            return StreamBuilder<QuerySnapshot>(
              stream: postref.snapshots(),
              builder: (context, streamsnapshot) {
                if(streamsnapshot.connectionState==ConnectionState.waiting){
                  return Center(child: CircularProgressIndicator(color: Colors.red,));
                }

                var data = streamsnapshot.data!.docs
                    .map((e) =>
                    posts.fromMap(e.data() as Map<String, dynamic>))
                    .toList();
                var radiusMiles=data.where((element){
                  var radiustolimit=Geolocator.distanceBetween(gettinglocationsnapshot.data!.latitude, gettinglocationsnapshot.data!.longitude, element.latitude, element.longitude);
                  return radiustolimit*0.000621371192 < widget.betweenRange;
                }).toList();

                List<Marker> mark=radiusMiles.map((e) {
                  // Future<Uint8List> byti= geticonpicture(e.thumbnail);
                  return Marker(
                    icon: BitmapDescriptor.defaultMarker,
                    markerId: MarkerId(e.documentName),
                    position: LatLng(e.latitude,e.longitude),
                  );
                }).toList();

                return GoogleMap(
                  markers: Set<Marker>.of(mark),
                  initialCameraPosition: CameraPosition(zoom: 14.4746,
                      target: LatLng(posi.latitude,posi.longitude)),
                  zoomControlsEnabled: false,);
              },);
          },);
      }
      return Center(
        child: Text(
          LocaleKeys.locationmustbeprovidedinorderto.tr,
          style: TextStyle(color: Colors.red,fontSize: 15),
        ),
      );

        },
    );
  }

  // Future<Uint8List> geticonpicture(String thumbnail) async{
  //   Uint8List bytes = (await NetworkAssetBundle(Uri.parse(thumbnail))
  //       .load(thumbnail))
  //       .buffer
  //       .asUint8List();
  //   return bytes;
  // }
}
