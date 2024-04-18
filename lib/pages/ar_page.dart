import 'package:flutter/material.dart';
import 'package:geolocator/geolocator.dart';
import 'package:vector_math/vector_math_64.dart' show radians;
import 'dart:math' as math;

// Dummy AR classes
class ARSessionManager {
  void dispose() {}
  void onInitialize({
    required bool showFeaturePoints,
    required bool showPlanes,
    String? customPlaneTexturePath,
    required bool handlePans,
    required bool handleRotation,
  }) {}
  void addNode({required ARNode node}) {}
}

class ARNode {
  final String type;
  final String uri;
  final ARVector3 position;
  final ARVector3 scale;
  final ARVector4 rotation;

  ARNode({
    required this.type,
    required this.uri,
    required this.position,
    required this.scale,
    required this.rotation,
  });
}

class ARVector3 {
  final double x, y, z;

  ARVector3({required this.x, required this.y, required this.z});
  static ARVector3 uniform(double scale) => ARVector3(x: scale, y: scale, z: scale);
}

class ARVector4 {
  final double x, y, z, w;

  ARVector4({required this.x, required this.y, required this.z, required this.w});
}

// ARPage Widget
class ARPage extends StatefulWidget {
  final double latitude;
  final double longitude;

  ARPage({Key? key, required this.latitude, required this.longitude}) : super(key: key);

  @override
  _ARPageState createState() => _ARPageState();
}

class _ARPageState extends State<ARPage> {
  ARSessionManager? arSessionManager;
  Position? currentPosition;
  double? targetBearing;

  @override
  void initState() {
    super.initState();
    // Initialize currentPosition with the widget's latitude and longitude
    currentPosition = Position(
      latitude: widget.latitude,
      longitude: widget.longitude,
      timestamp: DateTime.now(),
      accuracy: 0,
      altitude: 0,
      heading: 0,
      speed: 0,
      speedAccuracy: 0,
    );
    // Setup the AR session or any other initial state here
    _setDestination();
  }

  @override
  void dispose() {
    arSessionManager?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("AR Compass"),
      ),
      body: Container(
        child: Center(
          child: ElevatedButton(
            onPressed: _setDestination,
            child: Text('Set Destination'),
            style: ElevatedButton.styleFrom(
              foregroundColor: Colors.white, backgroundColor: Colors.blue,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8.0)),
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _setDestination,
        tooltip: 'Set Destination',
        child: Icon(Icons.location_searching),
      ),
    );
  }

  void onARViewCreated(ARSessionManager arSessionManager) {
    this.arSessionManager = arSessionManager;
    // Initialize AR session with your desired parameters
    arSessionManager.onInitialize(
      showFeaturePoints: false,
      showPlanes: true,
      customPlaneTexturePath: "assets/ar/Arrow5.obj",
      handlePans: false,
      handleRotation: false,
    );
  }

  void _setDestination() {
    if (currentPosition == null) {
      print('Current position is null, cannot set destination.');
      return;
    }
    setState(() {
      // Assuming you want to set the bearing to a fixed destination (for example, New York City's coordinates)
      double destinationLatitude = 40.7128; // Example destination latitude
      double destinationLongitude = -74.0060; // Example destination longitude
      targetBearing = calculateBearing(
        currentPosition!.latitude,
        currentPosition!.longitude,
        destinationLatitude,
        destinationLongitude,
      );
      arSessionManager!.addNode(
        node: ARNode(
          type: "webGLBModelNode",
          uri: "Assets/ar/Arrow5.obj",
          position: ARVector3(x: 0, y: 0, z: -1),
          scale: ARVector3.uniform(0.5),
          rotation: ARVector4(x: 0, y: 1, z: 0, w: radians(targetBearing!)),
        ),
      );
    });
  }

  double calculateBearing(double startLat, double startLng, double endLat, double endLng) {
    var startRad = radians(startLat);
    var endRad = radians(endLat);
    var dLon = radians(endLng - startLng);

    var y = math.sin(dLon) * math.cos(endRad);
    var x = math.cos(startRad) * math.sin(endRad) - math.sin(startRad) * math.cos(endRad) * math.cos(dLon);
    var brng = math.atan2(y, x);

    return brng;  // Return bearing in radians
  }
}
