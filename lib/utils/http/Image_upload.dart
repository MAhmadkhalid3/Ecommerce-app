import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class CloudinaryHelper {
  static const String _cloudName = "dba5ofqb6";
  static const String _apiKey = "941424785427518";
  static const String _apiSecret = "Stv_ju9wJixoC4rqiCAM-aFuCV0";

  static Future<String> uploadImage(File imageFile) async {
    try {
      final credentials = base64Encode(
        utf8.encode("$_apiKey:$_apiSecret"),
      );

      final uri = Uri.parse(
        "https://api.cloudinary.com/v1_1/$_cloudName/image/upload",
      );

      final request = http.MultipartRequest("POST", uri);
      request.headers["Authorization"] = "Basic $credentials";
      request.files.add(
        await http.MultipartFile.fromPath("file", imageFile.path),
      );

      final streamedResponse = await request.send();
      final responseBody = await streamedResponse.stream.bytesToString();
      final jsonData = json.decode(responseBody);

      if (streamedResponse.statusCode == 200) {
        return jsonData["secure_url"]; // ✅ Yeh URL Firebase mein save karo
      } else {
        throw Exception(jsonData["error"]["message"]);
      }
    } catch (e) {
      throw Exception("Upload fail: $e");
    }
  }
}