import 'package:flutter/material.dart';
import 'package:my_app/screens/crud_screen.dart';
import 'package:my_app/screens/newsdetail_screen.dart';
import 'package:my_app/screens/profile_screen.dart';
import 'package:my_app/screens/APIscreen.dart';


class HomeScreen extends StatefulWidget {
  const HomeScreen({Key? key, required this.username}) : super(key: key);

  final String username;

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _bookingNumber = 0;
  bool _isServiceAdded = false;

  void _incrementBookingNumber() {
    if (!_isServiceAdded) {
      setState(() {
        _bookingNumber++;
        _isServiceAdded = true;
      });
    }
  }

  void _navigateToDetail(String newsTitle, String newsContent, String imagePath) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => NewsDetailScreen(
          newsTitle: newsTitle,
          newsContent: newsContent,
          imagePath: imagePath,
        ),
      ),
    );
  }

  void _navigateToProfile() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => ProfileScreen(
          sparePartHistory: [],
          servicePackageHistory: [],
        ),
      ),
    );
  }

  void _navigateToAPI() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => API(),
      ),
    );
  }

  void _navigateToCRUD() {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => JadwalScreen(),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
        title: Text(''),
        centerTitle: true,
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Padding(
            padding: EdgeInsets.all(20),
            child: Text(
              'Halo, Kusuma Triguna ${widget.username}',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
          ),
          Expanded(
            child: SingleChildScrollView(
              child: Padding(
                padding: EdgeInsets.all(20),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text(
                            'AUM SERVICE CENTER',
                            textAlign: TextAlign.center,
                            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                          ),
                          SizedBox(height: 10),
                          Image.asset(
                            'assets/images/logo.png',
                            height: 200,
                          ),
                        ],
                      ),
                    ),
                    SizedBox(height: 20),
                    Center(
                      child: Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 32),
                        child: ElevatedButton(
                          onPressed: _incrementBookingNumber,
                          child: Text(
                            'No Antrian',
                            style: TextStyle(
                              fontSize: 18,
                              fontWeight: FontWeight.bold,
                              color: Colors.black,
                            ),
                          ),
                          style: ElevatedButton.styleFrom(
                            padding: EdgeInsets.symmetric(vertical: 12, horizontal: 24),
                            backgroundColor: Color.fromARGB(255, 255, 0, 0),
                            elevation: 4,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.zero,
                            ),
                          ),
                        ),
                      ),
                    ),
                    SizedBox(height: 10),
                    _bookingNumber > 0 ?
                    Center(
                      child: Text(
                        'Nomor Antrian: $_bookingNumber',
                        style: TextStyle(fontSize: 18),
                      ),
                    ) : Container(),
                    SizedBox(height: 20),
                    Text(
                      'News',
                      style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Column(
                      children: [
                        _buildNewsCard(
                          'CB150R',
                          'Honda resmi meluncurkan CB150R dengan seri K15G yang berada pada kelas Motor Sport 150cc dengan V3 pada tahun 2024',
                          'assets/images/cb150r.png',
                        ),
                        SizedBox(height: 10),
                        _buildNewsCard(
                          'CBR250RR',
                          'Honda resmi meluncurkan CBR250R pada kelas seri Motor Sport dengan seri K25G dengan V3 pada tahun 2024',
                          'assets/images/cbr250rr.png',
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            UserAccountsDrawerHeader(
              accountName: Text(widget.username),
              accountEmail: Text('Kusuma@gmail.com'),
              currentAccountPicture: CircleAvatar(
                backgroundImage: AssetImage('assets/images/0.png'),
              ),
              decoration: BoxDecoration(
                color: Colors.red,
              ),
            ),
            ListTile(
              title: Text('Profile'),
              onTap: _navigateToProfile,
            ),
            ListTile(
              title: Text('API'),
              onTap: _navigateToAPI,
            ),
            ListTile(
              title: Text('CRUD SQLite'),
              onTap: _navigateToCRUD,
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildNewsCard(String title, String content, String imagePath) {
    return InkWell(
      onTap: () => _navigateToDetail(title, content, imagePath),
      child: Card(
        color: title == 'CB150R' ? Colors.red : Color.fromARGB(255, 243, 58, 44),
        elevation: 4,
        child: Padding(
          padding: EdgeInsets.all(20),
          child: Row(
            children: [
              Image.asset(
                imagePath,
                height: 150,
                width: 80,
                fit: BoxFit.cover,
              ),
              SizedBox(width: 10),
              Expanded(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'News Update',
                      style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                    ),
                    SizedBox(height: 10),
                    Text(
                      content,
                      style: TextStyle(fontSize: 16),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
