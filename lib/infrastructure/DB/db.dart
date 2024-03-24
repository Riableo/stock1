import "package:path/path.dart";
import "package:sqflite_common_ffi/sqflite_ffi.dart";

Future<Database> initilizeDB() async {

  String path = await getDatabasesPath();

  return openDatabase(
    join(path, 'mall.db'),
    onCreate: (db, version) async {
      await db.execute(
        'CREATE TABLE Prods(id INTEGER PRIMARY KEY, name TEXT, stock INTEGER)'
      );
    },
    version: 1,
  );
}