import 'package:flutter_blue_example/widgets.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_blue/flutter_blue.dart';

class BlueToothDeviceProvider extends ChangeNotifier{

  BluetoothDevice scanedDevice;

  refreshValues(){
    notifyListeners();
  }

}