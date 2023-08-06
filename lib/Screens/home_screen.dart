import 'dart:convert';

import 'package:api_integration_app/Models/PostsModel.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}


class _HomeScreenState extends State<HomeScreen> {

  ///If the name of the array is no, then a custom list has to be created
  List<PostsModel> postList = [];

  Future<List<PostsModel>> getPostApi() async {
    final response =
    await http.get(Uri.parse('https://jsonplaceholder.typicode.com/posts'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      postList.clear();
      for (Map i in data) {
        postList.add(PostsModel.fromJson(i));
      }
      return postList;
    } else {
      return postList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("API"),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              future: getPostApi(),
              builder: (context, snapshot) {
                if (!snapshot.hasData) {
                  return Center(
                    child: CircularProgressIndicator(color: Colors.blue,),
                  );
                } else {
                  return ListView.builder(
                    itemCount: postList.length,
                    itemBuilder: (context, index) {
                    return Card(
                      child: Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.start,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text('Title',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            Text(postList[index].title.toString()),
                            SizedBox(height: 5,),
                            Text('Description',style: TextStyle(fontSize: 15,fontWeight: FontWeight.bold),),
                            SizedBox(height: 5,),
                            Text(postList[index].body.toString()),
                          ],
                        ),
                      ),
                    );
                  },);
                }
              },
            ),
          )
        ],
      ),
    );
  }
}
