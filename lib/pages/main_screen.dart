import 'package:flutter/material.dart';
import 'home_page.dart';
import 'qr_scanner_page.dart';
import 'map_page.dart';
import 'price_estimator_page.dart';
import 'companies_page.dart';
import 'extra_services_page.dart';
import '../widgets/nav_bar.dart';
import 'package:qr_code_scanner/qr_code_scanner.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;
  QRViewController? qrController;

  // Configura el controlador de la cámara desde QRScannerPage
  void _setQRController(QRViewController controller) {
    qrController = controller;
    qrController?.pauseCamera(); // Asegúrate de que la cámara esté pausada al inicio
  }

  // Lista de páginas
  late final List<Widget> _pages;

  @override
  void initState() {
    super.initState();
    _pages = [
      HomePage(),
      QRScannerPage(onCameraCreated: _setQRController),
      MapPage(),
      PriceEstimatorPage(),
      CompaniesPage(),
      ExtraServicesPage(), 
    ];
  }

  // Controla el cambio de pestañas y el estado de la cámara
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
      if (index == 1) {
        qrController?.resumeCamera(); // Activa la cámara en QRScannerPage
      } else {
        qrController?.pauseCamera(); // Pausa la cámara en otras pestañas
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
    qrController?.dispose(); // Libera la cámara al salir
    super.dispose();
  }
}
