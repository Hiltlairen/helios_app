import 'package:flutter/material.dart';
import 'home_page.dart';
import 'qr_scanner_page.dart';
import 'map_page.dart';
import 'price_estimator_page.dart';
import 'companies_page.dart';
import '../widgets/nav_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  QRViewController? qrController;

  void _setQRController(QRViewController controller) {
    qrController = controller;
    qrController?.pauseCamera(); // cámara esté en pausa desde el inicio
  }

  final List<Widget> _pages = [];

  @override
  void initState() {
    super.initState();
    _pages.addAll([
      HomePage(),
      QRScannerPage(onCameraCreated: _setQRController),
      MapPage(),
      PriceEstimatorPage(),
      CompaniesPage(),
    ]);
  }

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) {
        qrController?.resumeCamera(); // Activa la cámara solo cuando está en QRScannerPage
      } else {
        qrController?.pauseCamera(); // Pausa la cámara en cualquier otra página
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: IndexedStack(
        index: _currentIndex,
        children: _pages,
      ),
      bottomNavigationBar: SafeArea(
        child: NavBar(
          currentIndex: _currentIndex,
          onTap: _onTabTapped,
        ),
      ),
    );
  }

  @override
  void dispose() {
    qrController?.dispose(); // Asegúrate de liberar la cámara al salir
    super.dispose();
  }
}
