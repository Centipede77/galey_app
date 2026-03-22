import 'dart:io';
import 'package:flutter/material.dart';
import '../models/photo.dart';

class PhotoDetailScreen extends StatelessWidget {
  final Photo photo;

  PhotoDetailScreen(this.photo);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(photo.title)),
      body: Column(
        children: [
          Expanded(
            child: Image.file(File(photo.filePath)),
          ),
          Text('Tags: ${photo.tags.join(", ")}'),
          Text('Size: ${photo.fileSize} bytes'),
        ],
      ),
    );
  }
}