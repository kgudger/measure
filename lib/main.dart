import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
//import 'database.dart';
import 'new_measurement_page.dart';
//import 'home_page.dart';
//import 'providers.dart';
import 'home_page.dart';
import 'categories_page.dart';
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
      title: 'Measure Saver',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
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
                  builder: (context) => const NewMeasurementPage(),
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
        return const NewMeasurementPage();
      case 3:
        return const CategoriesPage();
      case 4:
        return const Center(child: Text('Camera Content View'));
      case 5:
        return const Center(child: Text('Photos Content View'));
      case 6:
        return const Center(child: Text('Settings Content View'));
      default:
        return const Center(child: Text('Page not found'));
    }
  }
}

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
