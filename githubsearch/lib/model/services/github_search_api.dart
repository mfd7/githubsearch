import 'package:githubsearch/model/core/issues.dart';
import 'package:githubsearch/model/core/repositories.dart';
import 'package:githubsearch/model/core/user.dart';
import 'package:http/http.dart' as http;

class GithubSearchApi {
  static var client = http.Client();
  static var baseUrl = 'https://api.github.com/search/';

  static Future<User?> searchUser(query, page) async {
    var response = await client
        .get(Uri.parse('${baseUrl}users?q=$query&per_page=10&page=$page'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return userFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<Issues?> searchIssues(query, page) async {
    var response = await client
        .get(Uri.parse('${baseUrl}issues?q=$query&per_page=10&page=$page'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return issuesFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }

  static Future<Repositories?> searchRepo(query, page) async {
    var response = await client.get(
        Uri.parse('${baseUrl}repositories?q=$query&per_page=10&page=$page'));
    if (response.statusCode == 200) {
      var jsonString = response.body;
      return repositoriesFromJson(jsonString);
    } else {
      //show error message
      return null;
    }
  }
}
