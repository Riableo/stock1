import "package:sqflite_common_ffi/sqflite_ffi.dart";
import "package:stock1/infrastructure/DB/db.dart";
import "../../models/prods.dart";


Future<void> insertProd(Prod prod) async {

  final db = await initilizeDB();

  await db.insert(
    'Prods',
    prod.toMap(),
    conflictAlgorithm: ConflictAlgorithm.replace, 
  );

  await db.close();
}

Future<void> updateProd(Prod prod) async {
  // Get a reference to the database.
  final db = await initilizeDB();

  // Update the given Dog.
  await db.update(
    'Prods',
    prod.toMap(),
    // Ensure that the Dog has a matching id.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [prod.id],
  );

  await db.close();
}

Future<void> deleteProd(int id) async {
  // Get a reference to the database.
  final db = await initilizeDB();

  // Remove the Dog from the database.
  await db.delete(
    'Prods',
    // Use a `where` clause to delete a specific dog.
    where: 'id = ?',
    // Pass the Dog's id as a whereArg to prevent SQL injection.
    whereArgs: [id],
  );

  await db.close();
}