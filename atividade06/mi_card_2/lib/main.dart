// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, use_key_in_widget_constructors, avoid_unnecessary_containers

import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Scaffold(
        backgroundColor: Colors.white,
        body: SafeArea(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            Container(
              color: Colors.purple[100],
              height: 300,
              child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        CircleAvatar(
                          radius: 50,
                          backgroundImage: AssetImage('images/avatar.jpg'),
                        ),
                        Text(
                          'Maria Alice',
                          style: TextStyle(
                              fontFamily: 'Pacifico',
                              color: Colors.white,
                              fontSize: 20,
                              fontWeight: FontWeight.w600),
                        ),
                        SizedBox(
                          height: 20.0,
                          width: 150.0,
                          child: Divider(
                            color: Colors.purple[900],
                          ),
                        ),
                        Text(
                          'FLUTTER DEVELOPER',
                          style: TextStyle(
                              color: Colors.purple[900],
                              fontSize: 10,
                              letterSpacing: 2.5,
                              fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Container(
                          width: 230,
                          height: 200,
                          color: Colors.purple[50],
                          child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: <Widget>[
                                buildCard('+55 86 99999 9999', Icons.phone),
                                buildCard('alice@email.com', Icons.email),
                              ]),
                        ),
                      ],
                    )
                  ]),
            )
          ],
        )),
      ),
    );
  }

  Card buildCard(String text, IconData icon) {
    return Card(
        margin: EdgeInsets.symmetric(vertical: 10.0, horizontal: 25.0),
        child: ListTile(
          leading: Icon(
            icon,
            color: Colors.purple[900],
          ),
          title: Text(
            text,
            style: TextStyle(
              color: Colors.purple[900],
              fontSize: 13.0,
            ),
          ),
        ));
  }
}
