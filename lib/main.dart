import 'package:flutter/material.dart';
import 'screens/gallery_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Photo Gallery',
      theme: ThemeData.dark(),
      home: GalleryScreen(),
    );
  }
}