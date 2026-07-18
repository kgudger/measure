import 'package:flutter/material.dart';

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
      appBar: AppBar(title: const Text('Help')),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: TextField(
          maxLines: null, // Allows the text area to expand vertically as needed
          controller: TextEditingController(text: (helpText)),
          decoration: const InputDecoration(
            border:
                OutlineInputBorder(), // Adds a clean border around the text box
          ),
        ),
      ),
    ); // Scaffold
  }

  String helpText =
      'The Main Page shows the 3 latest measurement entries. Click the "+" button at the top to add new measurements. You can search your previous measurements on the home page. Each entry requires you to select a Category from a drop down list. There is an edit symbol next to "Category" to allow you to delete or add any categories. The "Value" field accepts a range, e.g. "7-20" (or "7 to 20"). On the home page note the "View" icon allows you to view AND edit any entry.';
}
