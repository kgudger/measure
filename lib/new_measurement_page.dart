import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart'
    as drift; // Aliased to prevent conflicts with Material Column
import 'database.dart';
import 'main.dart';
import 'package:image_picker/image_picker.dart';
import 'categories_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:flutter/services.dart';

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

  Future<void> _getGpsCoordinates() async {
    bool serviceEnabled;
    LocationPermission permission;

    serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return;
    }

    permission = await Geolocator.checkPermission();

    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
    }

    if (permission == LocationPermission.denied ||
        permission == LocationPermission.deniedForever) {
      return;
    }

    final position = await Geolocator.getCurrentPosition(
      locationSettings: const LocationSettings(accuracy: LocationAccuracy.high),
    );
    setState(() {
      _gpsController.text =
          '${position.latitude.toStringAsFixed(6)}, '
          '${position.longitude.toStringAsFixed(6)}';
    });
  }

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

    return Scaffold(
      appBar: AppBar(title: const Text('New Measurement')),
      body: Form(
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
            // --- DYNAMIC CATEGORY DROPDOWN FROM DB ---
            Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Expanded(
                  child: StreamBuilder<List<Category>>(
                    stream: database.watchCategories(),
                    builder: (context, snapshot) {
                      final categoriesList = snapshot.data ?? [];

                      final dropdownValue =
                          categoriesList.any((c) => c.name == _selectedCategory)
                          ? _selectedCategory
                          : null;

                      if (categoriesList.isEmpty) {
                        return DropdownButtonFormField<String>(
                          decoration: const InputDecoration(
                            labelText: 'Category *',
                          ),
                          items: const [
                            DropdownMenuItem(
                              value: null,
                              child: Text(
                                'Please add categories first',
                                style: TextStyle(color: Colors.red),
                              ),
                            ),
                          ],
                          onChanged: null,
                          validator: (_) => 'No categories available',
                        );
                      }

                      return DropdownButtonFormField<String>(
                        initialValue: dropdownValue,
                        decoration: const InputDecoration(
                          labelText: 'Category *',
                        ),
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
                        validator: (v) =>
                            v == null || v.isEmpty ? 'Required' : null,
                      );
                    },
                  ),
                ),

                const SizedBox(width: 8),

                Tooltip(
                  message: 'Edit Categories',
                  child: IconButton(
                    icon: const Icon(Icons.edit),
                    onPressed: () async {
                      await Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => const CategoriesPage(),
                        ),
                      );
                      // No refresh needed.
                      // watchCategories() will automatically rebuild.
                    },
                  ),
                ),
              ],
            ),
            Row(
              children: [
                Expanded(
                  flex: 2,
                  child: TextFormField(
                    controller: _valueController,
                    decoration: const InputDecoration(labelText: 'Value *'),
                    keyboardType: TextInputType.number,
                    inputFormatters: [
                      // Allow digits, spaces, hyphens, and the letters t, o (for "to")
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9\s\-toTO]'),
                      ),
                    ],
                    validator: (v) {
                      if (v == null || v.trim().isEmpty) {
                        return 'Please enter a value or range';
                      }
                      final cleanValue = v.trim().toLowerCase();

                      // 1. Try parsing as a single number first
                      final double? singleNumber = double.tryParse(cleanValue);
                      if (singleNumber != null) {
                        return null; // Valid single number
                      }
                      // 2. If it's not a single number, check if it's a range
                      final parts = cleanValue.split(RegExp(r'-|\bto\b'));

                      if (parts.length == 2) {
                        final double? min = double.tryParse(parts[0].trim());
                        final double? max = double.tryParse(parts[1].trim());
                        if (min == null || max == null) {
                          return 'Please enter valid numbers';
                        }

                        if (min >= max) {
                          return 'Minimum value must be less than maximum';
                        }

                        return null; // Valid range
                      }

                      // If it matches neither format
                      return 'Enter a valid number or range (e.g., 12 or 2-20)';
                    },
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
              controller: _roomController,
              decoration: const InputDecoration(labelText: 'Location *'),
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
            Row(
              children: [
                Expanded(
                  child: TextFormField(
                    controller: _gpsController,
                    decoration: const InputDecoration(
                      labelText: 'GPS Coordinates (Optional)',
                    ),
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.my_location),
                  tooltip: 'Get current GPS location',
                  onPressed: _getGpsCoordinates,
                ),
              ],
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
      ),
    );
  }
}
