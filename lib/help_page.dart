import 'package:flutter/material.dart';
import 'package:package_info_plus/package_info_plus.dart';

class HelpPage extends StatefulWidget {
  const HelpPage({super.key});
  @override
  State<HelpPage> createState() => _HelpPage();
}

class _HelpPage extends State<HelpPage> {
  final TextEditingController colorController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Use 'widget.' to access properties from the StatefulWidget class
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Help & Support')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(helpText, style: TextStyle(fontSize: 16)),
            const Spacer(), // Pushes the version numbers to the bottom
            // FutureBuilder pulls the version dynamically
            FutureBuilder<PackageInfo>(
              future: PackageInfo.fromPlatform(),
              builder: (context, snapshot) {
                if (snapshot.hasData) {
                  final String version =
                      snapshot.data!.version; // e.g., "1.0.2"
                  final String buildNumber =
                      snapshot.data!.buildNumber; // e.g., "4"

                  return Center(
                    child: Text(
                      'App Version: $version ($buildNumber)',
                      style: const TextStyle(color: Colors.grey, fontSize: 14),
                    ),
                  );
                }
                return const Center(
                  child: SizedBox(
                    width: 20,
                    height: 20,
                    child: CircularProgressIndicator(strokeWidth: 2),
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}

const String helpText =
    'The Home Page shows up to the 3 latest measurement entries. Click the "+" button at the top to add new measurements. You can search your previous measurements on the home page.\nEach entry requires you to select a Category from a drop down list. There is an edit symbol next to "Category" to allow you to delete or add any categories. The "Value" field accepts a range, e.g. "7-20" (or "7 to 20") or up to 3 dimensions. Click the “Range” button to add the “-” between values or the “Size” button to add an “x” between dimensions.\nOn the home page note the "View" icon allows you to view AND edit any entry.';
