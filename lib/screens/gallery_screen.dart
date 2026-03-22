import 'dart:io';
import 'package:flutter/material.dart';
import '../repositories/photo_repository.dart';
import '../models/photo.dart';
import 'photo_detail_screen.dart';

class GalleryScreen extends StatefulWidget {
  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen> {
  final repo = PhotoRepository();
  List<Photo> photos = [];

  @override
  void initState() {
    super.initState();
    loadPhotos();
  }

  void loadPhotos() async {
    final data = await repo.getAll();
    setState(() => photos = data);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Gallery')),
      body: GridView.builder(
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 3,
        ),
        itemCount: photos.length,
        itemBuilder: (_, i) {
          final photo = photos[i];

          return GestureDetector(
            onTap: () => Navigator.push(
              context,
              MaterialPageRoute(
                builder: (_) => PhotoDetailScreen(photo),
              ),
            ),
            child: Image.file(
              File(photo.thumbnailPath),
              fit: BoxFit.cover,
            ),
          );
        },
      ),
    );
  }
}