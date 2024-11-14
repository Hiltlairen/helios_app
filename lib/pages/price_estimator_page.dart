import 'package:flutter/material.dart';

class PriceEstimatorPage extends StatefulWidget {
  @override
  _PriceEstimatorPageState createState() => _PriceEstimatorPageState();
}

class _PriceEstimatorPageState extends State<PriceEstimatorPage> {
  String? selectedDimension;
  int quantity = 1;

  final Map<String, List<double>> predefinedDimensions = {
    'Libro': [22, 16, 11],
    'Par de zapatos': [33, 15, 16],
    'Freidora o Mini Nevera': [50, 38, 42],
    'Televisor 65"': [164, 100, 20],
  };

  void adjustQuantity(bool increment) {
    setState(() {
      if (increment) {
        quantity++;
      } else if (quantity > 1) {
        quantity--;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Estimador de Precio'),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              '¿No estás seguro de las medidas?',
              style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
            Text(
              'Selecciona la medida de la caja que más se parezca al envío que quieres cotizar. Recuerda que son medidas de referencia.',
              style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            ),
            SizedBox(height: 16),
            GridView.builder(
              shrinkWrap: true,
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                crossAxisCount: 2,
                mainAxisSpacing: 8,
                crossAxisSpacing: 8,
                childAspectRatio: 1.6,
              ),
              itemCount: predefinedDimensions.keys.length,
              itemBuilder: (context, index) {
                String dimensionLabel =
                    predefinedDimensions.keys.elementAt(index);
                List<double> dimensionValues =
                    predefinedDimensions[dimensionLabel]!;
                bool isSelected = selectedDimension == dimensionLabel;

                return GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedDimension = dimensionLabel;
                    });
                  },
                  child: Container(
                    decoration: BoxDecoration(
                      border: Border.all(
                          color: isSelected ? Colors.blue : Colors.grey),
                      borderRadius: BorderRadius.circular(8),
                      color: isSelected ? Colors.blue.shade100 : Colors.white,
                    ),
                    padding: EdgeInsets.all(8),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(Icons.inventory_2,
                            size: 40, color: Colors.grey[700]),
                        SizedBox(height: 8),
                        Text(
                          dimensionLabel,
                          style: TextStyle(
                            fontWeight: FontWeight.bold,
                            color: Colors.black87,
                          ),
                        ),
                        SizedBox(height: 4),
                        Text(
                          '${dimensionValues[0].toInt()} x ${dimensionValues[1].toInt()} x ${dimensionValues[2].toInt()}',
                          style: TextStyle(
                            color: Colors.grey[700],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
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
                      icon: Icon(Icons.remove_circle_outline),
                      onPressed: () => adjustQuantity(false),
                    ),
                    Text(
                      quantity.toString(),
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    IconButton(
                      icon: Icon(Icons.add_circle_outline),
                      onPressed: () => adjustQuantity(true),
                    ),
                  ],
                ),
              ],
            ),
            Spacer(),
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: () {
                  // Aquí puedes implementar la lógica para calcular el precio
                  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                    content: Text(
                        'Cotización solicitada para $selectedDimension x $quantity'),
                  ));
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: Colors.grey[300],
                  foregroundColor: Colors.black54,
                  padding: EdgeInsets.symmetric(vertical: 16),
                ),
                child: Text(
                  'Solicitar Cotización',
                  style: TextStyle(fontWeight: FontWeight.bold),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
