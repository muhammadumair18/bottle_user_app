import 'package:bottle_user_app/model/user.dart' as model;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:geolocator/geolocator.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:location/location.dart' as loc;


CollectionReference userref = FirebaseFirestore.instance.collection('users');
CollectionReference postref=FirebaseFirestore.instance.collection('posts');
String registraiontokenformessaging='';
List<String> ChoicesofMenu=["Fund","SignOut","SignIn"];
bool englishlanguage=true;


void choiceAction(String choice){
  if(choice == "Fund"){
    print('Fund');
  }
  else if(choice == "SignOut"){
    print('SignOut');
  }
  else if(choice == 'SignIn'){
    print('SignIn');
  }
}



model.User inituser() {
  return model.User(id: '',
      countrycode: '',
      phoneNumber: '',
      Name: '',
      DateofBirth: 0,
  profilePicNo: 1,
  isblocked: false);
}

Future<model.User> getUserData(String id)async{
  var perondata=await userref.doc(id).get();
  model.User user=model.User.fromMap(perondata.data() as Map<String,dynamic>);
  return user;
}


Future<bool> checkPermissionStatus() async {
  var status = await Permission.location.status;
  print("status checking to check before running function       ${status}");
  if (status != PermissionStatus.granted) {
    print(status);
    var requestStatus = await Permission.location.request();
    print('after requesting for  request status        ${requestStatus}');
    if (requestStatus == PermissionStatus.granted) {
      return await enableLocationService();
    } else {
      return false;
    }
  } else {
    return await enableLocationService();
  }
}

Future<bool> enableLocationService() async {
  var location = loc.Location();
  print('location         ${location}');
  bool enabled = await location.requestService();
  print('enabled            ${enabled}');
  if (enabled) {
    var myPosition = await Geolocator.getCurrentPosition();
  }

  return enabled;
}




Future<bool> examplecheckPermissionStatus() async {
  var status = await Permission.location.status;
  print("status checking to check before running function       ${status}");
  if(status==PermissionStatus.denied){
    await Permission.location.request();
    status=await Permission.location.status;
  }
  if (status == PermissionStatus.granted) {
    print(status);
    var requestStatus = await Permission.location.request();
    print('after requesting for  request status        ${requestStatus}');
    if (requestStatus == PermissionStatus.granted) {
      return await exampleenableLocationService();
    } else {
      return false;
    }
  } else {
    // return await exampleenableLocationService();
    return true;
  }
}

Future<bool> exampleenableLocationService() async {
  var location = loc.Location();
  print('location         ${location}');
  bool enabled = await location.requestService();
  print('enabled            ${enabled}');
  if (enabled) {
    var myPosition = await Geolocator.getCurrentPosition();
  }

  return enabled;
}