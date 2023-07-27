import 'dart:convert';
import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';
import 'package:image_picker/image_picker.dart';
import 'package:nb_utils/nb_utils.dart';
import 'package:uuid/uuid.dart';
import 'package:http/http.dart' as http;

class ImageUploaderProvier extends ChangeNotifier {
  var uuid = Uuid();
  final ImagePicker _picker = ImagePicker();
  String myimage = "kjskdks";
  String? imageUrl;
  String? imagePath;

  List<String> imageFil = [];

  void pickImage() async {
    XFile? _imageFile = await _picker.pickImage(source: ImageSource.gallery);
    _imageFile = await cropImage(_imageFile!);
    if (_imageFile != null) {
      imageFil.add(_imageFile.path);
      imageUpload(_imageFile);
      imagePath = _imageFile.path;
    } else {
      return;
    }
  }

  //ddsd
  Future<XFile?> cropImage(XFile imageFile) async {
    CroppedFile? croppedFile = await ImageCropper.platform.cropImage(
        sourcePath: imageFile.path,
        maxHeight: 800,
        maxWidth: 600,
        compressQuality: 70,
        cropStyle: CropStyle.rectangle,
        aspectRatioPresets: [
          CropAspectRatioPreset.ratio5x4
        ],
        uiSettings: [
          AndroidUiSettings(
              toolbarTitle: "Agriculture cropper",
              toolbarColor: Colors.blueAccent,
              toolbarWidgetColor: Colors.white,
              initAspectRatio: CropAspectRatioPreset.ratio5x4,
              lockAspectRatio: true),
          IOSUiSettings(
            title: "Agriculture cropper",
          )
        ]);

    if (croppedFile != null) {
      notifyListeners();
      return XFile(croppedFile.path);
    } else {
      return null;
    }
  }

  // Future<String?> imageUpload(XFile upload) async {
  //   File image = File(upload.path);

  //   final ref = FirebaseStorage.instance
  //       .ref()
  //       .child("agriApp")
  //       .child("${uuid.v1()}.jpg");

  //   await ref.putFile(image);

  //   imageUrl = (await ref.getDownloadURL());
  //   print(imageUrl);
  //   print("hi");
  //   return imageUrl;
  // }

  //clouinery
  Future<String?> imageUpload(XFile imageFile) async {
    // Replace with your Cloudinary URL
    final cloudinaryUrl =
        'https://api.cloudinary.com/v1_1/diwvk24hf/image/upload';
    // Replace with your Cloudinary upload preset
    final uploadPreset = 'fudn3qwt';

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
      imageUrl = parsedJson['secure_url'];

      print('Image uploaded successfully!');
      print('Image URL: $imageUrl');
      notifyListeners();

      return imageUrl;
    } else {
      print('Image upload failed.');
      return ''; // Return a default value, such as an empty string, when the upload fails.
    }
  }
}
