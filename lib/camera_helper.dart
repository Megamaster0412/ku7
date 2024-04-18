// import 'package:flutter/services.dart';
//
// class CameraHelper {
//   static const platform = MethodChannel('com.example.google_map_app/camera');
//
//   static Future<String> getCameraMetadata() async {
//     try {
//       final String metadata = await platform.invokeMethod('getCameraMetadata');
//       return metadata;
//     } on PlatformException catch (e) {
//       print("Failed to get camera metadata: '${e.message}'.");
//       return "Error: ${e.message}";
//     }
//   }
// }
