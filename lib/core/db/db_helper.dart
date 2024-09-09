import 'package:comic_vine_app/core/contracts/i_db_helper.dart';
import 'package:comic_vine_app/features/comic_vine/data/models/comic_model.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DBHelper implements IDBHelper {
  static Database? _database;

  static const String tableName = 'comics';

  /// Initialize and open the database
  @override
  Future<void> initDB() async {
    if (_database != null) {
      return;
    }

    _database = await openDatabase(
      join(await getDatabasesPath(), 'comics_database.db'),
      onCreate: (db, version) {
        return db.execute('''
          CREATE TABLE $tableName (
            id INTEGER PRIMARY KEY,
            name TEXT,
            issueNumber TEXT,
            coverDate TEXT,
            description TEXT,
            imageUrl TEXT,
            volumeId INTEGER,
            volumeName TEXT,
            creators TEXT,
            characters TEXT,
            teams TEXT,
            locations TEXT,
            concepts TEXT
          )
        ''');
      },
      version: 1,
    );
  }

  /// Insert a comic into the database
  @override
  Future<void> insertComic(ComicModel comic) async {
    final db = _database;
    await db?.insert(tableName, comic.toMap(), conflictAlgorithm: ConflictAlgorithm.replace);
  }

  /// Retrieve a comic by ID
  @override
  Future<ComicModel?> getComic(int id) async {
    final db = _database;
    final maps = await db?.query(tableName, where: 'id = ?', whereArgs: [id]);
    if (maps!.isNotEmpty) {
      return ComicModel.fromMap(maps.first);
    }
    return null;
  }

  /// Get all comics
  @override
  Future<List<ComicModel>> getAllComics() async {
    final db = _database;
    final List<Map<String, dynamic>> maps = await db!.query(tableName);
    return List.generate(maps.length, (i) {
      return ComicModel.fromMap(maps[i]);
    });
  }
}
