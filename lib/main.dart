import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'database.dart';
import 'new_measurement_page.dart';
//import 'home_page.dart';
//import 'providers.dart';
import 'home_page.dart';
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

  Future<void> addItemSample() async {
    final db = ref.read(appDatabaseProvider);

    await db
        .into(db.items)
        .insert(
          ItemsCompanion.insert(
            title: 'Main Router',
            category: 'Hardware',
            value: 129.99,
            unit: 'USD',
            notes: 'Located in server rack',
            room: 'Server Room 2B',
            building: 'HQ Block A',
            photo: '/path/to/photo.jpg',
            tags: 'networking,hardware,critical',
            // dateCreated and dateModified auto-populate, gpsLocation is null/optional
          ),
        );
  }
}

void main() {
  runApp(const ProviderScope(child: MyApp()));
}

final counterProvider = NotifierProvider<CounterNotifier, int>(
  CounterNotifier.new,
);

class CounterNotifier extends Notifier<int> {
  @override
  int build() => 0;
  void increment() => state++;
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Measure Saver',
      theme: ThemeData(
        // This is the theme of your application.
        //
        // TRY THIS: Try running your application with "flutter run". You'll see
        // the application has a purple toolbar. Then, without quitting the app,
        // try changing the seedColor in the colorScheme below to Colors.green
        // and then invoke "hot reload" (save your changes or press the "hot
        // reload" button in a Flutter-supported IDE, or press "r" if you used
        // the command line to start the app).
        //
        // Notice that the counter didn't reset back to zero; the application
        // state is not lost during the reload. To reset the state, use hot
        // restart instead.
        //
        // This works for code too, not just values: Most code changes can be
        // tested with just a hot reload.
        colorScheme: .fromSeed(seedColor: Colors.deepPurple),
      ),
      //      home: const MyHomePage(title: 'Flutter Demo Home Page'),
      debugShowCheckedModeBanner: false,
      home: MainNavigationWrapper(),
    );
  }
}

class MainNavigationWrapper extends ConsumerWidget {
  const MainNavigationWrapper({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the generated provider (notice the lowerCamelCase naming convention)
    final currentPageIndex = ref.watch(currentPageIndexProvider);

    final List<String> titles = [
      'Home',
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
              title: 'Home',
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
      leading: Icon(icon, color: isSelected ? Colors.blue : null),
      title: Text(
        title,
        style: TextStyle(
          color: isSelected ? Colors.blue : null,
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
        return const Center(child: Text('Categories Content View'));
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
/*
class CounterScreen extends ConsumerWidget {
  const CounterScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    // 1. Watch the counter state (rebuilds this widget when state changes)
    final counter = ref.watch(counterProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Riverpod Counter Example')),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text('You have pushed the button this many times:'),
            Text('$counter', style: Theme.of(context).textTheme.headlineMedium),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        // 2. Read the notifier to trigger the increment method
        onPressed: () => ref.read(counterProvider.notifier).increment(),
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});
fl
  // This widget is the home page of your application. It is stateful, meaning
  // that it has a State object (defined below) that contains fields that affect
  // how it looks.

  // This class is the configuration for the state. It holds the values (in this
  // case the title) provided by the parent (in this case the App widget) and
  // used by the build method of the State. Fields in a Widget subclass are
  // always marked "final".

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      // This call to setState tells the Flutter framework that something has
      // changed in this State, which causes it to rerun the build method below
      // so that the display can reflect the updated values. If we changed
      // _counter without calling setState(), then the build method would not be
      // called again, and so nothing would appear to happen.
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    // This method is rerun every time setState is called, for instance as done
    // by the _incrementCounter method above.
    //
    // The Flutter framework has been optimized to make rerunning build methods
    // fast, so that you can just rebuild anything that needs updating rather
    // than having to individually change instances of widgets.
    return Scaffold(
      appBar: AppBar(
        // TRY THIS: Try changing the color here to a specific color (to
        // Colors.amber, perhaps?) and trigger a hot reload to see the AppBar
        // change color while the other colors stay the same.
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        // Here we take the value from the MyHomePage object that was created by
        // the App.build method, and use it to set our appbar title.
        title: Text(widget.title),
      ),
      body: Center(
        // Center is a layout widget. It takes a single child and positions it
        // in the middle of the parent.
        child: Column(
          // Column is also a layout widget. It takes a list of children and
          // arranges them vertically. By default, it sizes itself to fit its
          // children horizontally, and tries to be as tall as its parent.
          //
          // Column has various properties to control how it sizes itself and
          // how it positions its children. Here we use mainAxisAlignment to
          // center the children vertically; the main axis here is the vertical
          // axis because Columns are vertical (the cross axis would be
          // horizontal).
          //
          // TRY THIS: Invoke "debug painting" (choose the "Toggle Debug Paint"
          // action in the IDE, or press "p" in the console), to see the
          // wireframe for each widget.
          mainAxisAlignment: .center,
          children: [
            const Text('You have pushed the button this many times:'),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ),
    );
  }
}
*/