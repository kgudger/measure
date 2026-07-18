import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:drift/drift.dart'
    as drift; // Aliased to prevent conflicts with Material Column
import 'database.dart';
import 'dart:io';
import 'main.dart';
import 'package:image_picker/image_picker.dart';
import 'categories_page.dart';
import 'package:geolocator/geolocator.dart';
import 'package:drift/drift.dart' show Value;
import 'package:flutter/services.dart';

class MeasurementEditorPage extends ConsumerStatefulWidget {
  final Item? item;

  const MeasurementEditorPage({super.key, this.item});

  @override
  ConsumerState<MeasurementEditorPage> createState() =>
      _MeasurementEditorPageState();
}

class _MeasurementEditorPageState extends ConsumerState<MeasurementEditorPage> {
  final _formKey = GlobalKey<FormState>();

  // Controllers
  final _titleController = TextEditingController();
  final _valueController = TextEditingController();
  final _unitController = TextEditingController();
  final _notesController = TextEditingController();
  final _roomController = TextEditingController();
  final _buildingController = TextEditingController();
  final _photoController = TextEditingController();
  final _gpsController = TextEditingController();
  final _tagsController = TextEditingController();

  String? _selectedCategory;

  bool get isEditing => widget.item != null;

  @override
  void initState() {
    super.initState();

    if (isEditing) {
      final item = widget.item!;

      _titleController.text = item.title;
      _selectedCategory = item.category;
      _valueController.text = item.value;
      _unitController.text = item.unit;
      _notesController.text = item.notes;
      _roomController.text = item.room;
      _buildingController.text = item.building ?? '';
      _photoController.text = item.photo ?? '';
      _gpsController.text = item.gpsLocation ?? '';
      _tagsController.text = item.tags;
    }
  }

  @override
  void dispose() {
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

  Future<void> _save() async {
    if (!_formKey.currentState!.validate()) return;

    if (isEditing) {
      await _updateMeasurement();
    } else {
      await _insertMeasurement();
    }

    if (!mounted) return;

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(isEditing ? 'Measurement updated' : 'Measurement saved'),
      ),
    );

    ref.read(currentPageIndexProvider.notifier).setPage(0);
  }

  Future<void> _insertMeasurement() async {
    final database = ref.read(appDatabaseProvider);

    final parsed = parseValue(_valueController.text);

    await database
        .into(database.items)
        .insert(
          ItemsCompanion.insert(
            title: _titleController.text,
            category: _selectedCategory ?? '',
            value: parsed.text,
            valueType: parsed.type.index,
            value1: drift.Value(parsed.value1),
            value2: drift.Value(parsed.value2),
            value3: drift.Value(parsed.value3),
            unit: _unitController.text,
            notes: _notesController.text,
            room: _roomController.text,
            building: _buildingController.text.isNotEmpty
                ? drift.Value(_buildingController.text)
                : const drift.Value.absent(),
            photo: _photoController.text.isNotEmpty
                ? drift.Value(_photoController.text)
                : const drift.Value.absent(),
            gpsLocation: _gpsController.text.isNotEmpty
                ? drift.Value(_gpsController.text)
                : const drift.Value.absent(),
            tags: _tagsController.text,
          ),
        );
  }

  Future<void> _updateMeasurement() async {
    final database = ref.read(appDatabaseProvider);
    final parsed = parseMeasurement(_valueController.text);
    if (!parsed.isValid) {
      return;
    }

    final updatedItem = widget.item!.copyWith(
      title: _titleController.text.trim(),
      category: _selectedCategory ?? '',
      value: parsed.text,
      valueType: parsed.type.index,
      value1: drift.Value(parsed.value1),
      value2: drift.Value(parsed.value2),
      value3: drift.Value(parsed.value3),
      unit: _unitController.text.trim(),
      notes: _notesController.text.trim(),
      room: _roomController.text.trim(),
      building: Value(
        _buildingController.text.trim().isEmpty
            ? null
            : _buildingController.text.trim(),
      ),

      photo: Value(
        _photoController.text.trim().isEmpty
            ? null
            : _photoController.text.trim(),
      ),

      gpsLocation: Value(
        _gpsController.text.trim().isEmpty ? null : _gpsController.text.trim(),
      ),
      tags: _tagsController.text.trim(),
      dateModified: DateTime.now(),
    );

    await database.updateItem(updatedItem);
  }

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

  void _insertSeparator(String separator) {
    final value = _valueController.value;

    final start = value.selection.start;
    final end = value.selection.end;

    // Cursor not in field? Append to end.
    if (start < 0 || end < 0) {
      _valueController.text += separator;
      _valueController.selection = TextSelection.collapsed(
        offset: _valueController.text.length,
      );
      return;
    }

    final newText = value.text.replaceRange(start, end, separator);

    _valueController.value = TextEditingValue(
      text: newText,
      selection: TextSelection.collapsed(offset: start + separator.length),
    );
  }

  @override
  Widget build(BuildContext context) {
    final database = ref.watch(appDatabaseProvider);

    return Scaffold(
      appBar: AppBar(title: Text(isEditing ? 'Edit Item' : 'New Measurement')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
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
                    keyboardType: const TextInputType.numberWithOptions(
                      decimal: true,
                    ),
                    decoration: const InputDecoration(labelText: 'Value'),
                    inputFormatters: [
                      // Allow digits, spaces, hyphens, and the letters t, o (for "to")
                      FilteringTextInputFormatter.allow(
                        RegExp(r'[0-9A-Za-z×xX.\-\s]'),
                      ),
                    ],
                    validator: (v) {
                      return parseMeasurement(v ?? '').error;
                    },
                  ),
                ),
                const SizedBox(height: 6),
                Row(
                  children: [
                    FilledButton.tonalIcon(
                      icon: const Icon(Icons.swap_horiz, size: 18),
                      label: const Text('Range'),
                      onPressed: () => _insertSeparator(' - '),
                    ),
                    const SizedBox(width: 8),
                    FilledButton.tonalIcon(
                      icon: const Icon(Icons.grid_3x3, size: 18),
                      label: const Text('Dimensions'),
                      onPressed: () => _insertSeparator(' x '),
                    ),
                  ],
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
              onPressed: _save,
              child: Text(isEditing ? 'Save Changes' : 'Save Measurement'),
            ),
          ],
        ),
      ),
    );
  }
}

enum ValueType { single, range, dimensions2D, dimensions3D }

class ParsedValue {
  final String text;
  final ValueType type;
  final double? value1;
  final double? value2;
  final double? value3;
  final String? error;

  ParsedValue({
    required this.text,
    required this.type,
    this.value1,
    this.value2,
    this.value3,
    this.error,
  });
  bool get isValid => error == null;
}

ParsedValue parseValue(String input) {
  final text = input.trim();
  final clean = text.toLowerCase();

  if (double.tryParse(clean) != null) {
    return ParsedValue(
      text: text,
      type: ValueType.single,
      value1: double.parse(clean),
    );
  }

  if (clean.contains('-') || RegExp(r'\bto\b').hasMatch(clean)) {
    final parts = clean.split(RegExp(r'\s*-\s*|\bto\b'));

    return ParsedValue(
      text: text,
      type: ValueType.range,
      value1: double.parse(parts[0]),
      value2: double.parse(parts[1]),
    );
  }

  final parts = clean.split(RegExp(r'\s*x\s*|\bby\b'));

  if (parts.length == 2) {
    return ParsedValue(
      text: text,
      type: ValueType.dimensions2D,
      value1: double.parse(parts[0]),
      value2: double.parse(parts[1]),
    );
  }

  return ParsedValue(
    text: text,
    type: ValueType.dimensions3D,
    value1: double.parse(parts[0]),
    value2: double.parse(parts[1]),
    value3: double.parse(parts[2]),
  );
}

ParsedValue parseMeasurement(String input) {
  final text = input.trim();

  if (text.isEmpty) {
    return ParsedValue(
      text: text,
      type: ValueType.single,
      error: 'Please enter a value',
    );
  }

  final clean = text.toLowerCase();

  // ---------- Single number ----------
  final single = double.tryParse(clean);
  if (single != null) {
    return ParsedValue(text: text, type: ValueType.single, value1: single);
  }

  // ---------- Range ----------
  if (clean.contains('-') || RegExp(r'\bto\b').hasMatch(clean)) {
    final parts = clean.split(RegExp(r'\s*-\s*|\s*to\s*'));

    if (parts.length != 2) {
      return ParsedValue(
        text: text,
        type: ValueType.range,
        error: 'Invalid range',
      );
    }

    final min = double.tryParse(parts[0]);
    final max = double.tryParse(parts[1]);

    if (min == null || max == null) {
      return ParsedValue(
        text: text,
        type: ValueType.range,
        error: 'Invalid numbers',
      );
    }

    if (min >= max) {
      return ParsedValue(
        text: text,
        type: ValueType.range,
        error: 'Minimum must be less than maximum',
      );
    }

    return ParsedValue(
      text: text,
      type: ValueType.range,
      value1: min,
      value2: max,
    );
  }

  // ---------- Dimensions ----------
  final parts = clean.split(RegExp(r'\s*x\s*|\s*by\s*'));

  if (parts.length == 2 || parts.length == 3) {
    final v1 = double.tryParse(parts[0]);
    final v2 = double.tryParse(parts[1]);
    final v3 = parts.length == 3 ? double.tryParse(parts[2]) : null;

    if (v1 == null || v2 == null || (parts.length == 3 && v3 == null)) {
      return ParsedValue(
        text: text,
        type: parts.length == 2
            ? ValueType.dimensions2D
            : ValueType.dimensions3D,
        error: 'Invalid dimensions',
      );
    }

    return ParsedValue(
      text: text,
      type: parts.length == 2 ? ValueType.dimensions2D : ValueType.dimensions3D,
      value1: v1,
      value2: v2,
      value3: v3,
    );
  }

  return ParsedValue(
    text: text,
    type: ValueType.single,
    error: 'Enter a number, range, or dimensions',
  );
}
