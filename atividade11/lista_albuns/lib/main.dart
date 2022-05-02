// ignore_for_file: avoid_print, use_key_in_widget_constructors, prefer_const_constructors, prefer_final_fields, prefer_is_empty

import 'package:flutter/material.dart';
import 'dart:convert';
import 'package:http/http.dart' as http;

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        // Remove the debug banner
        debugShowCheckedModeBanner: false,
        title: 'Lista de Posts',
        theme: ThemeData(
          primarySwatch: Colors.pink,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _baseUrl = 'https://jsonplaceholder.typicode.com/posts';

  int _page = 1;
  int _limit = 20;
  bool _hasNextPage = true; // Existe a próxima página ou não
  bool _isFirstLoadRunning =
      false; // Exibir o 'carregar' quando _firstLoad estiver executando
  bool _isLoadMoreRunning =
      false; // Exibir o 'carregar' quando _loadMore estiver executando

  var _posts = [];

  // Função ativa quando o aplicativo iniciar
  void _firstLoad() async {
    setState(() {
      _isFirstLoadRunning = true;
    });
    try {
      final res =
          await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));
      setState(() {
        _posts = json.decode(res.body); // transformar em json
      });
    } catch (err) {
      print('Algo deu errado!');
    }

    setState(() {
      _isFirstLoadRunning = false;
    });
  }

  // Função ativada quando rolar pra baixo
  void _loadMore() async {
    if (_hasNextPage == true &&
        _isFirstLoadRunning == false &&
        _isLoadMoreRunning == false &&
        _controller.position.extentAfter < 300) {
      // A quantidade de conteúdo conceitualmente "abaixo" da janela de visualização no rolável.
      setState(() {
        _isLoadMoreRunning = true; 
      });
      _page += 1;
      try {
        final res =
            await http.get(Uri.parse("$_baseUrl?_page=$_page&_limit=$_limit"));

        final List fetchedPosts = json.decode(res.body);

        if (fetchedPosts.length > 0) {
          setState(() {
            _posts.addAll(fetchedPosts);
          });
        } else {
          // não há mais dados
          setState(() {
            _hasNextPage = false;
          });
        }
      } catch (err) {
        print('Algo deu errado!');
      }

      setState(() {
        _isLoadMoreRunning = false;
      });
    }
  }

  late ScrollController _controller;

  @override
  void initState() {
    super.initState();
    _firstLoad();
    _controller = ScrollController();
    _controller.addListener(_loadMore);
  }

  @override
  void dispose() {
    _controller.removeListener(_loadMore);
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Lista de Posts'),
      ),
      body: Column(
        children: [
          Expanded(
            child: ListView.builder(
              controller: _controller,
              itemCount: _posts.length,
              itemBuilder: (context, index) => Card(
                margin: EdgeInsets.symmetric(vertical: 8, horizontal: 10),
                child: ListTile(
                  title: Text('${_posts[index]['id']} - ${_posts[index]['title']}'),
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => Scaffold(
                              appBar: AppBar(
                                title: Text(
                                    'Post ${_posts[index]['id']}'),
                              ),
                              body: SafeArea(
                                  child: Column(
                                crossAxisAlignment:
                                    CrossAxisAlignment.center,
                                children: [
                                  Card(
                                    child: ListTile(
                                      title: Text(
                                        _posts[index]['title'],
                                        style: TextStyle(
                                          fontSize: 30.0)
                                        ),
                                    ),
                                  ),
                                  Card(
                                    child: ListTile(
                                      title: Text(
                                        _posts[index]['body'],
                                        style: TextStyle(
                                          fontSize: 18.0)
                                        ),
                                    ),
                                  ),
                                ],
                              )
                            ),
                          )
                        )
                      );
                  },
                ),
              ),
            ),
          ),

          // quando a função _loadMore está em execução
          if (_isLoadMoreRunning == true)
            Padding(
              padding: const EdgeInsets.only(top: 10, bottom: 40),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            ),

          // Quando nada tem para carregar
          if (_hasNextPage == false) 
            Container(
              padding: const EdgeInsets.only(top: 30, bottom: 40),
              color: Colors.amber,
              child: Center(
                child: Text('Você buscou todo o conteúdo'),
              ),
            ),
        ],
      ),
    );
  }
}