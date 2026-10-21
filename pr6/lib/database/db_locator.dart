// Picks the right SQLite engine for the platform the app is running on.
//  - Android / iOS : the normal sqflite plugin
//  - Windows / Linux / macOS : sqflite_common_ffi
//  - Web (Chrome) : sqflite_common_ffi_web (needs `dart run sqflite_common_ffi_web:setup` once)
export 'db_locator_stub.dart'
    if (dart.library.io) 'db_locator_io.dart'
    if (dart.library.js_interop) 'db_locator_web.dart';
