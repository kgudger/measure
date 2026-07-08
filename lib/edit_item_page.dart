import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart' show Value;
// Adjust these imports to match your project's file structure
import 'database.dart';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

class EditItemPage extends ConsumerStatefulWidget {
  final Item item;

  const EditItemPage({super.key, required this.item});

  @override
  ConsumerState<EditItemPage> createState() => _EditItemPageState();
}

class _EditItemPageState extends ConsumerState<EditItemPage> {
  final _formKey = GlobalKey<FormState>();

  String? _selectedCategory; // Nullable to match the dynamic Stream structure
  late TextEditingController _titleController;
  late TextEditingController _valueController;
  late TextEditingController _unitController;
  late TextEditingController _buildingController;
  late TextEditingController _roomController;
  late TextEditingController _notesController;
  late TextEditingController _photoController;
  late TextEditingController _tagsController;
  late TextEditingController _gpsController;

  @override
  void initState() {
    super.initState();

    // Set initial category from the item
    _selectedCategory = widget.item.category;

    _titleController = TextEditingController(text: widget.item.title);
    _valueController = TextEditingController(
      text: widget.item.value.toString(),
    );
    _unitController = TextEditingController(text: widget.item.unit);
    _buildingController = TextEditingController(
      text: widget.item.building ?? '',
    );
    _roomController = TextEditingController(text: widget.item.room);
    _notesController = TextEditingController(text: widget.item.notes);
    _photoController = TextEditingController(text: widget.item.photo ?? '');
    _tagsController = TextEditingController(text: widget.item.tags);
    _gpsController = TextEditingController(text: widget.item.gpsLocation ?? '');
  }

  @override
  void dispose() {
    _titleController.dispose();
    _valueController.dispose();
    _unitController.dispose();
    _buildingController.dispose();
    _roomController.dispose();
    _notesController.dispose();
    _photoController.dispose();
    _tagsController.dispose();
    _gpsController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final database = ref.read(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(title: const Text('Edit Item')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16.0),
          children: [
            // Required Field
            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Title *'),
              validator: (val) => val == null || val.trim().isEmpty
                  ? 'Title is required'
                  : null,
            ),
            const SizedBox(height: 16),

            // --- DYNAMIC CATEGORY DROPDOWN FROM DB ---
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
            const SizedBox(height: 16),

            // Required Field
            TextFormField(
              controller: _valueController,
              decoration: const InputDecoration(labelText: 'Value *'),
              keyboardType: const TextInputType.numberWithOptions(
                decimal: true,
              ),
              validator: (val) {
                if (val == null || val.trim().isEmpty) {
                  return 'Value is required';
                }
                if (double.tryParse(val) == null) return 'Enter a valid number';
                return null;
              },
            ),

            // Required Field
            TextFormField(
              controller: _unitController,
              decoration: const InputDecoration(labelText: 'Unit *'),
              validator: (val) =>
                  val == null || val.trim().isEmpty ? 'Unit is required' : null,
            ),

            // Optional Field
            TextFormField(
              controller: _buildingController,
              decoration: const InputDecoration(
                labelText: 'Building (Optional)',
              ),
            ),

            // Required Field
            TextFormField(
              controller: _roomController,
              decoration: const InputDecoration(labelText: 'Room *'),
              validator: (val) =>
                  val == null || val.trim().isEmpty ? 'Room is required' : null,
            ),

            // Required Field
            TextFormField(
              controller: _notesController,
              decoration: const InputDecoration(labelText: 'Notes *'),
              maxLines: 3,
              validator: (val) => val == null || val.trim().isEmpty
                  ? 'Notes are required'
                  : null,
            ),

            // Optional Field
            TextFormField(
              controller: _photoController,
              decoration: InputDecoration(
                labelText: 'Photo Filepath (Optional)',
                suffixIcon: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
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

            // --- NEW IMAGE PREVIEW SECTION ---
            ValueListenableBuilder<TextEditingValue>(
              valueListenable: _photoController,
              builder: (context, value, child) {
                final path = value.text.trim();
                if (path.isEmpty) return const SizedBox.shrink();

                return Padding(
                  padding: const EdgeInsets.only(top: 12.0),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8.0),
                    child: Container(
                      height: 200,
                      width: double.infinity,
                      color: Colors.grey[200],
                      child: Image.file(
                        File(path),
                        fit: BoxFit.cover,
                        errorBuilder: (context, error, stackTrace) {
                          // Fallback placeholder if the path is invalid or file doesn't exist
                          return const Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Icon(
                                  Icons.broken_image_outlined,
                                  color: Colors.grey,
                                  size: 40,
                                ),
                                SizedBox(height: 4),
                                Text(
                                  'Invalid image path or file missing',
                                  style: TextStyle(color: Colors.grey),
                                ),
                              ],
                            ),
                          );
                        },
                      ),
                    ),
                  ),
                );
              },
            ), // Required Field
            TextFormField(
              controller: _tagsController,
              decoration: const InputDecoration(
                labelText: 'Tags (comma-separated) *',
              ),
              validator: (val) => val == null || val.trim().isEmpty
                  ? 'At least one tag is required'
                  : null,
            ),

            // Optional Field
            TextFormField(
              controller: _gpsController,
              decoration: const InputDecoration(
                labelText: 'GPS Coordinates (Optional)',
              ),
            ),
            const SizedBox(height: 32),

            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  final updatedItem = widget.item.copyWith(
                    title: _titleController.text.trim(),
                    category:
                        _selectedCategory!, // Safe to bang operator because of form validation
                    value: double.parse(_valueController.text.trim()),
                    unit: _unitController.text.trim(),
                    building: Value(
                      _buildingController.text.trim().isEmpty
                          ? null
                          : _buildingController.text.trim(),
                    ),
                    room: _roomController.text.trim(),
                    notes: _notesController.text.trim(),
                    photo: Value(
                      _photoController.text.trim().isEmpty
                          ? null
                          : _photoController.text.trim(),
                    ),
                    tags: _tagsController.text.trim(),
                    gpsLocation: Value(
                      _gpsController.text.trim().isEmpty
                          ? null
                          : _gpsController.text.trim(),
                    ),
                    dateModified: DateTime.now(),
                  );

                  await database.updateItem(updatedItem);

                  if (!context.mounted) return;
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(content: Text('Item updated successfully')),
                  );
                  Navigator.pop(context);
                }
              },
              child: const Text('Save Changes'),
            ),
          ],
        ),
      ),
    );
  }
}
