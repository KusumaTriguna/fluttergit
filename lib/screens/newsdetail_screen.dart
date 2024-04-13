import 'package:flutter/material.dart';

class NewsDetailScreen extends StatelessWidget {
  final String newsTitle;
  final String newsContent;
  final String imagePath;

  const NewsDetailScreen({
    required this.newsTitle,
    required this.newsContent,
    required this.imagePath,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(newsTitle),
        backgroundColor: Color.fromARGB(255, 255, 0, 0),
      ),
      body: Padding(
        padding: EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              newsTitle,
              style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
            ),
            SizedBox(height: 10),
            Image.asset(
              imagePath,
              height: 150,
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 10),
            Text(
              newsContent,
              style: TextStyle(fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
