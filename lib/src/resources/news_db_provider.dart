import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import '../models/item_model.dart';
import 'cache_source.dart';

class NewsDbProvider implements CacheSource {
  Database db;

  static const _ITEMS_TABLE = 'Items';

  static const _ID_COLUMN = 'id';
  static const _TYPE_COLUMN = 'type';
  static const _BY_COLUMN = 'by';
  static const _TIME_COLUMN = 'time';
  static const _TEXT_COLUMN = 'text';
  static const _PARENT_COLUMN = 'parent';
  static const _KIDS_COLUMN = 'kids';
  static const _DEAD_COLUMN = 'dead';
  static const _DELETED_COLUMN = 'deleted';
  static const _URL_COLUMN = 'url';
  static const _SCORE_COLUMN = 'score';
  static const _TITLE_COLUMN = 'title';
  static const _DESCENDANTS_COLUMN = 'descendants';

  NewsDbProvider() {
    init();
  }

  init() async {
    try {
      Directory documentsDirectory = await getApplicationDocumentsDirectory();
      final path = join(documentsDirectory.path, 'items.db');

      db = await openDatabase(
        path,
        version: 1,
        onCreate: (newDb, version) {
          newDb.execute('''
          CREATE TABLE $_ITEMS_TABLE
            (
              $_ID_COLUMN INTEGER PRIMARY KEY,
              $_TYPE_COLUMN TEXT,
              $_BY_COLUMN TEXT,
              $_TIME_COLUMN INTEGER,
              $_TEXT_COLUMN TEXT,
              $_PARENT_COLUMN INTEGER,
              $_KIDS_COLUMN BLOB,
              $_DEAD_COLUMN INTEGER,
              $_DELETED_COLUMN INTEGER,
              $_URL_COLUMN TEXT,
              $_SCORE_COLUMN INTEGER,
              $_TITLE_COLUMN TEXT,
              $_DESCENDANTS_COLUMN INTEGER
            )
        ''');
        },
      );
    } catch (e) {
      print(e);
    }
  }

  @override
  Future<ItemModel> fetchItem(int id) async {
    try {
      final maps = await db.query(
        _ITEMS_TABLE,
        where: '$_ID_COLUMN = ?',
        whereArgs: [id],
      );
      if (maps.length > 0) {
        return ItemModel.fromDb(maps[0]);
      }
    } catch (e) {
      print(e);
    }

    return null;
  }

  @override
  Future<int> addItem(ItemModel item) {
    try {
      return db.insert(_ITEMS_TABLE, item.toMapForDb());
    } catch (e) {
      print(e);
    }

    return null;
  }

  @override
  Future<List<int>> fetchTopIds() {
    // TODO: implement fetchTopIds
    return null;
  }

  Future<int> clear() {
    return db.delete(_ITEMS_TABLE);
  }
}

final newsDbProvider = NewsDbProvider();
