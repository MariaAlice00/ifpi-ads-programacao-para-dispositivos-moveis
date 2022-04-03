// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:albuns_list/album.dart';
import 'package:albuns_list/api.dart';
import 'package:flutter/material.dart';

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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: listaAlbums(),
    );
  }

  listaAlbums() {
    return ListView.builder(
        itemCount: albums.length,
        itemBuilder: (context, index) {
          int id = albums[index].id;
          String texto = "Album $id clicado";
          return ListTile(
            title: Text(
              albums[index].title,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            onTap: () {
              final snackBar = SnackBar(
                content: Text(texto),
                duration: const Duration(seconds: 1),
              );
              ScaffoldMessenger.of(context).showSnackBar(snackBar);
            },
          );
        });
  }
}
