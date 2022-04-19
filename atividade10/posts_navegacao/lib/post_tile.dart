// ignore_for_file: prefer_const_constructors, prefer_const_constructors_in_immutables, use_key_in_widget_constructors

import 'package:posts_navegacao/post.dart';
import 'package:posts_navegacao/post_details.dart';
import 'package:flutter/material.dart';

class PostTile extends StatelessWidget {
  final Post post;

  PostTile({required this.post});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 10.0),
      child: Column(
        children: [
          ListTile(
            title: Text(post.title,
              style: TextStyle(fontSize: 20.0, color: Colors.black),
            ),
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => PostDetailsPage(post: post)
                )
              );
            },
          ),
          Divider(
            thickness: 2.0,
          ),
        ],
      ),
    );
  }
}