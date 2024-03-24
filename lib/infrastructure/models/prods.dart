import '../DB/db.dart';

class Prod {
  final int id;
  final String name;
  final int stock;

  Prod({
    required this.id,
    required this.name,
    required this.stock,
  });

  Map<String, Object?> toMap() {
    return {
      'id': id,
      'name': name,
      'stock': stock
    };
  }

  @override
  String toString() {
    return 'Prod{id: $id, name: $name, stock: $stock}';
  }
}

// A method that retrieves all the dogs from the dogs table.
  Future<List<Prod>> products() async {
    // Get a reference to the database.

    final db = await initilizeDB();

    // Query the table for all the dogs.
    final List<Map<String, Object?>> prodMaps = await db.query('Prods');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {
            'id': id as int,
            'name': name as String,
            'stock': stock as int,
          } in prodMaps)
        Prod(id: id, name: name, stock: stock),
    ];
  }