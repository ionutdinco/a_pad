// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'data_persistence.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: type=lint
class NotesDData extends DataClass implements Insertable<NotesDData> {
  final int id;
  final String? title;
  final String? content;
  final int? lastUpdate;
  final String? category;
  NotesDData(
      {required this.id,
      this.title,
      this.content,
      this.lastUpdate,
      this.category});
  factory NotesDData.fromData(Map<String, dynamic> data, {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return NotesDData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      title: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}title']),
      content: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}content']),
      lastUpdate: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}lastUpdate']),
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || title != null) {
      map['title'] = Variable<String?>(title);
    }
    if (!nullToAbsent || content != null) {
      map['content'] = Variable<String?>(content);
    }
    if (!nullToAbsent || lastUpdate != null) {
      map['lastUpdate'] = Variable<int?>(lastUpdate);
    }
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String?>(category);
    }
    return map;
  }

  NotesDCompanion toCompanion(bool nullToAbsent) {
    return NotesDCompanion(
      id: Value(id),
      title:
          title == null && nullToAbsent ? const Value.absent() : Value(title),
      content: content == null && nullToAbsent
          ? const Value.absent()
          : Value(content),
      lastUpdate: lastUpdate == null && nullToAbsent
          ? const Value.absent()
          : Value(lastUpdate),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory NotesDData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return NotesDData(
      id: serializer.fromJson<int>(json['id']),
      title: serializer.fromJson<String?>(json['title']),
      content: serializer.fromJson<String?>(json['content']),
      lastUpdate: serializer.fromJson<int?>(json['lastUpdate']),
      category: serializer.fromJson<String?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'title': serializer.toJson<String?>(title),
      'content': serializer.toJson<String?>(content),
      'lastUpdate': serializer.toJson<int?>(lastUpdate),
      'category': serializer.toJson<String?>(category),
    };
  }

  NotesDData copyWith(
          {int? id,
          String? title,
          String? content,
          int? lastUpdate,
          String? category}) =>
      NotesDData(
        id: id ?? this.id,
        title: title ?? this.title,
        content: content ?? this.content,
        lastUpdate: lastUpdate ?? this.lastUpdate,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('NotesDData(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, title, content, lastUpdate, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is NotesDData &&
          other.id == this.id &&
          other.title == this.title &&
          other.content == this.content &&
          other.lastUpdate == this.lastUpdate &&
          other.category == this.category);
}

class NotesDCompanion extends UpdateCompanion<NotesDData> {
  final Value<int> id;
  final Value<String?> title;
  final Value<String?> content;
  final Value<int?> lastUpdate;
  final Value<String?> category;
  const NotesDCompanion({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.category = const Value.absent(),
  });
  NotesDCompanion.insert({
    this.id = const Value.absent(),
    this.title = const Value.absent(),
    this.content = const Value.absent(),
    this.lastUpdate = const Value.absent(),
    this.category = const Value.absent(),
  });
  static Insertable<NotesDData> custom({
    Expression<int>? id,
    Expression<String?>? title,
    Expression<String?>? content,
    Expression<int?>? lastUpdate,
    Expression<String?>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (title != null) 'title': title,
      if (content != null) 'content': content,
      if (lastUpdate != null) 'lastUpdate': lastUpdate,
      if (category != null) 'category': category,
    });
  }

  NotesDCompanion copyWith(
      {Value<int>? id,
      Value<String?>? title,
      Value<String?>? content,
      Value<int?>? lastUpdate,
      Value<String?>? category}) {
    return NotesDCompanion(
      id: id ?? this.id,
      title: title ?? this.title,
      content: content ?? this.content,
      lastUpdate: lastUpdate ?? this.lastUpdate,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (title.present) {
      map['title'] = Variable<String?>(title.value);
    }
    if (content.present) {
      map['content'] = Variable<String?>(content.value);
    }
    if (lastUpdate.present) {
      map['lastUpdate'] = Variable<int?>(lastUpdate.value);
    }
    if (category.present) {
      map['category'] = Variable<String?>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('NotesDCompanion(')
          ..write('id: $id, ')
          ..write('title: $title, ')
          ..write('content: $content, ')
          ..write('lastUpdate: $lastUpdate, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class NotesD extends Table with TableInfo<NotesD, NotesDData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  NotesD(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _titleMeta = const VerificationMeta('title');
  late final GeneratedColumn<String?> title = GeneratedColumn<String?>(
      'title', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _contentMeta = const VerificationMeta('content');
  late final GeneratedColumn<String?> content = GeneratedColumn<String?>(
      'content', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _lastUpdateMeta = const VerificationMeta('lastUpdate');
  late final GeneratedColumn<int?> lastUpdate = GeneratedColumn<int?>(
      'lastUpdate', aliasedName, true,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumn<String?> category = GeneratedColumn<String?>(
      'category', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns =>
      [id, title, content, lastUpdate, category];
  @override
  String get aliasedName => _alias ?? 'notes_d';
  @override
  String get actualTableName => 'notes_d';
  @override
  VerificationContext validateIntegrity(Insertable<NotesDData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('title')) {
      context.handle(
          _titleMeta, title.isAcceptableOrUnknown(data['title']!, _titleMeta));
    }
    if (data.containsKey('content')) {
      context.handle(_contentMeta,
          content.isAcceptableOrUnknown(data['content']!, _contentMeta));
    }
    if (data.containsKey('lastUpdate')) {
      context.handle(
          _lastUpdateMeta,
          lastUpdate.isAcceptableOrUnknown(
              data['lastUpdate']!, _lastUpdateMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  NotesDData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return NotesDData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  NotesD createAlias(String alias) {
    return NotesD(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

class CategoriesDData extends DataClass implements Insertable<CategoriesDData> {
  final int id;
  final String? category;
  CategoriesDData({required this.id, this.category});
  factory CategoriesDData.fromData(Map<String, dynamic> data,
      {String? prefix}) {
    final effectivePrefix = prefix ?? '';
    return CategoriesDData(
      id: const IntType()
          .mapFromDatabaseResponse(data['${effectivePrefix}id'])!,
      category: const StringType()
          .mapFromDatabaseResponse(data['${effectivePrefix}category']),
    );
  }
  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    map['id'] = Variable<int>(id);
    if (!nullToAbsent || category != null) {
      map['category'] = Variable<String?>(category);
    }
    return map;
  }

  CategoriesDCompanion toCompanion(bool nullToAbsent) {
    return CategoriesDCompanion(
      id: Value(id),
      category: category == null && nullToAbsent
          ? const Value.absent()
          : Value(category),
    );
  }

  factory CategoriesDData.fromJson(Map<String, dynamic> json,
      {ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return CategoriesDData(
      id: serializer.fromJson<int>(json['id']),
      category: serializer.fromJson<String?>(json['category']),
    );
  }
  @override
  Map<String, dynamic> toJson({ValueSerializer? serializer}) {
    serializer ??= driftRuntimeOptions.defaultSerializer;
    return <String, dynamic>{
      'id': serializer.toJson<int>(id),
      'category': serializer.toJson<String?>(category),
    };
  }

  CategoriesDData copyWith({int? id, String? category}) => CategoriesDData(
        id: id ?? this.id,
        category: category ?? this.category,
      );
  @override
  String toString() {
    return (StringBuffer('CategoriesDData(')
          ..write('id: $id, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => Object.hash(id, category);
  @override
  bool operator ==(Object other) =>
      identical(this, other) ||
      (other is CategoriesDData &&
          other.id == this.id &&
          other.category == this.category);
}

class CategoriesDCompanion extends UpdateCompanion<CategoriesDData> {
  final Value<int> id;
  final Value<String?> category;
  const CategoriesDCompanion({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
  });
  CategoriesDCompanion.insert({
    this.id = const Value.absent(),
    this.category = const Value.absent(),
  });
  static Insertable<CategoriesDData> custom({
    Expression<int>? id,
    Expression<String?>? category,
  }) {
    return RawValuesInsertable({
      if (id != null) 'id': id,
      if (category != null) 'category': category,
    });
  }

  CategoriesDCompanion copyWith({Value<int>? id, Value<String?>? category}) {
    return CategoriesDCompanion(
      id: id ?? this.id,
      category: category ?? this.category,
    );
  }

  @override
  Map<String, Expression> toColumns(bool nullToAbsent) {
    final map = <String, Expression>{};
    if (id.present) {
      map['id'] = Variable<int>(id.value);
    }
    if (category.present) {
      map['category'] = Variable<String?>(category.value);
    }
    return map;
  }

  @override
  String toString() {
    return (StringBuffer('CategoriesDCompanion(')
          ..write('id: $id, ')
          ..write('category: $category')
          ..write(')'))
        .toString();
  }
}

class CategoriesD extends Table with TableInfo<CategoriesD, CategoriesDData> {
  @override
  final GeneratedDatabase attachedDatabase;
  final String? _alias;
  CategoriesD(this.attachedDatabase, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  late final GeneratedColumn<int?> id = GeneratedColumn<int?>(
      'id', aliasedName, false,
      type: const IntType(),
      requiredDuringInsert: false,
      $customConstraints: 'NOT NULL PRIMARY KEY AUTOINCREMENT');
  final VerificationMeta _categoryMeta = const VerificationMeta('category');
  late final GeneratedColumn<String?> category = GeneratedColumn<String?>(
      'category', aliasedName, true,
      type: const StringType(),
      requiredDuringInsert: false,
      $customConstraints: '');
  @override
  List<GeneratedColumn> get $columns => [id, category];
  @override
  String get aliasedName => _alias ?? 'categories_d';
  @override
  String get actualTableName => 'categories_d';
  @override
  VerificationContext validateIntegrity(Insertable<CategoriesDData> instance,
      {bool isInserting = false}) {
    final context = VerificationContext();
    final data = instance.toColumns(true);
    if (data.containsKey('id')) {
      context.handle(_idMeta, id.isAcceptableOrUnknown(data['id']!, _idMeta));
    }
    if (data.containsKey('category')) {
      context.handle(_categoryMeta,
          category.isAcceptableOrUnknown(data['category']!, _categoryMeta));
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  CategoriesDData map(Map<String, dynamic> data, {String? tablePrefix}) {
    return CategoriesDData.fromData(data,
        prefix: tablePrefix != null ? '$tablePrefix.' : null);
  }

  @override
  CategoriesD createAlias(String alias) {
    return CategoriesD(attachedDatabase, alias);
  }

  @override
  bool get dontWriteConstraints => true;
}

abstract class _$AppDb extends GeneratedDatabase {
  _$AppDb(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  late final NotesD notesD = NotesD(this);
  late final CategoriesD categoriesD = CategoriesD(this);
  @override
  Iterable<TableInfo> get allTables => allSchemaEntities.whereType<TableInfo>();
  @override
  List<DatabaseSchemaEntity> get allSchemaEntities => [notesD, categoriesD];
}
