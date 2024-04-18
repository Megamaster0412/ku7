import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';

class PermissionHandlerExample extends StatefulWidget {
  @override
  _PermissionHandlerExampleState createState() => _PermissionHandlerExampleState();
}

class _PermissionHandlerExampleState extends State<PermissionHandlerExample> {
  String _permissionStatus = "Requesting permission...";

  @override
  void initState() {
    super.initState();
    _checkInitialPermissionStatus();
  }

  Future<void> _checkInitialPermissionStatus() async {
    final PermissionStatus status = await Permission.location.status;
    setState(() {
      if (status.isGranted) {
        _permissionStatus = "Location permission granted.";
      } else {
        _permissionStatus = "Location permission not determined. Please grant permission.";
      }
    });
  }

  Future<void> _requestLocationPermission() async {
    try {
      final PermissionStatus status = await Permission.location.request();
      setState(() {
        switch (status) {
          case PermissionStatus.granted:
            _permissionStatus = "Location permission granted.";
            break;
          case PermissionStatus.denied:
            _permissionStatus = "Location permission denied. Please enable it in app settings.";
            break;
          case PermissionStatus.permanentlyDenied:
            _permissionStatus = "Location permission permanently denied. Please enable it in app settings.";
            openAppSettings();
            break;
          default:
            _permissionStatus = "Location permission is restricted.";
            break;
        }
      });
    } catch (e) {
      setState(() {
        _permissionStatus = "An error occurred while requesting permissions: $e";
      });
    }
  }

  Widget _buildPermissionRequestUI() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: Text(
            "This app needs location permission to function correctly. Please grant this permission to continue.",
            textAlign: TextAlign.center,
          ),
        ),
        ElevatedButton(
          onPressed: _requestLocationPermission,
          child: Text("Grant Location Permission"),
        ),
        SizedBox(height: 20),
        Text(_permissionStatus),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Permission Handler Example'),
      ),
      body: Center(
        child: _buildPermissionRequestUI(),
      ),
    );
  }
}
