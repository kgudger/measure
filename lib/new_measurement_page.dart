import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart'
    as drift; // Aliased to prevent conflicts with Material Column
import 'database.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';

class NewMeasurementPage extends ConsumerStatefulWidget {
  const NewMeasurementPage({super.key});

  @override
  ConsumerState<NewMeasurementPage> createState() => _NewMeasurementPageState();
}

class _NewMeasurementPageState extends ConsumerState<NewMeasurementPage> {
  final _formKey = GlobalKey<FormState>();

  // Text Controllers for all required strings and numbers
  final _titleController = TextEditingController();
  String?
  _selectedCategory; // Tracks the chosen dropdown option instead of a text controller
  final _valueController = TextEditingController();
  final _unitController = TextEditingController();
  final _notesController = TextEditingController();
  final _roomController = TextEditingController();
  final _buildingController = TextEditingController();
  final _photoController = TextEditingController();
  final _gpsController = TextEditingController();
  final _tagsController = TextEditingController();

  @override
  void dispose() {
    // Avoid memory leaks by cleanly disposing controllers
    _titleController.dispose();
    _valueController.dispose();
    _unitController.dispose();
    _notesController.dispose();
    _roomController.dispose();
    _buildingController.dispose();
    _photoController.dispose();
    _gpsController.dispose();
    _tagsController.dispose();
    super.dispose();
  }

  Future<void> _saveToDatabase() async {
    if (!_formKey.currentState!.validate()) return;

    final database = ref.read(appDatabaseProvider);

    // Convert numeric input safely
    final double value = double.tryParse(_valueController.text) ?? 0.0;

    // Use Drift's generated ItemsCompanion to package the structural data
    await database
        .into(database.items)
        .insert(
          ItemsCompanion.insert(
            title: _titleController.text,
            category: _selectedCategory ?? '', // Uses the dropdown value
            value: value,
            unit: _unitController.text,
            notes: _notesController.text,
            room: _roomController.text,
            building: _buildingController.text.isNotEmpty
                ? drift.Value(_buildingController.text)
                : const drift.Value.absent(),
            photo: _photoController.text.isNotEmpty
                ? drift.Value(_photoController.text)
                : const drift.Value.absent(),
            tags: _tagsController.text,
            gpsLocation: _gpsController.text.isNotEmpty
                ? drift.Value(_gpsController.text)
                : const drift.Value.absent(),
          ),
        );
    if (!mounted) return;

    if (mounted) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Measurement saved successfully!')),
      );
      //      Navigator.of(context).pop(); // Return back to previous page
    }
    // Go back to the Home page instead of popping a route.
    ref.read(currentPageIndexProvider.notifier).setPage(0);
  }

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(appDatabaseProvider);

    return Form(
      key: _formKey,
      child: ListView(
        padding: const EdgeInsets.all(16.0),
        children: [
          TextFormField(
            controller: _titleController,
            decoration: const InputDecoration(labelText: 'Title *'),
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          const SizedBox(height: 8),
          // StreamBuilder dynamically loads category items from database
          StreamBuilder<List<Category>>(
            stream: database.watchCategories(),
            builder: (context, snapshot) {
              final categoriesList = snapshot.data ?? [];

              // Fallback placeholder if no categories exist in the system yet
              if (categoriesList.isEmpty) {
                return DropdownButtonFormField<String>(
                  decoration: const InputDecoration(labelText: 'Category *'),
                  items: const [
                    DropdownMenuItem(
                      value: null,
                      child: Text(
                        'Please add categories first',
                        style: TextStyle(color: Colors.red),
                      ),
                    ),
                  ],
                  onChanged: null, // Disabled
                  validator: (_) => 'No categories available',
                );
              }

              // Reset selection if the previously chosen item was deleted from DB
              if (_selectedCategory != null &&
                  !categoriesList.any((c) => c.name == _selectedCategory)) {
                _selectedCategory = null;
              }

              return DropdownButtonFormField<String>(
                initialValue: _selectedCategory,
                decoration: const InputDecoration(labelText: 'Category *'),
                items: categoriesList.map((category) {
                  return DropdownMenuItem<String>(
                    value: category.name,
                    child: Text(category.name),
                  );
                }).toList(),
                onChanged: (newValue) {
                  setState(() {
                    _selectedCategory = newValue;
                  });
                },
                validator: (v) => v == null || v.isEmpty ? 'Required' : null,
              );
            },
          ),
          Row(
            children: [
              Expanded(
                flex: 2,
                child: TextFormField(
                  controller: _valueController,
                  decoration: const InputDecoration(labelText: 'Value *'),
                  keyboardType: TextInputType.number,
                  validator: (v) => double.tryParse(v ?? '') == null
                      ? 'Invalid Number'
                      : null,
                ),
              ),
              const SizedBox(width: 12),
              Expanded(
                child: TextFormField(
                  controller: _unitController,
                  decoration: const InputDecoration(labelText: 'Unit *'),
                  validator: (v) => v!.isEmpty ? 'Required' : null,
                ),
              ),
            ],
          ),
          TextFormField(
            controller: _buildingController,
            decoration: const InputDecoration(labelText: 'Building'),
            //              validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _roomController,
            decoration: const InputDecoration(labelText: 'Room *'),
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _notesController,
            decoration: const InputDecoration(labelText: 'Notes *'),
            maxLines: 2,
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _photoController,
            decoration: InputDecoration(
              labelText: 'Photo Filepath / URI',
              suffixIcon: Row(
                mainAxisSize: MainAxisSize
                    .min, // Prevents the Row from stretching across the field
                children: [
                  // --- CAMERA BUTTON ---
                  IconButton(
                    icon: const Icon(Icons.photo_camera_outlined),
                    tooltip: 'Take Photo',
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? photo = await picker.pickImage(
                        source: ImageSource.camera,
                        imageQuality: 85,
                      );
                      if (photo != null) {
                        setState(() {
                          _photoController.text = photo.path;
                        });
                      }
                    },
                  ),
                  // --- NEW GALLERY PHOTO PICKER BUTTON ---
                  IconButton(
                    icon: const Icon(Icons.photo_library_outlined),
                    tooltip: 'Pick From Gallery',
                    onPressed: () async {
                      final picker = ImagePicker();
                      final XFile? image = await picker.pickImage(
                        source: ImageSource.gallery,
                        imageQuality: 85,
                      );
                      if (image != null) {
                        setState(() {
                          _photoController.text = image.path;
                        });
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
          TextFormField(
            controller: _tagsController,
            decoration: const InputDecoration(
              labelText: 'Tags (comma-separated) *',
            ),
            validator: (v) => v!.isEmpty ? 'Required' : null,
          ),
          TextFormField(
            controller: _gpsController,
            decoration: const InputDecoration(
              labelText: 'GPS Coordinates (Optional)',
            ),
          ),
          const SizedBox(height: 24),
          ElevatedButton(
            onPressed: _saveToDatabase,
            style: ElevatedButton.styleFrom(
              minimumSize: const Size.fromHeight(50),
            ),
            child: const Text('Save Data', style: TextStyle(fontSize: 16)),
          ),
        ],
      ),
    );
  }
}
