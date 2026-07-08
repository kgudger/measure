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

/*
final counterProvider = NotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
);

class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void increment() => state++;
}
*/
class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measure Saver',
      theme: ThemeData(colorScheme: .fromSeed(seedColor: Colors.deepPurple)),
      debugShowCheckedModeBanner: false,
      home: MainNavigationWrapper(),
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
      appBar: AppBar(title: Text(titles[currentPageIndex])),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            const DrawerHeader(
              decoration: BoxDecoration(color: Colors.purple),
              child: Text(
                'Menu',
                style: TextStyle(color: Colors.white, fontSize: 24),
              ),
            ),
            _buildDrawerItem(
              ref,
              context,
              icon: Icons.home,
              title: 'Home / Search',
              index: 0,
            ),
            _buildDrawerItem(
              ref,
              context,
              icon: Icons.add_box,
              title: 'New Measurement',
              index: 2,
            ),
            _buildDrawerItem(
              ref,
              context,
              icon: Icons.category,
              title: 'Categories',
              index: 3,
            ),
            _buildDrawerItem(
              ref,
              context,
              icon: Icons.camera_alt,
              title: 'Camera',
              index: 4,
            ),
            _buildDrawerItem(
              ref,
              context,
              icon: Icons.photo_library,
              title: 'Photos',
              index: 5,
            ),
            _buildDrawerItem(
              ref,
              context,
              icon: Icons.settings,
              title: 'Settings',
              index: 6,
            ),
          ],
        ),
      ),
      body: _getScreenForIndex(currentPageIndex),
    );
  }

  Widget _buildDrawerItem(
    WidgetRef ref,
    BuildContext context, {
    required IconData icon,
    required String title,
    required int index,
  }) {
    final currentIndex = ref.watch(currentPageIndexProvider);
    final isSelected = currentIndex == index;

    return ListTile(
      leading: Icon(icon, color: isSelected ? Colors.purpleAccent : null),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.purpleAccent : null,
          fontWeight: isSelected ? FontWeight.bold : null,
        ),
      ),
      selected: isSelected,
      onTap: () {
        // 2. Call the notifier method to change the index state
        ref.read(currentPageIndexProvider.notifier).setPage(index);
        Navigator.pop(context);
      },
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
