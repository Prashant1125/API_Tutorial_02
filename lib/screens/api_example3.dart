import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

import 'package:api_tutorial_2/models/api_3_model.dart';

late Size mq;

class ApiExample3 extends StatefulWidget {
  const ApiExample3({super.key});

  @override
  State<ApiExample3> createState() => _ApiExample3State();
}

class _ApiExample3State extends State<ApiExample3> {
  List<UserModel> userList = [];

  Future<List<UserModel>> getUserApi() async {
    final response =
        await http.get(Uri.parse('https://jsonplaceholder.typicode.com/users'));
    var data = jsonDecode(response.body.toString());

    if (response.statusCode == 200) {
      for (Map i in data) {
        userList.add(UserModel.fromJson(i));
      }
      return userList;
    } else {
      return userList;
    }
  }

  @override
  Widget build(BuildContext context) {
    mq = MediaQuery.of(context).size;

    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Api Example 3 - Complex Json'),
      ),
      body: Column(children: [
        Expanded(
            child: FutureBuilder(
          future: getUserApi(),
          builder: (context, AsyncSnapshot<List<UserModel>> snapshot) {
            if (!snapshot.hasData) {
              return const Center(child: CircularProgressIndicator());
            } else {
              return ListView.builder(
                itemCount: userList.length,
                itemBuilder: (context, index) {
                  return Card(
                    child: Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          ReusableRow(
                              title: 'Name',
                              value: snapshot.data![index].name.toString()),
                          ReusableRow(
                              title: 'User Name',
                              value: snapshot.data![index].username.toString()),
                          ReusableRow(
                              title: 'Email',
                              value: snapshot.data![index].email.toString()),
                          ReusableRow(
                              title: 'Email',
                              value: snapshot.data![index].phone.toString()),
                          ReusableRow(
                              title: 'Email',
                              value: snapshot.data![index].website.toString()),
                          ReusableRow(
                              title: 'Email',
                              value: snapshot.data![index].company.toString()),
                          ReusableRow(
                              title: 'Address',
                              value:
                                  '${snapshot.data![index].address!.street} , ${snapshot.data![index].address!.suite} , ${snapshot.data![index].address!.city} , ${snapshot.data![index].address!.zipcode} , ${snapshot.data![index].address!.geo!.lat} , ${snapshot.data![index].address!.geo!.lng}'),
                        ],
                      ),
                    ),
                  );
                },
              );
            }
          },
        ))
      ]),
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
            titleAlignment: ListTileTitleAlignment.top,
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
