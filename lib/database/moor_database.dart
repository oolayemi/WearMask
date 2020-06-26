import 'package:moor_flutter/moor_flutter.dart';
part 'moor_database.g.dart';

class RemindersTable extends Table {
  // autoincrement sets this to the primary key
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().withLength(min: 5, max: 50)();
  TextColumn get image => text()();
  TextColumn get dose => text()();
}

@UseMoor(tables: [RemindersTable])
class AppDatabase extends _$AppDatabase {
  AppDatabase()
      : super(FlutterQueryExecutor.inDatabaseFolder(
            path: 'db.sqlite', logStatements: true));

  @override
  int get schemaVersion => 1;

  Future<List<RemindersTableData>> getAllReminders() =>
      select(remindersTable).get();
  Future insertReminder(RemindersTableData reminder) =>
      into(remindersTable).insert(reminder);
  Future updateReminder(RemindersTableData reminder) =>
      update(remindersTable).replace(reminder);
  Future deleteReminder(RemindersTableData reminder) =>
      delete(remindersTable).delete(reminder);
}
