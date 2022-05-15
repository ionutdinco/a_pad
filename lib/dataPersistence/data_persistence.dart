import 'dart:io';
import 'dart:async';
import 'package:drift/drift.dart';
import 'package:drift/native.dart';
import 'package:path_provider/path_provider.dart';
import 'package:path/path.dart';
part 'data_persistence.g.dart';

@DriftDatabase(
  // relative import for the drift file. Drift also supports `package:`
  // imports
  include: {'tables.drift'},
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 1;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'db.sqlite'));
    return NativeDatabase(file);
  });
}

class DatabaseHelper extends AppDb {
  // loads all todo entries

  static final DatabaseHelper _singleton = DatabaseHelper._internal();

  factory DatabaseHelper() {
    return _singleton;
  }

  DatabaseHelper._internal();

  Future<List<Note>> get allNoteEntries => select(notes).get();

  Future<List<Note>> watchEntriesInCategory(String category) {
    return (select(notes)..where((t) => t.category.equals(category))).get();
  }

  Future<Note> getEntryById(int id) {
    return (select(notes)..where((t) => t.id.equals(id))).getSingle();
  }

  Future updateNote(Note entry) {
    return update(notes).replace(entry);
  }

  Future deleteNote(int id) {
    return (delete(notes)..where((t) => t.id.equals(id))).go();
  }

  Future deleteAllNotes() {
    return delete(notes).go();
  }

  Future<int> addNote(NotesCompanion entry) {
    return into(notes).insert(entry);
  }
}

class DatabaseProvider {
  static final DatabaseProvider _singleton = DatabaseProvider._internal();

  factory DatabaseProvider() {
    return _singleton;
  }

  DatabaseProvider._internal();
}
