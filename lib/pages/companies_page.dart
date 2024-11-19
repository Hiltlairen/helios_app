// lib/pages/companies_page.dart
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class CompaniesPage extends StatelessWidget {
  // Función para abrir la URL externa
  Future<void> _launchURL(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'No se puede abrir la URL: $url';
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Empresas'),
      ),
      body: Center(
        child: ListView(
          children: <Widget>[
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  _launchURL(
                      'https://www.facebook.com/FlotaBolivar/?locale=es_LA');
                },
                child: Image.asset(
                  //Aca la ubicacion como en el yaml
                  'assets/img/BOLIVAR-removebg-preview.png', //
                  height: 80, // Ajusta el tamaño de la imagen
                ),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  _launchURL('https://www.flotaeldorado.com/');
                },
                child: Image.asset(
                  'assets/img/el_dorado-Photoroom.png', //
                  height: 80, // Ajusta el tamaño de la imagen
                ),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  _launchURL('https://transcopacabanasa.com.bo/');
                },
                child: Image.asset(
                  'assets/img/transCopacabana.png', //
                  height: 80, // Ajusta el tamaño de la imagen
                ),
              ),
            ),
            ListTile(
              title: ElevatedButton(
                onPressed: () {
                  _launchURL('https://transcopacabanasa.com.bo/');
                },
                child: Image.asset(
                  'assets/img/transCopacabana.png', //
                  height: 80, // Ajusta el tamaño de la imagen
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
