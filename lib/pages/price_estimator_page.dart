import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: PriceEstimatorPage(),
    );
  }
}

class PriceEstimatorPage extends StatefulWidget {
  @override
  _PriceEstimatorPageState createState() => _PriceEstimatorPageState();
}

class _PriceEstimatorPageState extends State<PriceEstimatorPage> {
  String? selectedProductType;
  String? originCity;
  String? destinationCity;
  double? weight;
  double? length;
  double? height;
  double? width;
  int? quantity = 1;
  double? quotationInBolivianos;

  final List<String> boliviaDepartments = [
    'La Paz',
    'Cochabamba',
    'Santa Cruz',
    'Oruro',
    'Potosí',
    'Chuquisaca',
    'Tarija',
    'Beni',
    'Pando',
  ];

  double calculateQuotationInBolivianos() {
    double baseRate = selectedProductType == 'documentos' ? 20.0 : 40.0;
    double weightRate = weight != null ? weight! * 2.5 : 0;
    double volumeRate = 0;

    if (selectedProductType == 'paquete' &&
        length != null &&
        height != null &&
        width != null) {
      double volume = (length! * height! * width!) / 5000;
      volumeRate = volume * 4.0;
    }

    double quantityRate = (quantity ?? 1) * 3.0;

    return baseRate + weightRate + volumeRate + quantityRate;
  }

  void calculateQuotation() {
    if (_validateFields()) {
      setState(() {
        quotationInBolivianos = calculateQuotationInBolivianos();
      });
    } else {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text('Por favor, complete todos los campos requeridos.'),
      ));
    }
  }

  bool _validateFields() {
    if (selectedProductType == null ||
        originCity == null ||
        destinationCity == null ||
        weight == null ||
        quantity == null ||
        (selectedProductType == 'paquete' &&
            (length == null || height == null || width == null))) {
      return false;
    }
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blueAccent,
        title:
            Text('Cotización de Envío', style: TextStyle(color: Colors.white)),
        centerTitle: true,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Card(
              elevation: 6.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text('Tipo de Producto',
                        style: TextStyle(
                            fontSize: 16, fontWeight: FontWeight.bold)),
                    SizedBox(height: 8),
                    Row(
                      children: [
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedProductType = 'paquete';
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectedProductType == 'paquete'
                                    ? Colors.blueAccent
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Text(
                                  'Paquete',
                                  style: TextStyle(
                                    color: selectedProductType == 'paquete'
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 8.0),
                        Expanded(
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                selectedProductType = 'documentos';
                                length = null;
                                width = null;
                                height = null;
                              });
                            },
                            child: Container(
                              decoration: BoxDecoration(
                                color: selectedProductType == 'documentos'
                                    ? Colors.blueAccent
                                    : Colors.grey[200],
                                borderRadius: BorderRadius.circular(8.0),
                              ),
                              padding: EdgeInsets.all(12.0),
                              child: Center(
                                child: Text(
                                  'Documentos',
                                  style: TextStyle(
                                    color: selectedProductType == 'documentos'
                                        ? Colors.white
                                        : Colors.black,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            Card(
              elevation: 6.0,
              margin: EdgeInsets.symmetric(vertical: 8.0),
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  children: [
                    DropdownButtonFormField<String>(
                      decoration:
                          InputDecoration(labelText: 'Ciudad de Origen'),
                      value: originCity,
                      items: boliviaDepartments.map((department) {
                        return DropdownMenuItem(
                          value: department,
                          child: Text(department),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != destinationCity) {
                          setState(() {
                            originCity = value;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'La ciudad de origen y destino deben ser diferentes.'),
                          ));
                        }
                      },
                    ),
                    DropdownButtonFormField<String>(
                      decoration:
                          InputDecoration(labelText: 'Ciudad de Destino'),
                      value: destinationCity,
                      items: boliviaDepartments.map((department) {
                        return DropdownMenuItem(
                          value: department,
                          child: Text(department),
                        );
                      }).toList(),
                      onChanged: (value) {
                        if (value != originCity) {
                          setState(() {
                            destinationCity = value;
                          });
                        } else {
                          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                            content: Text(
                                'La ciudad de origen y destino deben ser diferentes.'),
                          ));
                        }
                      },
                    ),
                  ],
                ),
              ),
            ),
            if (selectedProductType == 'paquete')
              Card(
                elevation: 6.0,
                margin: EdgeInsets.symmetric(vertical: 8.0),
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    children: [
                      TextField(
                        decoration: InputDecoration(labelText: 'Largo (cm)'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => length = double.tryParse(value),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Alto (cm)'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => height = double.tryParse(value),
                      ),
                      TextField(
                        decoration: InputDecoration(labelText: 'Ancho (cm)'),
                        keyboardType: TextInputType.number,
                        onChanged: (value) => width = double.tryParse(value),
                      ),
                    ],
                  ),
                ),
              ),
            TextField(
              decoration: InputDecoration(labelText: 'Peso (kg)'),
              keyboardType: TextInputType.number,
              onChanged: (value) => weight = double.tryParse(value),
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Cantidad'),
              keyboardType: TextInputType.number,
              onChanged: (value) => quantity = int.tryParse(value),
            ),
            SizedBox(height: 16),
            Center(
              child: ElevatedButton(
                onPressed: calculateQuotation,
                child: Text('Calcular Cotización'),
                style: ElevatedButton.styleFrom(
                  //primary: Colors.blueAccent, // Color de fondo
                  padding: EdgeInsets.symmetric(horizontal: 32, vertical: 12),
                  textStyle:
                      TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            if (quotationInBolivianos != null)
              Center(
                child: Padding(
                  padding: const EdgeInsets.symmetric(vertical: 16.0),
                  child: Text(
                    'Cotización: Bs. ${quotationInBolivianos!.toStringAsFixed(2)}',
                    style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}
