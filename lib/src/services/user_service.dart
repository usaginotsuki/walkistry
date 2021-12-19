import 'package:http/http.dart' as http;
import 'dart:convert';

import 'package:walkistry_flutter/src/models/user_model.dart';
import 'package:walkistry_flutter/src/models/stats/walk_list_model.dart';

class UserHelper {
  UserHelper();
  final String _rootUrl =
      'https://us-central1-walkistry.cloudfunctions.net/api/users';

  Future<User?> getUser(String id) async {
    try {
      User user;
      var url = Uri.parse(_rootUrl + '/' + id);

      final response = await http.get(url);
      if (response.body.isEmpty) {
        return null;
      }
      print(json.decode(response.body));
      user = User.fromJson(json.decode(response.body));

      return user;
    } catch (e) {
      return null;
    }
  }

  Future<List<WalkList>?> getWalks(String id) async {
    try {
      List<WalkList> walks = [];
      var url = Uri.parse(_rootUrl + '/' + id + '/walks');

      final response = await http.get(url);
      if (response.body.isEmpty) {
        return null;
      }

      for (var walk in json.decode(response.body)) {
        walks.add(WalkList.fromJson(walk));
      }
      print(walks);
      return walks;
    } catch (e) {
      return null;
    }
  }
}
