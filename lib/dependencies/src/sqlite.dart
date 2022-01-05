// import 'dart:io';
//
// import 'package:path/path.dart';
// import 'package:universally/universally.dart';
//
// bool _supportPlatform = isMobile || isMacOS;
//
// class SqliteUtils {
//   late String _dbPath;
//   Database? _db;
//
//   /// 初始化 db 创建db
//   /// Initialize the DB. Create a DB
//   Future<String?> initDateBase() async {
//     if (!_supportPlatform) return null;
//     final String databasePath = await getDatabasesPath();
//     if (!Directory(dirname(databasePath)).existsSync()) {
//       await Directory(dirname(databasePath)).create(recursive: true);
//     }
//     final dbPath = join(databasePath, 'dataCache.db');
//     final file = File(dbPath);
//     if (!file.existsSync()) file.createSync(recursive: true);
//     _dbPath = dbPath;
//     log('Creating a database file path = $_dbPath');
//     return dbPath;
//   }
//
//   /// 打开数据库
//   /// Open the database
//   Future<Database?> openDB() async {
//     if (!_supportPlatform) return null;
//     if (_db == null || !_db!.isOpen) {
//       log('Open the cached database');
//       _db = await openDatabase(_dbPath);
//     }
//     return _db!;
//   }
//
//   /// 关闭数据库
//   /// Closing the database
//   Future<void> close() async {
//     if (!_supportPlatform) return;
//     if (_db != null && _db!.isOpen) {
//       log('Closing the cached database');
//       await _db?.close();
//     }
//   }
//
//   /// 指定表里添加数据
//   /// Specifies to add data to a table
//   Future<int> insert(String table, Map<String, Object?> values,
//       {String? nullColumnHack, ConflictAlgorithm? conflictAlgorithm}) async {
//     if (!_supportPlatform) return 0;
//     await openDB();
//     final int? count = await _db?.insert(table, values,
//         nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm);
//     log('Add $count entry to the $table table');
//     return count ?? 0;
//   }
//
//   /// 指定表里更新数据 如果表里没有数据可以更新 直接插入当前数据
//   /// Insert current data into table if there is no data in table
//   /// [updateValue] 需要更新的数据
//   /// [updateValue] Data to be updated
//   /// [where] 符合条件的数据的字段
//   /// [where] Fields of eligible data
//   /// [whereArgs] 符合条件的数据的字段内容
//   /// [whereArgs] The field content of the eligible data
//   Future<int> update(String table, Map<String, Object?> updateValue,
//       {String? where,
//       List<Object>? whereArgs,
//       bool updateFailedInsert = true,
//       ConflictAlgorithm? conflictAlgorithm,
//       String? nullColumnHack}) async {
//     if (!_supportPlatform) return 0;
//     await openDB();
//     int? count = await _db?.update(table, updateValue,
//         where: where == null ? null : where + ' = ?',
//         whereArgs: whereArgs,
//         conflictAlgorithm: conflictAlgorithm);
//     if (count == 0 && updateFailedInsert) {
//       count = await insert(table, updateValue,
//           nullColumnHack: nullColumnHack, conflictAlgorithm: conflictAlgorithm);
//     } else {
//       log('Update $count entries in $table table');
//     }
//     return count ?? 0;
//   }
//
//   /// 指定表里删除数据
//   /// Delete data from table
//   /// [where] 表中字段名
//   /// [where] The name of the field in the table
//   /// [whereArgs] 符合 字段[whereArgs]条件
//   /// [whereArgs] Matches field [whereArgs] conditions
//   Future<int> delete(String table,
//       [String? where, List<Object>? whereArgs]) async {
//     await openDB();
//     final int? count = await _db?.delete(table,
//         where: where == null ? null : where + ' = ?', whereArgs: whereArgs);
//     log('Delete $count pieces of data in the $table table');
//     return count ?? 0;
//   }
//
//   /// 指定表查询数据
//   /// Specifies the table to query for data
//   /// [keys] 需要查询的字段名
//   /// [keys] Name of the field to be queried
//   Future<List<Map<String, Object?>>> query(String table, List<String> keys,
//       {bool? distinct,
//       String? where,
//       List<Object>? whereArgs,
//       String? groupBy,
//       String? having,
//       String? orderBy,
//       int? limit,
//       int? offset}) async {
//     if (!_supportPlatform) return [];
//     await openDB();
//     final List<Map<String, Object?>>? data = await _db?.query(table,
//         columns: keys,
//         distinct: distinct,
//         where: where == null ? null : where + ' = ?',
//         whereArgs: whereArgs,
//         groupBy: groupBy,
//         having: having,
//         orderBy: orderBy,
//         limit: limit,
//         offset: offset);
//     log('Select ${data?.length ?? 0} from $table');
//     return data ?? [];
//   }
//
//   /// 查询是否有某个表
//   /// Query whether a table exists
//   Future<bool> hasTable(String tableName) async {
//     if (!_supportPlatform) return false;
//     await openDB();
//     final List<Map<String, dynamic>>? tableMaps = await _db
//         ?.rawQuery('SELECT name FROM sqlite_master WHERE type = "table"');
//     bool has = false;
//     tableMaps?.forEach((element) {
//       if (tableName == element['name']) has = true;
//     });
//     return has;
//   }
//
//   /// 创建表
//   /// Create a table
//   /// [tableName] 表名字
//   /// [tableName] The table name
//   /// [key] 字段名以及类型
//   /// [key] Field name and type
//   Future<void> createTable(List<String> tableNames, String? key) async {
//     if (!_supportPlatform) return;
//     close();
//     _db = await openDatabase(_dbPath,
//         version: 1, onCreate: (Database db, int? version) async {},
//         onOpen: (Database db) async {
//       tableNames.builder((name) async {
//         if (!await hasTable(name)) {
//           await db.execute('''
//             CREATE TABLE IF NOT EXISTS $name (
//             id INTEGER NOT NULL PRIMARY KEY AUTOINCREMENT UNIQUE, $key);
//             ''');
//         }
//       });
//     });
//     log('Initialize the table：$tableNames ');
//   }
// }
