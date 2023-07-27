import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;

class ImageUploader {
  static Future<String> uploadImageToCloudinary(File imageFile) async {
    // Replace with your Cloudinary URL
    final cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/diwvk24hf/image/upload';
    // Replace with your Cloudinary upload preset
    final uploadPreset = 'ghj6vea7';

    final request = http.MultipartRequest('POST', Uri.parse(cloudinaryUrl));
    request.fields['upload_preset'] = uploadPreset;

    final fileStream = http.ByteStream(imageFile.openRead());
    final fileSize = await imageFile.length();

    final multipartFile = http.MultipartFile(
      'file',
      fileStream,
      fileSize,
      filename: imageFile.path.split('/').last,
    );

    request.files.add(multipartFile);

    final response = await request.send();

    if (response.statusCode == 200) {
      final responseBody = await response.stream.bytesToString();
      final parsedJson = json.decode(responseBody);
      final imageUrl = parsedJson['secure_url'];

      print('Image uploaded successfully!');
      print('Image URL: $imageUrl');

      return imageUrl;
    } else {
      print('Image upload failed.');
      return ''; // Return a default value, such as an empty string, when the upload fails.
    }
  }
}
