// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'moor_database.dart';

// **************************************************************************
// MoorGenerator
// **************************************************************************

// ignore_for_file: unnecessary_brace_in_string_interps, unnecessary_this
class RemindersTableData extends DataClass
    implements Insertable<RemindersTableData> {
  final int id;
  final String name;
  final String image;
  final String dose;
  RemindersTableData(
      {this.id,
      @required this.name,
      @required this.image,
      @required this.dose});
  factory RemindersTableData.fromData(
      Map<String, dynamic> data, GeneratedDatabase db,
      {String prefix}) {
    final effectivePrefix = prefix ?? '';
    final intType = db.typeSystem.forDartType<int>();
    final stringType = db.typeSystem.forDartType<String>();
    return RemindersTableData(
      id: intType.mapFromDatabaseResponse(data['${effectivePrefix}id']),
      name: stringType.mapFromDatabaseResponse(data['${effectivePrefix}name']),
      image:
          stringType.mapFromDatabaseResponse(data['${effectivePrefix}image']),
      dose: stringType.mapFromDatabaseResponse(data['${effectivePrefix}dose']),
    );
  }
  factory RemindersTableData.fromJson(Map<String, dynamic> json,
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return RemindersTableData(
      id: serializer.fromJson<int>(json['id']),
      name: serializer.fromJson<String>(json['name']),
      image: serializer.fromJson<String>(json['image']),
      dose: serializer.fromJson<String>(json['dose']),
    );
  }
  @override
  Map<String, dynamic> toJson(
      {ValueSerializer serializer = const ValueSerializer.defaults()}) {
    return {
      'id': serializer.toJson<int>(id),
      'name': serializer.toJson<String>(name),
      'image': serializer.toJson<String>(image),
      'dose': serializer.toJson<String>(dose),
    };
  }

  @override
  RemindersTableCompanion createCompanion(bool nullToAbsent) {
    return RemindersTableCompanion(
      id: id == null && nullToAbsent ? const Value.absent() : Value(id),
      name: name == null && nullToAbsent ? const Value.absent() : Value(name),
      image:
          image == null && nullToAbsent ? const Value.absent() : Value(image),
      dose: dose == null && nullToAbsent ? const Value.absent() : Value(dose),
    );
  }

  RemindersTableData copyWith(
          {int id, String name, String image, String dose}) =>
      RemindersTableData(
        id: id ?? this.id,
        name: name ?? this.name,
        image: image ?? this.image,
        dose: dose ?? this.dose,
      );
  @override
  String toString() {
    return (StringBuffer('RemindersTableData(')
          ..write('id: $id, ')
          ..write('name: $name, ')
          ..write('image: $image, ')
          ..write('dose: $dose')
          ..write(')'))
        .toString();
  }

  @override
  int get hashCode => $mrjf($mrjc(
      id.hashCode, $mrjc(name.hashCode, $mrjc(image.hashCode, dose.hashCode))));
  @override
  bool operator ==(other) =>
      identical(this, other) ||
      (other is RemindersTableData &&
          other.id == this.id &&
          other.name == this.name &&
          other.image == this.image &&
          other.dose == this.dose);
}

class RemindersTableCompanion extends UpdateCompanion<RemindersTableData> {
  final Value<int> id;
  final Value<String> name;
  final Value<String> image;
  final Value<String> dose;
  const RemindersTableCompanion({
    this.id = const Value.absent(),
    this.name = const Value.absent(),
    this.image = const Value.absent(),
    this.dose = const Value.absent(),
  });
  RemindersTableCompanion.insert({
    this.id = const Value.absent(),
    @required String name,
    @required String image,
    @required String dose,
  })  : name = Value(name),
        image = Value(image),
        dose = Value(dose);
  RemindersTableCompanion copyWith(
      {Value<int> id,
      Value<String> name,
      Value<String> image,
      Value<String> dose}) {
    return RemindersTableCompanion(
      id: id ?? this.id,
      name: name ?? this.name,
      image: image ?? this.image,
      dose: dose ?? this.dose,
    );
  }
}

class $RemindersTableTable extends RemindersTable
    with TableInfo<$RemindersTableTable, RemindersTableData> {
  final GeneratedDatabase _db;
  final String _alias;
  $RemindersTableTable(this._db, [this._alias]);
  final VerificationMeta _idMeta = const VerificationMeta('id');
  GeneratedIntColumn _id;
  @override
  GeneratedIntColumn get id => _id ??= _constructId();
  GeneratedIntColumn _constructId() {
    return GeneratedIntColumn('id', $tableName, false,
        hasAutoIncrement: true, declaredAsPrimaryKey: true);
  }

  final VerificationMeta _nameMeta = const VerificationMeta('name');
  GeneratedTextColumn _name;
  @override
  GeneratedTextColumn get name => _name ??= _constructName();
  GeneratedTextColumn _constructName() {
    return GeneratedTextColumn('name', $tableName, false,
        minTextLength: 5, maxTextLength: 50);
  }

  final VerificationMeta _imageMeta = const VerificationMeta('image');
  GeneratedTextColumn _image;
  @override
  GeneratedTextColumn get image => _image ??= _constructImage();
  GeneratedTextColumn _constructImage() {
    return GeneratedTextColumn(
      'image',
      $tableName,
      false,
    );
  }

  final VerificationMeta _doseMeta = const VerificationMeta('dose');
  GeneratedTextColumn _dose;
  @override
  GeneratedTextColumn get dose => _dose ??= _constructDose();
  GeneratedTextColumn _constructDose() {
    return GeneratedTextColumn(
      'dose',
      $tableName,
      false,
    );
  }

  @override
  List<GeneratedColumn> get $columns => [id, name, image, dose];
  @override
  $RemindersTableTable get asDslTable => this;
  @override
  String get $tableName => _alias ?? 'reminders_table';
  @override
  final String actualTableName = 'reminders_table';
  @override
  VerificationContext validateIntegrity(RemindersTableCompanion d,
      {bool isInserting = false}) {
    final context = VerificationContext();
    if (d.id.present) {
      context.handle(_idMeta, id.isAcceptableValue(d.id.value, _idMeta));
    } else if (id.isRequired && isInserting) {
      context.missing(_idMeta);
    }
    if (d.name.present) {
      context.handle(
          _nameMeta, name.isAcceptableValue(d.name.value, _nameMeta));
    } else if (name.isRequired && isInserting) {
      context.missing(_nameMeta);
    }
    if (d.image.present) {
      context.handle(
          _imageMeta, image.isAcceptableValue(d.image.value, _imageMeta));
    } else if (image.isRequired && isInserting) {
      context.missing(_imageMeta);
    }
    if (d.dose.present) {
      context.handle(
          _doseMeta, dose.isAcceptableValue(d.dose.value, _doseMeta));
    } else if (dose.isRequired && isInserting) {
      context.missing(_doseMeta);
    }
    return context;
  }

  @override
  Set<GeneratedColumn> get $primaryKey => {id};
  @override
  RemindersTableData map(Map<String, dynamic> data, {String tablePrefix}) {
    final effectivePrefix = tablePrefix != null ? '$tablePrefix.' : null;
    return RemindersTableData.fromData(data, _db, prefix: effectivePrefix);
  }

  @override
  Map<String, Variable> entityToSql(RemindersTableCompanion d) {
    final map = <String, Variable>{};
    if (d.id.present) {
      map['id'] = Variable<int, IntType>(d.id.value);
    }
    if (d.name.present) {
      map['name'] = Variable<String, StringType>(d.name.value);
    }
    if (d.image.present) {
      map['image'] = Variable<String, StringType>(d.image.value);
    }
    if (d.dose.present) {
      map['dose'] = Variable<String, StringType>(d.dose.value);
    }
    return map;
  }

  @override
  $RemindersTableTable createAlias(String alias) {
    return $RemindersTableTable(_db, alias);
  }
}

abstract class _$AppDatabase extends GeneratedDatabase {
  _$AppDatabase(QueryExecutor e) : super(SqlTypeSystem.defaultInstance, e);
  $RemindersTableTable _remindersTable;
  $RemindersTableTable get remindersTable =>
      _remindersTable ??= $RemindersTableTable(this);
  @override
  List<TableInfo> get allTables => [remindersTable];
}
