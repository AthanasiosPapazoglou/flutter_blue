// import 'dart:async';
// import 'dart:convert';
// import 'dart:io';
// import 'dart:typed_data';

// // import 'package:http/http.dart' as http;
// import 'package:flutter_blue/flutter_blue.dart';
// import 'package:flutter_blue_example/provider.dart';
// import 'package:flutter_blue_example/widgets.dart';
// // import 'package:path_provider/path_provider.dart';
// // import 'package:push2shop/services/adpcm.dart';
// // import 'package:push2shop/services/notification_service.dart';
// import 'package:rxdart/rxdart.dart';
// import 'dart:developer' as developer;

// import 'package:shared_preferences/shared_preferences.dart';

// var serviceUUID = Guid('0000f00d-1212-efde-1523-785fef13d123');
// var characteristicUUID = Guid('0000beef-1212-efde-1523-785fef13d123');

// class BluetoothManager {
//   static final BluetoothManager _instance = BluetoothManager._internal();

//   BluetoothManager._internal();

//   factory BluetoothManager(){
//     return _instance;
//   }

//   final Future<SharedPreferences> _prefs = SharedPreferences.getInstance();

//    FlutterBlue _flutterBlue = FlutterBlue.instance;
//    List<int> finalData = [];
//    BluetoothDevice _device;
//    BluetoothCharacteristic _characteristic;
//    Stream myStream;
//    StreamController myStreamController = StreamController();
//    StreamSubscription mySub;
//    bool canListen = true;


//    void startScanning() async {
//     Timer.periodic(Duration(seconds: 15), (Timer t) async {
//       scan();
//     });
//   }

//   scan() async {
//     var connectedDevices = await _flutterBlue.connectedDevices;
//     bool isButtonConnected = false;
//     connectedDevices.forEach((e) {
//       print("device id: ${e.name}");
//       if(isButtonConnected){
//         return;
//       }
//       if(e.name == 'Fanstel'){
//         isButtonConnected=true;
//       }

//     });
//     if (connectedDevices.isEmpty/* || !isButtonConnected*/) {
//       _flutterBlue.scan().listen((scanResult) async {
//         print(
//             'services ${scanResult.advertisementData.serviceUuids} can connect ${scanResult.advertisementData.serviceUuids.contains(serviceUUID.toString())}');
//         if (scanResult.advertisementData.serviceUuids.contains((Platform.isIOS)
//             ? serviceUUID.toString().toUpperCase()
//             : serviceUUID.toString())) {
//           print("res=" + scanResult.toString());
//           print('device=${scanResult.device.toString()}');
//           _device = scanResult.device;
//           _flutterBlue.stopScan();

//           connectToDevice(_device.name);
//         }
//       });
//     } else {
//       print(
//           'connected devices: ${(await _flutterBlue.connectedDevices).first.id.id}');
//     }
//   }

//   Future<void> connectToDevice(String deviceName) async {
//     await _device.disconnect();
//     await _device.connect();
//     await discoverServices();
//   }

//   Future<void> discoverServices() async {
//     List<BluetoothService> services = await _device.discoverServices();
//     var service =
//         services.firstWhere((s) => s.uuid == serviceUUID, orElse: () => null);
//     if (service == null) {
//       print('service not found');
//       return;
//     }
//     _characteristic = service.characteristics.firstWhere((c) {
//       //print(c.uuid.toString());
//       return c.uuid == characteristicUUID;
//     }, orElse: () => null);
//     if (_characteristic == null) {
//       print('no characteristic was found');
//       return;
//     }
//     print('CHARACTERISTICS $_characteristic');
//     _waitForData();
//   }

//   _waitForData() async {
//     myStream = myStreamController.stream.asBroadcastStream();
//     myStreamController.sink.add(0);
//     _characteristic.setNotifyValue(true);

//     addData();
//     print("INITIATED");
//   }

//   addData() async {
//     print('add data');
//     mySub = _characteristic.value.listen((event) {
//       print(event);
//       if (event.isNotEmpty) {
//         if (canListen) {
//           canListen = false;
//           finalData.clear();
//           Future.delayed(Duration(seconds: 5), () async {
//             // _characteristic.setNotifyValue(false);
//             print('STOP listening');
//             await stopListening();
//           });
//         }

//         Uint8List toDecode = Uint8List.fromList(event);
//         var decoded = decodeAdpcm(toDecode);
//         finalData.addAll(decoded);
//       }
//     });
//   }

//   Future<void> stopListening() async {
//     _characteristic.write([2]);

//     Uint16List finalfinal = Uint16List.fromList(finalData);
//     if (finalfinal.length < 512) {
//       canListen = true;
//       return;
//     }
//     try {
//       await TestAPICall(finalfinal).then((_) {
//         canListen = true;
//       });
//     } catch (e) {
//       canListen = true;
//       print(e);
//     }

//     print('canListen $canListen');
//   }
  
// }