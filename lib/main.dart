import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() {
  runApp(const MainApp());
}

class MainApp extends StatefulWidget {
  const MainApp({super.key});

  @override
  _MainAppState createState() => _MainAppState();
}

class _MainAppState extends State<MainApp> {
  String _data = 'Data will be displayed here';

  // fetchData Function
  Future<void> fetchData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.get(url);
    if (response.statusCode == 200) {
      setState(() {
        _data = response.body;
      });
      print("Data Fetched Successfully");
    } else {
      print("Failed to fetch data");
    }
  }

  // Post Data Function
  Future<void> postData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts');
    var response = await http.post(url, body: {
      'title': 'foo',
      'body': 'bar',
      'userId': '1',
    });

    if (response.statusCode == 201) {
      print("Data Created Successfully : ${response.body}");
    } else {
      print("Failed to create data");
    }
  }

  // Delete Data Function
  Future<void> deleteData() async {
    var url = Uri.parse('https://jsonplaceholder.typicode.com/posts/1');
    var response = await http.delete(url);

    if (response.statusCode == 200) {
      print("Data Deleted Successfully : ${response.body}");
    } else {
      print("Failed to delete data");
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        appBar: AppBar(
          title: const Text('Flutter HTTP Request'),
        ),
        body: Center(
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ElevatedButton(
                    onPressed: fetchData,
                    child: const Text("Fetch Data"),
                  ),
                  ElevatedButton(
                    onPressed: postData,
                    child: const Text("Post Data"),
                  ),
                  ElevatedButton(
                    onPressed: deleteData,
                    child: const Text("Delete Data"),
                  ),
                ],
              ),
              Expanded(
                child: SingleChildScrollView(
                  child: Text(_data),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
