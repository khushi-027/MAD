import 'dart:io';

import 'package:path/path.dart' as p;
import 'package:path_provider/path_provider.dart';
import 'package:sqflite/sqflite.dart' as mobile;
import 'package:sqflite_common/sqlite_api.dart';
import 'package:sqflite_common_ffi/sqflite_ffi.dart' as ffi;

/// Android, iOS and desktop implementation.
Future<({DatabaseFactory factory, String path})> locateDatabase(
  String fileName,
) async {
  if (Platform.isWindows || Platform.isLinux || Platform.isMacOS) {
    ffi.sqfliteFfiInit();
    final dir = await getApplicationSupportDirectory();
    return (factory: ffi.databaseFactoryFfi, path: p.join(dir.path, fileName));
  }
  final dbDir = await mobile.getDatabasesPath();
  return (factory: mobile.databaseFactory, path: p.join(dbDir, fileName));
}
