import 'package:http/http.dart' as http;
import 'dart:convert';
import 'dart:io';

class ApiService {
  static const String baseUrl = "http://10.0.2.2:8000/api/images"; // Replace with your server URL

  static Future<bool> uploadImage(File image, String comment) async {
    var request = http.MultipartRequest('POST', Uri.parse('$baseUrl/upload'));
    request.files.add(await http.MultipartFile.fromPath('image', image.path));
    request.fields['comment'] = comment;

    try {
      var response = await request.send().timeout(Duration(seconds: 30)); // Increase timeout
      if (response.statusCode == 201) {
        return true;
      } else {
        return false;
      }
    } catch (e) {
      print("Error uploading image: $e");
      return false;
    }
  }

  static Future<List<Map<String, dynamic>>> fetchImages() async {
    var response = await http.get(Uri.parse('$baseUrl/images'));
    if (response.statusCode == 200) {
      return List<Map<String, dynamic>>.from(json.decode(response.body));
    }
    return [];
  }
}