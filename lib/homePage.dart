// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';
import 'package:flutter_api_example/models/api_model.dart';
import 'package:flutter_api_example/secondPage.dart';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List<ApiModel> apiList = [];
  Future<List<ApiModel>> getPostApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = apiModelFromJson(response.body);
    if (response.statusCode == 200) {
      apiList = [...data];
      return apiList;
    } else {
      return apiList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Api'),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Expanded(
              child: FutureBuilder(
                  future: getPostApi(),
                  builder: ((context, snapshot) {
                    if (!snapshot.hasData) {
                      return Text('Loading.....');
                    } else {
                      return ListView.builder(
                          itemCount: apiList.length,
                          itemBuilder: ((context, index) {
                            return Text(apiList[index].title.toString());
                          }));
                    }
                  })),
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => SecondPage()));
              },
              child: Text('Image Model'),
            )
          ],
        ),
      ),
    );
  }
}
