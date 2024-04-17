import 'package:flutter/material.dart';
import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:vector_math/vector_math_64.dart' as vector;
import 'dart:math' as math;

class ArPage extends StatefulWidget {
  final double destinationLatitude;
  final double destinationLongitude;

  ArPage({
    Key? key,
    required this.destinationLatitude,
    required this.destinationLongitude,
  }) : super(key: key);

  @override
  _ArPageState createState() => _ArPageState();
}

class _ArPageState extends State<ArPage> {
  ArCoreController? arCoreController;
  double bearingToDestination = 0.0;

  @override
  void dispose() {
    arCoreController?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('AR Compass'),
      ),
      body: ArCoreView(
        onArCoreViewCreated: _onArCoreViewCreated,
        enableTapRecognizer: true, // if you want to add onTap functionality
      ),
    );
  }

  void _onArCoreViewCreated(ArCoreController controller) {
    arCoreController = controller;
    _startCompass();
  }

  void _startCompass() {
    // Start updating compass direction
    _updateCompassDirection();
  }

  void _updateCompassDirection() {
    // Calculate the bearing to the destination
    bearingToDestination = _calculateBearingToDestination(
      widget.destinationLatitude,
      widget.destinationLongitude,
    );

    // Update the node with new bearing
    _updateArrowNodeWithBearing(bearingToDestination);

    // Update the compass direction periodically
    Future.delayed(Duration(seconds: 1), _updateCompassDirection);
  }

  void _updateArrowNodeWithBearing(double bearing) {
    arCoreController?.removeNode(nodeName: 'arrow');
    arCoreController?.addArCoreNode(_createArrowNode(bearing));
  }

  ArCoreNode _createArrowNode(double bearing) {
    final vector.Quaternion quaternionRotation = vector.Quaternion.axisAngle(
        vector.Vector3(0, 1, 0),
        vector.radians(bearing)
    );

    // Convert Quaternion to Vector4 for the rotation.
    final vector.Vector4 rotationVector = vector.Vector4(
        quaternionRotation.x,
        quaternionRotation.y,
        quaternionRotation.z,
        quaternionRotation.w
    );

    final arrowNode = ArCoreReferenceNode(
      name: 'arrow',
      object3DFileName: 'assets/ar/Arrow5.obj',
      position: vector.Vector3(0, -1, -2),
      rotation: rotationVector, // Assign the converted Vector4 rotation.
    );

    return arrowNode;
  }


  double _calculateBearingToDestination(double destLat, double destLon) {
    // This method calculates the bearing from current location to the destination.
    // It uses the haversine formula to calculate the initial bearing.
    double lat1 = vector.radians(widget.destinationLatitude);
    double lon1 = vector.radians(widget.destinationLongitude);
    double lat2 = vector.radians(destLat);
    double lon2 = vector.radians(destLon);

    double y = math.sin(lon2 - lon1) * math.cos(lat2);
    double x = math.cos(lat1) * math.sin(lat2) - math.sin(lat1) * math.cos(lat2) * math.cos(lon2 - lon1);
    double bearing = vector.degrees(math.atan2(y, x));

    // Normalize the bearing to be in the range [0, 360)
    bearing = (bearing + 360) % 360;

    return bearing;
  }
}
