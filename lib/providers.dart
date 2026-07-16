import 'package:flutter_riverpod/flutter_riverpod.dart'; // <-- Back to your working import
import 'database.dart';

// Latest measurement shown on the home page
final latestMeasurementProvider = StreamProvider.autoDispose<List<dynamic>>((
  ref,
) {
  final database = ref.watch(appDatabaseProvider);
  return database.watchLatestMeasurement();
});

// 2. Fetch filtered rows based on the search query parameter
final searchResultsProvider = StreamProvider.autoDispose
    .family<List<Item>, String>((ref, query) {
      final database = ref.watch(appDatabaseProvider);
      return database.searchItems(query);
    });
