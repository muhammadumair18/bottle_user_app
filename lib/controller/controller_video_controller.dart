import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'dart:math' as math;

class ControllerVideoController extends GetxController{

double checkOrientation(){
  if(DeviceOrientation==DeviceOrientation.landscapeLeft){
    print('Device Orientation = = =    ');
    print(DeviceOrientation);
    return (90 * math.pi / 180);
  }
  else if(DeviceOrientation==DeviceOrientation.landscapeRight)
    {
      print('Device Orientation = = =    ');
      print(DeviceOrientation);
      return (270 * math.pi / 180);
    }
  else if(DeviceOrientation==DeviceOrientation.portraitDown)
    {
      print('Device Orientation = = =    ');
      print(DeviceOrientation);
      return (180 * math.pi / 180);
    }
  else{
    return 0;
  }
}
}