import 'dart:io';
import 'package:flutter/material.dart';
import '../models/photo.dart';

class PhotoGridItem extends StatelessWidget {
  final Photo photo;

  PhotoGridItem(this.photo);

  @override
  Widget build(BuildContext context) {
    return Image.file(
      File(photo.thumbnailPath),
      fit: BoxFit.cover,
    );
  }
}