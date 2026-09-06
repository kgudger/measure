import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
//import 'database.dart';
import 'measurement_editor_page.dart';
//import 'home_page.dart';
//import 'providers.dart';
import 'home_page.dart';
import 'help_page.dart';
//import 'categories_page.dart';
//import 'current_page_index.dart';

// 1. This part statement is required for code generation
//part 'navigation_provider.g.dart';
part 'main.g.dart';

// 2. Decorate your function to generate the provider automatically
@riverpod
class CurrentPageIndex extends _$CurrentPageIndex {
  @override
  int build() => 0; // Initial state value (Home screen)

  void setPage(int index) {
    state = index; // Updates the state
  }
}

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'FixTracker',
      theme: ThemeData(
        useMaterial3: true,
        // 1. Sets the page background for all Scaffolds
        scaffoldBackgroundColor: const Color(
          0xFFE5E7EB,
        ), // Slightly darker, premium cool gray
        // 1. Updates the ColorScheme for light mode behaviors
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color(
            0xFF1E2229,
          ), // Rich slate/charcoal seed for buttons/accents
          brightness: Brightness.light, // Maintains light mode behaviors
          surface: const Color(
            0xFFFFFFFF,
          ), // Pure white surface makes cards pop against the darker gray
        ),

        // 2. Strong contrast text styles
        textTheme: const TextTheme(
          bodyLarge: TextStyle(
            color: Color(
              0xFF111827,
            ), // Deeper, high-contrast dark slate for primary numbers/labels
            fontWeight: FontWeight.w600,
          ),
          bodyMedium: TextStyle(
            color: Color(
              0xFF4B5563,
            ), // Balanced medium gray for secondary metrics/units (e.g., kg, cm)
          ),
        ),
      ),
      debugShowCheckedModeBanner: false,
      home: const MainNavigationWrapper(),
    );
  }
}

class MainNavigationWrapper extends ConsumerWidget {
  const MainNavigationWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the generated provider
    final currentPageIndex = ref.watch(currentPageIndexProvider);

    final List<String> titles = [
      'Home / Search',
      'Search',
      'New Measurement',
      'Categories',
      'Camera',
      'Photos',
      'Settings',
    ];

    return Scaffold(
      appBar: AppBar(
        title: Text(titles[currentPageIndex]),
        actions: [
          // "Add Measurement" Action Icon
          IconButton(
            icon: const Icon(Icons.add_box),
            tooltip: 'Add Measurement',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const MeasurementEditorPage(),
                ),
              );
            },
          ),
          // "Help" Action Icon
          IconButton(
            icon: const Icon(Icons.help_outline),
            tooltip: 'Help',
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => const HelpPage()),
              );
            },
          ),
        ],
      ),
      body: _getScreenForIndex(currentPageIndex),
    );
  }

  Widget _getScreenForIndex(int index) {
    switch (index) {
      case 0:
        return const HomePageView();
      case 2:
        return const MeasurementEditorPage();
      default:
        return const Center(child: Text('Page not found'));
    }
  }
}
/*
// Dedicated Help Page
class HelpPage extends StatelessWidget {
  const HelpPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Info')),
      body: const Padding(
        padding: EdgeInsets.all(16.0),
        child: Center(
          child: Text(
            'Welcome to the Help Page!\n\nHere you can find instructions and guides on how to use the Measure Saver app.',
            textAlign: TextAlign.center,
            style: TextStyle(fontSize: 16),
          ),
        ),
      ),
    );
  }
}
*/
