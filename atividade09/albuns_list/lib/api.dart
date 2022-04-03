import 'package:http/http.dart' as http;

const baseUrl = "https://jsonplaceholder.typicode.com";

class API {
  static Future getAlbums() async {
    var url = baseUrl + "/albums";
    return await http.get(Uri.parse(url));
  }
}
