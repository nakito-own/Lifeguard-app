import 'dart:convert';
//import 'dart:io';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:http/http.dart' as http;
import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'api_keys.dart';

class ImageService {
  final String apiUrl = 'http://${API_URL}:${API_PORT}';

  Future<Image> fetchImage(String imageType, String name) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');
    if (token == null) {
      throw Exception('Token is null');
    }

    final String cacheKey = '$imageType$name';

    String? cachedImage = prefs.getString(cacheKey);
    if (cachedImage != null) {
      Uint8List imageData = base64Decode(cachedImage);
      return Image.memory(imageData);
    } else {
      final url = Uri.parse('$apiUrl/image/$imageType/$name');
      final response = await http.get(url, headers: {'JWT': token});

      if (response.statusCode == 200) {
        Uint8List imageData = response.bodyBytes;
        String base64Image = base64Encode(imageData);
        await prefs.setString(cacheKey, base64Image);

        return Image.memory(imageData);
      } else {
        throw Exception('Failed to load image: ${response.statusCode}');
      }
    }
  }

  Future<void> uploadImage(Uint8List imageData, String imageType, String id) async {
    final prefs = await SharedPreferences.getInstance();
    final String? token = prefs.getString('jwt');
    if (token == null) {
      throw Exception('Token is null');
    }

    final url = Uri.parse('$apiUrl/image/$imageType/$id');

    var request = http.MultipartRequest('POST', url);
    request.headers['JWT'] = token;

    request.files.add(http.MultipartFile.fromBytes(
      'file',
      imageData,
      filename: 'avatar.bin',
    ));

    final response = await request.send();

    if (response.statusCode == 200) {
      print('Image uploading is done');
    } else {
      throw Exception('Failed to upload Image (Problem on server side) ${response.statusCode}');
    }
  }
}
