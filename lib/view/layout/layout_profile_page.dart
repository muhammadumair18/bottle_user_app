import 'package:bottle_user_app/view/screens/screen_user_login.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:location/location.dart' as loc;
import '../screens/screen_user_edit_profile.dart';
import '../screens/screen_user_settings.dart';

class LayoutProfilePage extends StatefulWidget {

  @override
  _LayoutProfilePageState createState() => _LayoutProfilePageState();
}

class _LayoutProfilePageState extends State<LayoutProfilePage> {



  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        backgroundColor: Colors.black,
        body: Stack(
          children: [
            Positioned(top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: EdgeInsets.only(top: Get.height * .03),
                width: Get.width,
                height: Get.height * .3,
                color: Colors.black,
                child: Text('Profile',style: TextStyle(color: Colors.white,fontSize: 25),textAlign: TextAlign.center,),
              ),
            ),
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                width: Get.width,
                height: Get.height * .74,
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.elliptical(Get.width/2,Get.height/10),
                      topRight: Radius.elliptical(Get.width/2,Get.height/10),
                    )),
                child: Column(
                  children: [
                    SizedBox(height: Get.height * .09,),
                    Text('Darlene',style: TextStyle(color: Colors.black,fontSize: 22),),
                    Text('example@gmail.com',style: TextStyle(color: Colors.black,fontSize: 15),),
                    SizedBox(height:Get.height * .035),
                    Container(
                      padding: EdgeInsets.symmetric(vertical: 9,horizontal: 12),
                      width: Get.width,
                      color: Colors.grey.withOpacity(0.5),
                      child: Text('Preferences',style: TextStyle(color: Colors.black,fontSize: 22),),
                    ),
                    SizedBox(height: Get.height * .01,),
                    ListTile(onTap: (){
                      Get.to(ScreenUserEditProfile());
                    },
                      leading: Container(
                        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3)
                        ),
                        child: Icon(Icons.person,color: Colors.black,size: 35,),
                      ),
                      title: Text('Edit Profile',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      ),),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    SizedBox(height: Get.height * .01,),
                    ListTile(onTap: (){
                      Get.to(ScreenUserSettings());
                    },
                      leading: Container(
                        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3)
                        ),
                        child: Icon(Icons.settings,color: Colors.black,size: 35,),
                      ),
                      title: Text('Settings',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      ),),
                      trailing: Icon(Icons.arrow_forward_ios),
                    ),
                    SizedBox(height: Get.height * .01,),
                    ListTile(onTap: (){
                      FirebaseAuth.instance.signOut();
                      Get.offAll(ScreenUserLogin());
                    },
                      leading: Container(
                        padding: EdgeInsets.symmetric(vertical: 2,horizontal: 2),
                        decoration: BoxDecoration(
                            color: Colors.grey.withOpacity(0.3)
                        ),
                        child: Icon(Icons.login,color: Colors.black,size: 35,),
                      ),
                      title: Text('Logout',style: TextStyle(
                          color: Colors.black,
                          fontSize: 18
                      ),),
                    ),
                  ],
                ),
              ),
            ),
            Positioned(right: 0,left: 0,bottom: Get.height * .68,
                child: GestureDetector(
                  onTap: ()async{
                    // bool checki=await checkPermissionStatus();
                    // print("checkpermissionfunction     ${checki}");
                    // print('Hello');
                  },
                  child: Container(
              height: Get.height * .12,
              width: Get.width * .30,
              decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    image: DecorationImage(
                        image: AssetImage('assets/images/img_1.png'),
                        fit: BoxFit.contain)),
            ),
                ))
          ],
        ),
      ),
    );
  }


}



// print(value.longitude.toString()+'  '+value.latitude.toString() );
// _marker.add(Marker(markerId: MarkerId('Marker-2'),
// position: LatLng(value.latitude,value.longitude),
// infoWindow: InfoWindow(
// title: 'My Location'
// )));
// CameraPosition cameraposition=CameraPosition(target: LatLng(value.latitude,value.longitude),zoom: 14);
// GoogleMapController controller=await _completer.future;
// controller.animateCamera(CameraUpdate.newCameraPosition(cameraposition));
// setState(() {});