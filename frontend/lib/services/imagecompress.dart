import 'dart:typed_data';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:image/image.dart' as img;
Future<Uint8List> upscaleAssetImage(String assetPath) async {
  final ByteData data = await rootBundle.load(assetPath);
  final Uint8List originalBytes = data.buffer.asUint8List();

  img.Image image = img.decodeImage(originalBytes)!;

  int newWidth = 1200;
  int newHeight = 1280;

  img.Image resizedImage = img.copyResize(image, width: newWidth, height: newHeight);

  List<int> resizedBytes = img.encodePng(resizedImage);

  return Uint8List.fromList(resizedBytes);
}


Future<Uint8List?> upscaleAssetImagetest(String url) async {
  Uint8List? result = await upscaleAssetImage(url);

  if (result != null) {
    print("ok");

  } else {
    print("error");
  }
  return result;
}