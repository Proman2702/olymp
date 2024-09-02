class TilePlayer {
  final String name;
  final String file;
  final int result;

  TilePlayer({required this.name, required this.file, required this.result});

  Map<String, Object?> toMap() {
    return {
      'name': name,
      'file': file,
      'result': result,
    };
  }

  // Implement toString to make it easier to see information about
  // each dog when using the print statement.
  @override
  String toString() {
    return 'Tile{name: $name, file: $file, result: $result}';
  }
}
