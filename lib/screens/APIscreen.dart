import 'package:flutter/material.dart';
import 'package:my_app/Services/data_service.dart';
import 'package:my_app/dto/News.dart';

class API extends StatefulWidget {
  const API({Key? key}) : super(key: key);

  @override
  State<API> createState() => _APIState();
}

class _APIState extends State<API> {
  final Future<List<News>> _news = DataService.fetchNews();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('API News'),
        backgroundColor: Colors.red,
        leading: IconButton(
          icon: Icon(Icons.arrow_back),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
      ),
      body: Center(
        child: FutureBuilder<List<News>>(
          future: _news,
          builder: (context, snapshot) {
            if (snapshot.hasData) {
              return ListView.builder(
                itemCount: snapshot.data!.length,
                itemBuilder: (context, index) {
                  final post = snapshot.data![index];
                  return Card(
                    elevation: 4,
                    margin: EdgeInsets.symmetric(vertical: 8, horizontal: 16),
                    child: ListTile(
                      title: Text(
                        post.title,
                        style: TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      subtitle: Text(post.body),
                      onTap: () {
                        // Add action when news is tapped here
                      },
                    ),
                  );
                },
              );
            } else if (snapshot.hasError) {
              return Text('${snapshot.error}');
            }
            return const CircularProgressIndicator();
          },
        ),
      ),
    );
  }
}
