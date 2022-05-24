// ignore_for_file: prefer_const_constructors

import 'dart:convert';
import 'package:flutter/material.dart';
import 'album.dart';
import 'api.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.purple,
      ),
      home: const MyHomePage(title: 'Albums List'),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({Key? key, required this.title}) : super(key: key);

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  var albums = [];

  _getAlbums() {
    API.getAlbums().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        albums = lista.map((model) => Album.fromJson(model)).toList();
      });
    });
  }

  _MyHomePageState() {
    _getAlbums();
  }

  int dropdownValue = 1;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text(widget.title),
        ),
        body: Center(
            child: Column(
          children: <Widget>[
            Container(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('UserID', style: TextStyle(fontSize: 18),),
                  SizedBox(width: 20),
                  DropdownButton(
                    value: dropdownValue,
                    icon: const Icon(Icons.arrow_downward),
                    elevation: 16,
                    style: const TextStyle(color: Colors.deepPurple),
                    underline: Container(
                      height: 2,
                      color: Colors.deepPurpleAccent,
                    ),
                    onChanged: (int? newValue) {
                      setState(() {
                        dropdownValue = newValue!;
                      });
                    },
                    items: <int>[1, 2, 3, 4, 5, 6, 7, 8, 9, 10].map<DropdownMenuItem<int>>((int value) {
                      return DropdownMenuItem<int>(
                        value: value,
                        child: Text('$value'),
                      );
                    }).toList(),
                  ),
                ],
              )
            ),
            Expanded(
              child: ListView.builder(
                itemCount: albums.length,
                itemBuilder: (context, index) {
                  int id = albums[index].id;
                  int userId = albums[index].userId;
                  if (userId == dropdownValue) {
                    return ListTile(
                      title: Text(
                        '$id - ${albums[index].title}',
                        style: TextStyle(fontSize: 20.0, color: Colors.black),
                      ),
                    );
                  } else {
                    return Container();
                  }
                }),
            ),
          ],
        )));
  }
}
