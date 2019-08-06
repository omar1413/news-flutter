import 'package:sqflite/sqflite.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';
import 'dart:io';
import 'dart:async';
import '../models/item_model.dart';

class NewsDbProvider {
  Database db;

  static const _TABLE_NAME = 'Items';

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

  init() async {
    Directory documentsDirectory = await getApplicationDocumentsDirectory();
    final path = join(documentsDirectory.path, 'items.db');

    db = await openDatabase(
      path,
      version: 1,
      onCreate: (newDb, version) {
        newDb.execute('''
          CRAETE TABLE $_TABLE_NAME
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
  }

  Future<ItemModel> fetchItem(int id) async {
    final maps = await db.query(
      _TABLE_NAME,
      where: '$_ID_COLUMN = ?',
      whereArgs: [id],
    );

    if (maps.length > 0) {
      return ItemModel.fromDb(maps[0]);
    }

    return null;
  }

  Future<int> addItem(ItemModel item) {
    return db.insert(_TABLE_NAME, item.toMapForDb());
  }
}
