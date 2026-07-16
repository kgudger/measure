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
  TextColumn get building => text().nullable()();
  TextColumn get photo =>
      text().nullable()(); // Stores the local file path or URI string
  DateTimeColumn get dateCreated =>
      dateTime().withDefault(currentDateAndTime)();
  DateTimeColumn get dateModified =>
      dateTime().withDefault(currentDateAndTime)();
  TextColumn get gpsLocation => text().nullable()(); // Optional field
  TextColumn get tags =>
      text()(); // Stores tags as a comma-separated string or JSON string
}

// NEW: Category Table Schema
class Categories extends Table {
  IntColumn get id => integer().autoIncrement()();
  TextColumn get name => text().customConstraint('NOT NULL UNIQUE')();
}

// 2. Define the Drift Database connection
@DriftDatabase(
  tables: [Items, Categories],
) // <-- 1. Must include Categories here
class AppDatabase extends _$AppDatabase {
  AppDatabase() : super(_openConnection());

  @override
  int get schemaVersion => 2;

  // Migration logic to handle adding the new table seamlessly
  @override
  MigrationStrategy get migration {
    return MigrationStrategy(
      onCreate: (Migrator m) async {
        await m.createAll();
        // Initial categories to seed the database
        final initialCategories = [
          'Hardware',
          'Lumber',
          'Plumbing',
          'Electrical',
          'Paint',
          'Automotive',
          'Appliance',
          'Garden',
          'Home',
          'Construction',
          'Fabric',
          'Flooring',
          'Furniture',
          'Tools',
          'Miscellaneous',
        ];

        // Insert each default category into the newly created database
        for (final category in initialCategories) {
          await into(categories).insert(
            CategoriesCompanion.insert(name: category),
            mode: InsertMode
                .insertOrIgnore, // Safely ignore duplicates if anything goes wrong
          );
        }
      },
      onUpgrade: (Migrator m, int from, int to) async {
        if (from < 2) {
          await m.createTable(categories);
        }
      },
    );
  }

  // --- Category Queries ---
  Stream<List<Category>> watchCategories() {
    return (select(
      categories,
    )..orderBy([(t) => OrderingTerm(expression: t.name)])).watch();
  }

  Future<int> addCategory(String name) {
    return into(categories).insert(
      CategoriesCompanion.insert(name: name.trim()),
      mode:
          InsertMode.insertOrIgnore, // Prevents crashes from unique constraint
    );
  }

  Future<int> deleteItem(int id) {
    return (delete(items)..where((t) => t.id.equals(id))).go();
  }

  Future<int> deleteCategory(int id) {
    return (delete(categories)..where((t) => t.id.equals(id))).go();
  }
  // -------------------------

  Future<bool> updateItem(Item item) {
    return update(items).replace(item);
  }

  Stream<List> watchLatestMeasurement() {
    return (select(items)
          ..orderBy([
            (t) => OrderingTerm(expression: t.id, mode: OrderingMode.desc),
          ])
          ..limit(3))
        .watch();
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
