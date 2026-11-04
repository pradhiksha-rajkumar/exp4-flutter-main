import 'package:flutter/material.dart';

void main() {
  runApp(const CarMileageApp());
}

class CarMileageApp extends StatelessWidget {
  const CarMileageApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Car Mileage Calculator',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        useMaterial3: true,
      ),
      home: const CarMileagePage(),
    );
  }
}

class CarMileagePage extends StatefulWidget {
  const CarMileagePage({super.key});

  @override
  State<CarMileagePage> createState() => _CarMileagePageState();
}

class _CarMileagePageState extends State<CarMileagePage> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _distanceController =
      TextEditingController();

  final TextEditingController _fuelController =
      TextEditingController();

  String _result = '';
  String _efficiency = '';
  Color _resultColor = Colors.blue;

  void _calculateMileage() {
    if (_formKey.currentState!.validate()) {
      double distance =
          double.parse(_distanceController.text);

      double fuel =
          double.parse(_fuelController.text);

      double mileage = distance / fuel;

      String efficiency;

      Color efficiencyColor;

      if (mileage < 10) {
        efficiency = 'Poor Efficiency';
        efficiencyColor = Colors.red;
      } else if (mileage <= 15) {
        efficiency = 'Average Efficiency';
        efficiencyColor = Colors.orange;
      } else {
        efficiency = 'Excellent Efficiency';
        efficiencyColor = Colors.green;
      }

      setState(() {
        _result =
            "Your car's mileage is ${mileage.toStringAsFixed(2)} km/l";

        _efficiency = efficiency;
        _resultColor = efficiencyColor;
      });
    }
  }

  void _clearForm() {
    _formKey.currentState!.reset();

    _distanceController.clear();
    _fuelController.clear();

    setState(() {
      _result = '';
      _efficiency = '';
      _resultColor = Colors.blue;
    });
  }

  @override
  void dispose() {
    _distanceController.dispose();
    _fuelController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue.shade50,

      appBar: AppBar(
        title: const Text(
          'Car Mileage Calculator',
          style: TextStyle(
            fontWeight: FontWeight.bold,
          ),
        ),
        centerTitle: true,
        backgroundColor: Colors.blue.shade700,
        foregroundColor: Colors.white,
      ),

      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),

        child: Form(
          key: _formKey,

          child: Column(
            children: [
              const SizedBox(height: 20),

              // Car Icon
              Icon(
                Icons.directions_car,
                size: 90,
                color: Colors.blue.shade700,
              ),

              const SizedBox(height: 15),

              // Heading
              const Text(
                'Car Mileage Calculator 🚗',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 25,
                  fontWeight: FontWeight.bold,
                ),
              ),

              const SizedBox(height: 10),

              Text(
                'Calculate your car mileage easily',
                style: TextStyle(
                  fontSize: 15,
                  color: Colors.grey.shade700,
                ),
              ),

              const SizedBox(height: 35),

              // Distance Input
              TextFormField(
                controller: _distanceController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),

                decoration: InputDecoration(
                  labelText: 'Distance Travelled',
                  hintText: 'Enter distance in kilometers',
                  prefixIcon: const Icon(Icons.route),
                  suffixText: 'km',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the distance travelled';
                  }

                  double? distance =
                      double.tryParse(value.trim());

                  if (distance == null) {
                    return 'Enter a valid number';
                  }

                  if (!distance.isFinite || distance <= 0) {
                    return 'Distance must be greater than 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 25),

              // Fuel Input
              TextFormField(
                controller: _fuelController,
                keyboardType: const TextInputType.numberWithOptions(
                  decimal: true,
                ),

                decoration: InputDecoration(
                  labelText: 'Fuel Consumed',
                  hintText: 'Enter fuel consumed in liters',
                  prefixIcon: const Icon(
                    Icons.local_gas_station,
                  ),
                  suffixText: 'L',
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                ),

                validator: (value) {
                  if (value == null || value.trim().isEmpty) {
                    return 'Please enter the fuel consumed';
                  }

                  double? fuel =
                      double.tryParse(value.trim());

                  if (fuel == null) {
                    return 'Enter a valid number';
                  }

                  if (!fuel.isFinite || fuel <= 0) {
                    return 'Fuel must be greater than 0';
                  }

                  return null;
                },
              ),

              const SizedBox(height: 30),

              // Calculate Button
              SizedBox(
                width: double.infinity,
                height: 55,

                child: ElevatedButton.icon(
                  onPressed: _calculateMileage,
                  icon: const Icon(Icons.calculate),
                  label: const Text(
                    'Calculate Mileage',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),

                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue.shade700,
                    foregroundColor: Colors.white,
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                    ),
                  ),
                ),
              ),

              const SizedBox(height: 15),

              // Clear Button
              SizedBox(
                width: double.infinity,
                child: OutlinedButton.icon(
                  onPressed: _clearForm,
                  icon: const Icon(Icons.refresh),
                  label: const Text('Clear Form'),
                ),
              ),

              const SizedBox(height: 25),

              // Result Card
              if (_result.isNotEmpty)
                Card(
                  elevation: 5,
                  color: Colors.white,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(15),
                  ),

                  child: Container(
                    width: double.infinity,
                    padding: const EdgeInsets.all(25),

                    child: Column(
                      children: [
                        Icon(
                          Icons.speed,
                          size: 50,
                          color: _resultColor,
                        ),

                        const SizedBox(height: 15),

                        const Text(
                          'Mileage Result',
                          style: TextStyle(
                            fontSize: 22,
                            fontWeight: FontWeight.bold,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Text(
                          _result,
                          textAlign: TextAlign.center,
                          style: TextStyle(
                            fontSize: 20,
                            fontWeight: FontWeight.bold,
                            color: _resultColor,
                          ),
                        ),

                        const SizedBox(height: 15),

                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 10,
                          ),

                          decoration: BoxDecoration(
                            color: _resultColor.withValues(
                              alpha: 0.12,
                            ),
                            borderRadius: BorderRadius.circular(20),
                          ),

                          child: Text(
                            _efficiency,
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.bold,
                              color: _resultColor,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),

              const SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}