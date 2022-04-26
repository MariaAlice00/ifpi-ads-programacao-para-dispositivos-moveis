import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Infinite Scrolling ListView",
      theme: ThemeData(
        primarySwatch: Colors.teal,
      ),
      home: PostPage(),
    );
  }
}

class PostPage extends StatefulWidget {
  @override
  _PostPageState createState() => _PostPageState();
}

class _PostPageState extends State<PostPage> {
  late bool _hasMore;
  late int _pageNumber;
  late bool _error;
  late bool _loading;
  late final int _defaultPostsPerPageCount = 10;
  late List<Post> _posts;
  late final int _nextPageThreshold = 5;

  @override
  void initState() {
    super.initState();
    _hasMore = true;
    _pageNumber = 1;
    _error = false;
    _loading = true;
    _posts = [];
    fetchPosts();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Posts App")),
      body: getBody(),
    );
  }

  Widget getBody() {
    if (_posts.isEmpty) {
      if (_loading) {
        return Center(
            child: Padding(
          padding: const EdgeInsets.all(8),
          child: CircularProgressIndicator(),
        ));
      } else if (_error) {
        return Center(
          child: InkWell(
            onTap: () => setState(
              () {
                _loading = true;
                _error = false;
                fetchPosts();
              },
            ),
            child: Padding(
              padding: const EdgeInsets.all(16),
              child: Text("Error while loading posts, tap to try agin"),
            ),
          ),
        );
      }
    } else {
      return ListView.builder(
        itemCount: _posts.length + (_hasMore ? 1 : 0),
        itemBuilder: (context, index) {
          if (index == _posts.length - _nextPageThreshold) {
            fetchPosts();
          }
          if (index == _posts.length) {
            if (_error) {
              return Center(
                child: InkWell(
                  onTap: () => setState(
                    () {
                      _loading = true;
                      _error = false;
                      fetchPosts();
                    },
                  ),
                  child: Padding(
                    padding: const EdgeInsets.all(16),
                    child: Text("Error while loading photos, tap to try agin"),
                  ),
                ),
              );
            } else {
              return Center(
                child: Padding(
                  padding: const EdgeInsets.all(8),
                  child: CircularProgressIndicator(),
                ),
              );
            }
          }
          final Post post = _posts[index];
          return Card(
            child: Column(
              children: <Widget>[
                Padding(
                  padding: const EdgeInsets.all(16),
                  child: Text(
                    '${post.id} - ${post.title}',
                    style: TextStyle(
                      fontWeight: FontWeight.bold,
                      fontSize: 16,
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      );
    }
    return Container();
  }

  Future<void> fetchPosts() async {
    try {
      final response = await http.get(Uri.parse(
          "https://jsonplaceholder.typicode.com/posts?_page=$_pageNumber"));
      List<Post> fetchedPosts = Post.parseList(json.decode(response.body));
      setState(
        () {
          _hasMore = fetchedPosts.length == _defaultPostsPerPageCount;
          _loading = false;
          _pageNumber = _pageNumber + 1;
          _posts.addAll(fetchedPosts);
        },
      );
    } catch (e) {
      setState(
        () {
          _loading = false;
          _error = true;
        },
      );
    }
  }
}

class Post {
  final int id;
  final String title;

  Post(this.id, this.title);

  factory Post.fromJson(Map<String, dynamic> json) {
    return Post(json["id"], json["title"]);
  }

  static List<Post> parseList(List<dynamic> list) {
    return list.map((i) => Post.fromJson(i)).toList();
  }
}
