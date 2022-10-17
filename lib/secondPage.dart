import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'models/image_model.dart';

class SecondPage extends StatelessWidget {
  const SecondPage({super.key});

  @override
  Widget build(BuildContext context) {
    List<ImageModel> imageList = [];
    Future<List<ImageModel>> getImage() async {
      final response = await http
          .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
      var data = imageModelFromJson(response.body);

      if (response.statusCode == 200) {
        imageList = [...data];
        return imageList;
      } else {
        return imageList;
      }
    }

    return Scaffold(
      appBar: AppBar(
        title: Text('Image From Api'),
        centerTitle: true,
      ),
      body: Column(
        children: [
          Expanded(
              child: FutureBuilder(
            future: getImage(),
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Loading........");
              } else {
                return ListView.builder(
                    itemCount: imageList.length,
                    itemBuilder: ((context, index) {
                      return ListTile(
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(
                            imageList[index].url,
                          ),
                        ),
                        title: Text('ID: ${imageList[index].id.toString()}'),
                        subtitle: Text(imageList[index].title.toString()),
                      );
                    }));
              }
            },
          ))
        ],
      ),
    );
  }
}
