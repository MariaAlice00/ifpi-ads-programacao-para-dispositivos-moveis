// ignore_for_file: prefer_const_constructors, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:posts_navegacao/post.dart';
import 'package:flutter/material.dart';

class PostDetailsPage extends StatelessWidget {
  final Post post;

  PostDetailsPage({required this.post});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Post ${post.id}'),
      ),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Card(
              child: ListTile(
                title: Text(  
                  post.title,  
                  style: TextStyle(fontSize: 30.0)  
                ),  
              ),
            ),
            Card(
              child: ListTile(
                title: Text(  
                  post.body,  
                  style: TextStyle(fontSize: 18.0)  
                ), 
              ),
            ),
          ]
        ),
      ),
    );
  }
}