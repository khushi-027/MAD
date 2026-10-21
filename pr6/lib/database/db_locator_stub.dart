import 'package:sqflite_common/sqlite_api.dart';

/// Fallback used only when no platform implementation is available.
Future<({DatabaseFactory factory, String path})> locateDatabase(
  String fileName,
) {
  throw UnsupportedError('SQLite is not supported on this platform.');
}
