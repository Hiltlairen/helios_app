// lib/utils/app_navigator_observer.dart
import 'package:flutter/material.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class AppNavigatorObserver extends NavigatorObserver {
  QRViewController? qrController;

  void setQRController(QRViewController controller) {
    qrController = controller;
  }

  @override
  void didPush(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPush(route, previousRoute);
    _updateCameraState(route);
  }

  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    _updateCameraState(previousRoute);
  }

  void _updateCameraState(Route<dynamic>? route) {
    if (route?.settings.name == '/qrScannerPage') {
      qrController?.resumeCamera();
    } else {
      qrController?.pauseCamera();
    }
  }
}
