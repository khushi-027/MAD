import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi_web/sqflite_ffi_web.dart';

/// Web implementation (SQLite compiled to WebAssembly, stored in IndexedDB).
Future<({DatabaseFactory factory, String path})> locateDatabase(
  String fileName,
) async {
  return (factory: databaseFactoryFfiWeb, path: fileName);
}
