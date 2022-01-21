// ignore_for_file: unused_local_variable

import 'dart:async';

import 'dart:io';
import 'package:cloudinary_public/cloudinary_public.dart';

import 'package:http/http.dart' as http;
import 'package:walkistry_flutter/src/models/user_model.dart';
import 'dart:developer' as developer;

class UpdateService {
  UpdateService();
  final String _rootUrl =
      'https://us-central1-walkistry.cloudfunctions.net/api/users';

  Future<String> postUser(User user, String id) async {
    try {
      var url = Uri.parse(_rootUrl + '/' + id);
      final Map<String, String> _headers = {"content-type": "application/json"};
      String _userBody = UserToJson(user);
      developer.log('Calling to POST');
      print("Trying to post user");
      developer.log("user body: " + _userBody, name: "UpdateService");
      final response = await http.post(url, headers: _headers, body: _userBody);

      return _userBody;
    } catch (e) {
      return 'Error';
    }
  }

  Future<String> uploadImage(File image) async {
    developer.log("Uploading image");
    final cloudinary = CloudinaryPublic('dmx1v3oeu', 'hsvfa23f', cache: false);
    try {
      CloudinaryResponse response = await cloudinary.uploadFile(
        CloudinaryFile.fromFile(image.path,
            resourceType: CloudinaryResourceType.Image),
      );
      developer.log(response.secureUrl);
      return response.secureUrl;
    } on CloudinaryException catch (e) {
      developer.log(e.toString(), name: "UpdateService");
      return '';
    }
  }
}
