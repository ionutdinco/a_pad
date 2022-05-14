import 'dart:async';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Note {
  final int id;
  final String title;
  final String content;
  final String lastUpdate;
  static const String tablename = "notes";

  const Note(
      {required this.id,
      required this.title,
      required this.content,
      required this.lastUpdate});
  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'content': content,
      'modified': lastUpdate
    };
  }

  @override
  String toString() {
    return toMap.toString();
  }
}

class DatabaseHelper {
  // ignore: prefer_typing_uninitialized_variables
  var database;

  initializeDatabase() async {
    database = openDatabase(
      join(await getDatabasesPath(), 'doggie_database.db'),
      onCreate: (db, version) {
        return db.execute(
          'CREATE TABLE notes(id INTEGER PRIMARY KEY, title TEXT, content TEXT, lastUpdate DATA)',
        );
      },
      version: 1,
    );
  }

  Future<void> insertDog(Note note) async {
    final db = await database;

    await db.insert(
      'notes',
      note.toMap(),
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  // A method that retrieves all the dogs from the notes table.
  Future<List<Note>> notes() async {
    final db = await database;

    // Query the table for all The notes.
    final List<Map<String, dynamic>> maps = await db.query('notes');

    // Convert the List<Map<String, dynamic> into a List<Note>.
    return List.generate(maps.length, (i) {
      return Note(
        id: maps[i]['id'],
        title: maps[i]['title'],
        content: maps[i]['content'],
        lastUpdate: maps[i]['lastUpdate'],
      );
    });
  }

  Future<void> updateNote(Note note) async {
    // Get a reference to the database.
    final db = await database;

    await db.update(
      'notes',
      note.toMap(),
      // Ensure that the Dog has a matching id.
      where: 'id = ?',
      // Pass the Note's id as a whereArg to prevent SQL injection.
      whereArgs: [note.id],
    );
  }

  Future<void> deleteNote(int id) async {
    // Get a reference to the database.
    final db = await database;

    // Remove the Dog from the database.
    await db.delete(
      'notes',
      // Use a `where` clause to delete a specific dog.
      where: 'id = ?',
      // Pass the Dog's id as a whereArg to prevent SQL injection.
      whereArgs: [id],
    );
  }
}
