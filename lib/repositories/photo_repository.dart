import '../database/photo_database.dart';
import '../models/photo.dart';
import '../services/photo_manager.dart';
import 'package:sqflite/sqflite.dart';

class PhotoRepository {
  final _db = PhotoDatabase.instance;
  final _manager = PhotoManager();

  Future<int> insert(Photo photo) async {
    final db = await _db.database;
    return db.insert('photos', photo.toMap());
  }

  Future<List<Photo>> getAll({int? limit, int? offset}) async {
    final db = await _db.database;
    final maps = await db.query(
      'photos',
      orderBy: 'takenAt DESC',
      limit: limit,
      offset: offset,
    );

    return maps.map((e) => Photo.fromMap(e)).toList();
  }

  Future<List<Photo>> searchByTags(String tag) async {
    final db = await _db.database;

    final maps = await db.query(
      'photos',
      where: 'tags LIKE ?',
      whereArgs: ['%$tag%'],
    );

    return maps.map((e) => Photo.fromMap(e)).toList();
  }

  Future<void> delete(Photo photo) async {
    final db = await _db.database;

    await _manager.deletePhoto(photo);

    await db.delete(
      'photos',
      where: 'id = ?',
      whereArgs: [photo.id],
    );
  }

  Future<Map<String, dynamic>> getStats() async {
    final db = await _db.database;

    final count = Sqflite.firstIntValue(
      await db.rawQuery('SELECT COUNT(*) FROM photos'),
    ) ?? 0;

    final size = (await db.rawQuery(
      'SELECT SUM(fileSize) FROM photos',
    )).first.values.first ?? 0;

    return {
      'count': count,
      'size': size,
    };
  }
}