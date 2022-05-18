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
  include: {'db.drift'},
)
class AppDb extends _$AppDb {
  AppDb() : super(_openConnection());

  @override
  int get schemaVersion => 12;
}

LazyDatabase _openConnection() {
  // the LazyDatabase util lets us find the right location for the file async.
  return LazyDatabase(() async {
    // put the database file, called db.sqlite here, into the documents folder
    // for your app.
    final dbFolder = await getApplicationDocumentsDirectory();
    final file = File(join(dbFolder.path, 'newdb.sqlite'));
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

  Future<List<NotesDData>> get allNoteEntries => select(notesD).get();

  Future<List<CategoriesDData>> get allCategoryEntries =>
      select(categoriesD).get();

  Future<List<NotesDData>> watchEntriesInCategory(String category) {
    return (select(notesD)..where((t) => t.category.equals(category))).get();
  }

  Future<NotesDData> getEntryById(int id) {
    return (select(notesD)..where((t) => t.id.equals(id))).getSingle();
  }

  Future<CategoriesDData?> getCategByCat(String cat) {
    return (select(categoriesD)..where((t) => t.category.equals(cat)))
        .getSingleOrNull();
  }

  Future updateNote(NotesDData entry) {
    return update(notesD).replace(entry);
  }

  Future updateCategory(CategoriesDData entry) {
    return update(categoriesD).replace(entry);
  }

  Future deleteNote(int id) {
    return (delete(notesD)..where((t) => t.id.equals(id))).go();
  }

  Future deleteCategory(int id) {
    return (delete(categoriesD)..where((t) => t.id.equals(id))).go();
  }

  Future deleteAllNotes() {
    return delete(notesD).go();
  }

  Future<int> addNote(NotesDCompanion entry) {
    return into(notesD).insert(entry);
  }

  Future<int> addCategory(CategoriesDCompanion entry) {
    return into(categoriesD).insert(entry);
  }
}
