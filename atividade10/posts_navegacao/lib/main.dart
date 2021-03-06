// ignore_for_file: prefer_const_constructors

import 'dart:convert';

import 'package:posts_navegacao/post.dart';
import 'package:posts_navegacao/post_tile.dart';
import 'package:posts_navegacao/api.dart';
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
      home: const MyHomePage(title: 'Posts List'),
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
  var posts = [];

  _getPosts() {
    API.getPosts().then((response) {
      setState(() {
        Iterable lista = json.decode(response.body);
        posts = lista.map((model) => Post.fromJson(model)).toList();
      });
    });
  }

  _MyHomePageState() {
    _getPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: listaPosts(),
    );
  }

  listaPosts() {
    return ListView.builder(
        itemCount: posts.length,
        itemBuilder: (context, index) {
          return PostTile(post: posts[index]);
          
        });
  }
}
