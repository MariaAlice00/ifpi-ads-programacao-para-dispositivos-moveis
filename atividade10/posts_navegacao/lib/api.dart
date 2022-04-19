import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";

class API {
  static Future getPosts() async {
    var url = baseUrl + "/posts";
    return await http.get(Uri.parse(url));
  }
}
