import 'package:flutter/material.dart';

class ProfileScreen extends StatelessWidget {
  final List<String> sparePartHistory;
  final List<String> servicePackageHistory;

  const ProfileScreen({
    Key? key,
    required this.sparePartHistory,
    required this.servicePackageHistory,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(''),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.start,
          children: <Widget>[
            const CircleAvatar(
              radius: 90,
              backgroundImage: AssetImage('assets/images/0.png'),
            ),
            const SizedBox(height: 20),
            const Text(
              '@KusumaTriguna',
              style: TextStyle(
                fontSize: 26,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            const Text(
              'Mahasiswa',
              style: TextStyle(
                fontSize: 20,
                color: Colors.grey,
              ),
            ),
            const Divider(height: 40),
            const SizedBox(height: 10),
            const ListTile(
              leading: Icon(Icons.person_2_outlined),
              title: Text('Komang Kusuma Triguna', style: TextStyle(fontSize: 18)),
            ),
            const ListTile(
              leading: Icon(Icons.school),
              title: Text('Universitas Pendidikan Ganesha', style: TextStyle(fontSize: 18)),
            ),
            const ListTile(
              leading: Icon(Icons.location_on),
              title: Text('Singaraja, Bali', style: TextStyle(fontSize: 18)),
            ),
            const Divider(height: 20),
          ],
        ),
      ),
    );
  }
}