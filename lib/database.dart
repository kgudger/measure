import 'package:drift/drift.dart';
import 'package:drift_flutter/drift_flutter.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'database.g.dart';

// 1. Define the SQLite Table Schema
class Items extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get title => text()();
  TextColumn get category => text()();
  RealColumn get value => real()();
  TextColumn get unit => text()();
  TextColumn get notes => text()();
  TextColumn get room => text()();
  TextColumn get building => text()();
  TextColumn get photo => text()(); // Stores the local file path or URI string
  DateTimeColumn get dateCreated =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get dateModified =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get gpsLocation => text().nullable()(); // Optional field
  TextColumn get tags =>
      text()(); // Stores tags as a comma-separated string or JSON string
}

// 2. Define the Drift Database connection
@DriftDatabase(tables: [Items])
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 1;

  Stream<Item?> watchLatestMeasurement() {
    return (select(items)
          ..orderBy([
            (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
          ])
          ..limit(1))
        .watchSingleOrNull();
  }

  Stream<List<Item>> searchItems(String query) {
    if (query.trim().isEmpty) {
      return (select(items)..orderBy([
            (t) => OrderingTerm(
              expression: t.dateCreated,
              mode: OrderingMode.desc,
            ),
          ]))
          .watch();
    }

    final q = '%${query.toLowerCase()}%';

    return (select(items)..where(
          (t) =>
              t.title.lower().like(q) |
              t.category.lower().like(q) |
              t.notes.lower().like(q) |
              t.tags.lower().like(q) |
              t.room.lower().like(q) |
              t.building.lower().like(q),
        ))
        .watch();
  }

  static QueryExecutor _openConnection() {
    // drift_flutter automatically manages the correct native path on iOS/Android/Web
    return driftDatabase(name: 'app_database');
  }
}

// 3. Create a Riverpod Provider to access the database anywhere
@riverpod
AppDatabase appDatabase(Ref ref) {
  final db = AppDatabase();
  //  ref.onDispose(() => db.close());
  return db;
}
