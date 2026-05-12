import 'dart:io';
import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fruit_hub/core/services/storage_service.dart';

class CloudinaryStorage extends StorageService {
  final String _cloudName = 'dnkpgqa83';
  final String _uploadPreset = 'images';

  @override
  Future<String> uploadImage(String path, String fileName) async {
    final uri = Uri.parse(
      'https://api.cloudinary.com/v1_1/$_cloudName/image/upload',
    );

    final request = http.MultipartRequest('POST', uri);

    request.fields['upload_preset'] = _uploadPreset;

    request.files.add(
      await http.MultipartFile.fromPath('file', path),
    );


    final response = await request.send();


    final responseBody = await response.stream.bytesToString();
    final jsonResponse = jsonDecode(responseBody);


    if (response.statusCode == 200) {
      return jsonResponse['secure_url'];
    }

    throw Exception('فشل الـ Upload: ${jsonResponse['error']['message']}');
  }
}
