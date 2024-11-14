import 'package:flutter/material.dart';

// ya esta

class PriceEstimatorPage extends StatefulWidget {
  @override
  _PriceEstimatorPageState createState() => _PriceEstimatorPageState();
}

class _PriceEstimatorPageState extends State<PriceEstimatorPage> {
  final _formKey = GlobalKey<FormState>();

  String? originCity;
  String? destinationCity;
  double? weight;
  double? length;
  double? height;
  double? width;
  int quantity = 1;
  double estimatedPrice = 0.0;

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

  void adjustQuantity(bool increment) {
    setState(() {
      if (increment) {
        quantity++;
      } else if (quantity > 1) {
        quantity--;
      }
    });
  }

  void calculatePrice() {
    if (_formKey.currentState?.validate() ?? false) {
      setState(() {
        // Fórmula simple de estimación de precio basada en peso y dimensiones
        estimatedPrice = (weight ?? 1) * 2 +
            (length ?? 0) * (width ?? 0) * (height ?? 0) * 0.001;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estimador de Precios'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Ciudad de Origen'),
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
                          'Ciudad de Origen y Ciudad de Destino deben ser diferentes.'),
                    ));
                  }
                },
              ),
              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Ciudad de Destino'),
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
                          'Ciudad de Origen y Ciudad de Destino deben ser diferentes.'),
                    ));
                  }
                },
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Peso (kg)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Por favor ingresa el peso';
                  return null;
                },
                onChanged: (value) => weight = double.tryParse(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Largo (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Por favor ingresa el largo';
                  return null;
                },
                onChanged: (value) => length = double.tryParse(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Alto (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Por favor ingresa el alto';
                  return null;
                },
                onChanged: (value) => height = double.tryParse(value),
              ),
              TextFormField(
                decoration: InputDecoration(labelText: 'Ancho (cm)'),
                keyboardType: TextInputType.number,
                validator: (value) {
                  if (value == null || value.isEmpty)
                    return 'Por favor ingresa el ancho';
                  return null;
                },
                onChanged: (value) => width = double.tryParse(value),
              ),
              SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Cantidad',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    children: [
                      IconButton(
                        onPressed: () => adjustQuantity(false),
                        icon: Icon(Icons.remove),
                      ),
                      Text(
                        '$quantity',
                        style: TextStyle(fontSize: 18),
                      ),
                      IconButton(
                        onPressed: () => adjustQuantity(true),
                        icon: Icon(Icons.add),
                      ),
                    ],
                  ),
                ],
              ),
              SizedBox(height: 16),
              ElevatedButton(
                onPressed: calculatePrice,
                child: Text('Calcular Precio'),
              ),
              SizedBox(height: 16),
              if (estimatedPrice > 0)
                Text(
                  'Precio estimado: Bs. ${estimatedPrice.toStringAsFixed(2)}',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
            ],
          ),
        ),
      ),
    );
  }
}
