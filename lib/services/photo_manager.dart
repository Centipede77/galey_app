import 'dart:io';
import 'package:image/image.dart' as img;
import 'package:path_provider/path_provider.dart';
import '../models/photo.dart';

class PhotoManager {

  Future<String> get _photosDirectory async {
    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/photos');
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    return folder.path;
  }

  Future<String> get _thumbnailsDirectory async {
    final dir = await getApplicationDocumentsDirectory();
    final folder = Directory('${dir.path}/thumbnails');
    if (!await folder.exists()) {
      await folder.create(recursive: true);
    }
    return folder.path;
  }

  Future<Photo?> savePhoto(File file, String title, List<String> tags) async {
    final bytes = await file.readAsBytes();
    final image = img.decodeImage(bytes);
    if (image == null) return null;

    final fileName = 'photo_${DateTime.now().millisecondsSinceEpoch}.jpg';

    final photoPath = '${await _photosDirectory}/$fileName';
    await File(photoPath).writeAsBytes(bytes);

    final thumb = img.copyResize(image, width: 200);
    final thumbPath = '${await _thumbnailsDirectory}/thumb_$fileName';
    await File(thumbPath).writeAsBytes(img.encodeJpg(thumb));

    return Photo(
      filePath: photoPath,
      thumbnailPath: thumbPath,
      title: title,
      takenAt: DateTime.now(),
      width: image.width,
      height: image.height,
      fileSize: bytes.length,
      tags: tags,
    );
  }

  Future<void> deletePhoto(Photo photo) async {
    await File(photo.filePath).delete();
    await File(photo.thumbnailPath).delete();
  }
}