import 'dart:async';
import 'dart:convert';
import 'dart:io';
import 'dart:typed_data';

// import 'package:http/http.dart' as http;
import 'package:flutter_blue/flutter_blue.dart';
import 'package:flutter_blue_example/provider.dart';
import 'package:flutter_blue_example/widgets.dart';
// import 'package:path_provider/path_provider.dart';
// import 'package:push2shop/services/adpcm.dart';
// import 'package:push2shop/services/notification_service.dart';
import 'package:rxdart/rxdart.dart';
import 'dart:developer' as developer;

import 'package:shared_preferences/shared_preferences.dart';

class BluetoothManager {
  static final BluetoothManager _instance = BluetoothManager._internal();

  BluetoothManager._internal();

  factory BluetoothManager(){
    return _instance;
  }
}