import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class ApiExample4 extends StatefulWidget {
  const ApiExample4({super.key});

  @override
  State<ApiExample4> createState() => _ApiExample4State();
}

class _ApiExample4State extends State<ApiExample4> {
  var data;

  Future<void> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));

    if (response.statusCode == 200) {
      return data = jsonDecode(response.body.toString());
    } else {}
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          backgroundColor: const Color.fromARGB(255, 220, 255, 221),
          centerTitle: true,
          title: const Text('Api Example 4 - Json Data Without Model')),
      body: Column(
        children: [
          FutureBuilder(
            future: getUserApi(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              }
              return Expanded(
                child: ListView.builder(
                  itemBuilder: (context, index) {
                    return Card(
                      child: Column(
                        children: [
                          ReusableRow(
                              title: 'Name',
                              value: data[index]['name'].toString()),
                          ReusableRow(
                              title: 'User Name',
                              value: data[index]['username'].toString()),
                          ReusableRow(
                              title: 'Address',
                              value: data[index]['address']['city'].toString()),
                          ReusableRow(
                              title: 'Zip Code',
                              value:
                                  data[index]['address']['zipcode'].toString()),
                          ReusableRow(
                              title: 'Geo',
                              value: data[index]['address']['geo'].toString()),
                        ],
                      ),
                    );
                  },
                ),
              );
            },
          )
        ],
      ),
    );
  }
}

// ignore: must_be_immutable
class ReusableRow extends StatelessWidget {
  String title, value;
  ReusableRow({Key? key, required this.title, required this.value})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
        padding: const EdgeInsets.all(8.0),
        child: ListTile(
            titleAlignment: ListTileTitleAlignment.center,
            minVerticalPadding: 1,
            contentPadding: EdgeInsets.zero,
            visualDensity: const VisualDensity(horizontal: -4, vertical: -4),
            leading: Text(
              title,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w600),
            ),
            title: Text(
              value,
              style: const TextStyle(fontSize: 15, fontWeight: FontWeight.w400),
            )));
  }
}
