import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';

class PhotoDatabase {
  static final PhotoDatabase instance = PhotoDatabase._init();
  static Database? _database;

  PhotoDatabase._init();

  Future<Database> get database async {
    if (_database != null) return _database!;
    _database = await _initDB('photos.db');
    return _database!;
  }

  Future<Database> _initDB(String filePath) async {
    final dbPath = await getDatabasesPath();
    final path = join(dbPath, filePath);

    return await openDatabase(path, version: 1, onCreate: _createDB);
  }

  Future _createDB(Database db, int version) async {
    await db.execute('''
      CREATE TABLE photos (
        id INTEGER PRIMARY KEY AUTOINCREMENT,
        filePath TEXT,
        thumbnailPath TEXT,
        title TEXT,
        takenAt TEXT,
        width INTEGER,
        height INTEGER,
        fileSize INTEGER,
        tags TEXT
      )
    ''');
  }
}