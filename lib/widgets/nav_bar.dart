import 'package:flutter/material.dart';

class NavBar extends StatelessWidget {
  final int currentIndex;
  final Function(int) onTap;

  NavBar({required this.currentIndex, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return BottomNavigationBar(
      currentIndex: currentIndex,
      onTap: onTap,
      items: [
        BottomNavigationBarItem(
          icon: Icon(Icons.home),
          label: 'Principal',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.qr_code_scanner),
          label: 'QR',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.map),
          label: 'Mapa',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.attach_money),
          label: 'Estimador',
        ),
        BottomNavigationBarItem(
          icon: Icon(Icons.business),
          label: 'Empresas',
        ),
        BottomNavigationBarItem( // Nuevo ítem del NavBar
          icon: Icon(Icons.add_circle),
          label: 'Servicios',
        ),
      ],
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      backgroundColor: Color(0xFF2E3B4E),
      type: BottomNavigationBarType.fixed,
    );
  }
}
