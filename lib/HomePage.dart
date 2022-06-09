// ignore_for_file: file_names, unused_local_variable, unnecessary_this, annotate_overrides, prefer_const_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:convert';
import 'package:http/http.dart' as http;

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  List? userData;
  bool isloading = true;
  final String url = 'https://randomuser.me/api/?results=50';
  Future getData() async {
    var response =
        await http.get(Uri.parse(url), headers: {"Accept": "application/json"});
    List data = jsonDecode(response.body)['results'];
    setState(() {
      userData = data;
      isloading = false;
    });
  }

  @override
  void initState() {
    super.initState();
    this.getData();
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Random Users"),
      ),
      body: Container(
        child: Center(
            child: isloading
                ? CircularProgressIndicator()
                : ListView.builder(
                    itemCount: userData!.length,
                    itemBuilder: (context, index) {
                      return Card(
                        child: Row(
                          children: [
                            Container(
                              margin: EdgeInsets.all(20.0),
                              child: Image(
                                  width: 70.0,
                                  height: 70.0,
                                  fit: BoxFit.contain,
                                  image: NetworkImage(userData![index]
                                      ['picture']['thumbnail'])),
                            ),
                            Expanded(
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    userData![index]['name']['first'] +
                                        " " +
                                        userData![index]['name']['last'],
                                    style: TextStyle(fontSize: 20.0,fontWeight:FontWeight.bold),
                                  ),
                                  Text("Phone: ${userData![index]['phone']}"),
                                  Text("Gender: ${userData![index]['gender']}"),
                                ],
                              ),
                            )
                          ],
                        ),
                      );
                    },
                  )),
      ),
    );
  }
}
