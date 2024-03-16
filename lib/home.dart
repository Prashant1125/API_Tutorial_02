import 'dart:convert';

import 'package:api_tutorial_2/models/post_model.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  List<Photos> photosList = [];

// funtion for get data;
  Future<List<Photos>> getPhotos() async {
    final response = await http
        .get(Uri.parse('https://jsonplaceholder.typicode.com/photos'));
    var data = jsonDecode(response.body.toString());
    if (response.statusCode == 200) {
      for (Map i in data) {
        Photos photos = Photos(title: i['title'], url: i['url'], id: i['id']);
        photosList.add(photos);
      }
      return photosList;
    } else {
      return photosList;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 35, 180, 185),
        centerTitle: true,
        title: const Text(
          'API Tutorial - 02',
          style: TextStyle(color: Colors.white, fontFamily: "Geneva"),
        ),
      ),
      body: Column(
        children: [
          Expanded(
            child: FutureBuilder(
              builder: (context, AsyncSnapshot<List<Photos>> snapshot) {
                return ListView.builder(
                  itemCount: photosList.length,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        leading: CircleAvatar(
                          radius: 30,
                          backgroundImage: NetworkImage(
                              snapshot.data![index].url.toString()),
                        ),
                        subtitle: Text(snapshot.data![index].title.toString()),
                        title: Text('Notes Id = ${snapshot.data![index].id}'),
                        tileColor: const Color.fromARGB(255, 202, 253, 255),
                      ),
                    );
                  },
                );
              },
              future: getPhotos(),
            ),
          )
        ],
      ),
    );
  }
}
