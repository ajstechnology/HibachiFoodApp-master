import 'dart:convert';
import '../database/sharedPreference.dart';
import 'package:http/http.dart' as http;
import 'Models/blogApiModel.dart';
import 'apiRoutes.dart';

Future<List<BlogModel>> getBlogsListFromServer() async {
  try {
    String url = APIRoute.getBlogListURL();
    String token = loggedInUser == null ? '' : loggedInUser.apiToken;
    var response = await http.get(Uri.parse(url), headers: {
      'Content-Type': 'application/json',
      'Authorization': 'Bearer $token',
    });
    print("getBlogsListFromServer()" + response.statusCode.toString());
    if (response.statusCode == 200) {
      var parseData = BlogApiModel.fromJson(jsonDecode(response.body));
      if (parseData.status) {
        return parseData.blogList;
      }
      return [];
    } else {
      return [];
    }
  } catch (ex) {
    print("getBlogsListFromServer() " + ex.toString());
    return [];
  }
}
