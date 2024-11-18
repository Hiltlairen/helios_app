import 'package:flutter/material.dart';

class ExtraServicesPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Servicios Extra'),
        backgroundColor: Color(0xFF2E3B4E),
      ),
      body: Center(
        child: Text(
          'Aquí estarán los servicios extra.',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
