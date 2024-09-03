import 'package:my_app/repositories/models/tile_player.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class DataHandler {
  Future<Database> openDB() async {
    return openDatabase(
      join(await getDatabasesPath(), 'tiles.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE tiles(name TEXT, file TEXT, result INTEGER)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertTile(TilePlayer tile) async {
    // Get a reference to the database.
    final db = await openDB();

    // Insert the Dog into the correct table. You might also specify the
    // `conflictAlgorithm` to use in case the same dog is inserted twice.
    //
    // In this case, replace any previous data.
    await db.insert(
      'tiles',
      tile.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  Future<List<TilePlayer>> getTiles() async {
    // Get a reference to the database.
    final db = await openDB();

    // Query the table for all the dogs.
    final List<Map<String, Object?>> tileMaps = await db.query('tiles');

    // Convert the list of each dog's fields into a list of `Dog` objects.
    return [
      for (final {
            'name': name as String,
            'file': file as String,
            'result': result as int,
          } in tileMaps)
        TilePlayer(name: name, file: file, result: result),
    ];
  }

  Future<void> deleteTile(String name) async {
    // Get a reference to the database.
    final db = await openDB();

    // Remove the Dog from the database.
    await db.delete(
      'tiles',
      // Use a `where` clause to delete a specific dog.
      where: 'name = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [name],
    );
  }
}
