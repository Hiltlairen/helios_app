import 'package:flutter/material.dart';
import 'home_page.dart';
import 'qr_scanner_page.dart';
import 'map_page.dart';
import 'price_estimator_page.dart';
import 'companies_page.dart';
import '../widgets/nav_bar.dart';

class MainScreen extends StatefulWidget {
  @override
  _MainScreenState createState() => _MainScreenState();
}

class _MainScreenState extends State<MainScreen> {
  int _currentIndex = 0;

  // Lista de páginas en el mismo orden que los íconos del NavBar
  final List<Widget> _pages = [
    HomePage(),             // Página Principal
    QRScannerPage(),        // Página del Escáner QR
    MapPage(),              // Página del Mapa
    PriceEstimatorPage(),   // Estimador de Precios
    CompaniesPage(),        // Página de Empresas
  ];

  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
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
}
