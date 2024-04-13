import 'package:flutter/material.dart';

class ServiceScreen extends StatelessWidget {
  const ServiceScreen({Key? key}) : super(key: key);

  final List<String> motorcycleTypes = const ['Sport', 'Matic', 'Adventure', 'Cruiser'];
  final Map<String, List<String>> spareParts = const {
    'Sport': ['Oli', 'Filter Udara', 'Ban'],
    'Matic': ['Oli', 'Kampas Rem', 'Variator'],
    'Adventure': ['Oli', 'Filter Oli', 'Ban'],
    'Cruiser': ['Oli', 'Filter Udara', 'Ban'],
  };
  final Map<String, List<String>> servicePackages = const {
    'Sport': ['Service Ringan', 'Service Menengah', 'Service Berat'],
    'Matic': ['Service Rutin', 'Service Total', 'Service Mesin'],
    'Adventure': ['Service Rutin', 'Service Total', 'Service Mesin'],
    'Cruiser': ['Service Ringan', 'Service Menengah', 'Service Berat'],
  };

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Motorcycle Types'),
        backgroundColor: const Color.fromARGB(255, 255, 17, 0), 
      ),
      body: ListView.builder(
        itemCount: motorcycleTypes.length + 1,
        itemBuilder: (BuildContext context, int index) {
          if (index == motorcycleTypes.length) {
            return Padding(
              padding: const EdgeInsets.all(20.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Vouchers',
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: List.generate(2, (index) {
                      final voucherIndex = index + 1;
                      return Expanded(
                        flex: 1,
                        child: VoucherCard(
                          title: 'Voucher $voucherIndex',
                          description: voucherIndex.isEven
                              ? 'Diskon 10% untuk pembelian spare part'
                              : 'Gratis 1 kali service rutin',
                        ),
                      );
                    }),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: List.generate(2, (index) {
                      final voucherIndex = index + 3;
                      return Expanded(
                        flex: 1,
                        child: VoucherCard(
                          title: 'Voucher $voucherIndex',
                          description: voucherIndex.isEven
                              ? 'Diskon 20% untuk service berat'
                              : 'Gratis 1 kali ganti ban',
                        ),
                      );
                    }),
                  ),
                ],
              ),
            );
          } else {
            return ListTile(
              title: Text(motorcycleTypes[index]),
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => DetailScreen(
                      type: motorcycleTypes[index],
                      spareParts: spareParts[motorcycleTypes[index]]!,
                      servicePackages: servicePackages[motorcycleTypes[index]]!,
                    ),
                  ),
                );
              },
            );
          }
        },
      ),
    );
  }
}

class VoucherCard extends StatefulWidget {
  final String title;
  final String description;

  const VoucherCard({
    Key? key,
    required this.title,
    required this.description,
  }) : super(key: key);

  @override
  _VoucherCardState createState() => _VoucherCardState();
}

class _VoucherCardState extends State<VoucherCard> {
  bool _isUsed = false;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Container(
        color: Colors.red,
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.title,
                style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold, color: Colors.white),
              ),
              const SizedBox(height: 10),
              Text(
                widget.description,
                style: const TextStyle(fontSize: 16, color: Colors.white),
              ),
              const SizedBox(height: 10),
              ElevatedButton(
                onPressed: () {
                  setState(() {
                    _isUsed = true;
                  });
                  print('Voucher Digunakan');
                },
                child: Text(_isUsed ? 'Voucher Digunakan' : 'Pilih'),
              ),
              const SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }
}

class DetailScreen extends StatefulWidget {
  final String type;
  final List<String> spareParts;
  final List<String> servicePackages;

  const DetailScreen({
    Key? key,
    required this.type,
    required this.spareParts,
    required this.servicePackages,
  }) : super(key: key);

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late Map<String, bool> _sparePartCheckedMap;
  late Map<String, bool> _servicePackageCheckedMap;

  @override
  void initState() {
    super.initState();
    _sparePartCheckedMap = Map.fromIterable(widget.spareParts, key: (item) => item, value: (_) => false);
    _servicePackageCheckedMap = Map.fromIterable(widget.servicePackages, key: (item) => item, value: (_) => false);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.type),
        backgroundColor: Colors.red,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Spare Parts:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildSparePartCheckboxes(),
            ),
            const SizedBox(height: 20),
            Text(
              'Service Packages:',
              style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: _buildServicePackageCheckboxes(),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
              ),
              child: const Text('Back'),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                _saveSelections();
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => SecondScreen(totalPrice: _calculateTotalPrice()),
                  ),
                );
              },
              child: const Text('Simpan'),
            ),
          ],
        ),
      ),
    );
  }

  List<Widget> _buildSparePartCheckboxes() {
    return _sparePartCheckedMap.keys.map((sparePart) {
      return CheckboxListTile(
        title: Text(sparePart),
        value: _sparePartCheckedMap[sparePart],
        onChanged: (value) {
          setState(() {
            _sparePartCheckedMap[sparePart] = value!;
          });
        },
      );
    }).toList();
  }

  List<Widget> _buildServicePackageCheckboxes() {
    return _servicePackageCheckedMap.keys.map((servicePackage) {
      return CheckboxListTile(
        title: Text(servicePackage),
        value: _servicePackageCheckedMap[servicePackage],
        onChanged: (value) {
          setState(() {
            _servicePackageCheckedMap[servicePackage] = value!;
          });
        },
      );
    }).toList();
  }

  double _calculateTotalPrice() {
    double totalPrice = 0.0;

    _sparePartCheckedMap.forEach((sparePart, isChecked) {
      if (isChecked) {
        totalPrice += 10.0; // Example price for spare part
      }
    });

    _servicePackageCheckedMap.forEach((servicePackage, isChecked) {
      if (isChecked) {
        totalPrice += 20.0; // Example price for service package
      }
    });

    return totalPrice;
  }

  void _saveSelections() {
    print('Spare Parts:');
    _sparePartCheckedMap.forEach((sparePart, isChecked) {
      if (isChecked) {
        print(sparePart);
      }
    });

    print('Service Packages:');
    _servicePackageCheckedMap.forEach((servicePackage, isChecked) {
      if (isChecked) {
        print(servicePackage);
      }
    });
  }
}

class SecondScreen extends StatelessWidget {
  final double totalPrice;

  const SecondScreen({Key? key, required this.totalPrice}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Price'),
        backgroundColor: Colors.red,
      ),
      body: Center(
        child: Container(
          padding: const EdgeInsets.all(20.0),
          decoration: BoxDecoration(
            color: Colors.grey[200],
            borderRadius: BorderRadius.circular(10.0),
          ),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Total Price',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
              ),
              const SizedBox(height: 20),
              Text(
                '\$$totalPrice',
                style: const TextStyle(fontSize: 36, fontWeight: FontWeight.bold, color: Colors.red),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

void main() {
  runApp(MaterialApp(
    home: ServiceScreen(),
  ));
}
