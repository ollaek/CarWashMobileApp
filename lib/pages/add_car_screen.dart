import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:image_picker/image_picker.dart';
import 'dart:typed_data';
import 'dart:io' as io;

class AddCarScreen extends StatefulWidget {
  const AddCarScreen({super.key});

  @override
  State<AddCarScreen> createState() => _AddCarScreenState();
}

class _AddCarScreenState extends State<AddCarScreen> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  // Dropdown data
  final Map<String, List<String>> _brandToModels = const {
    'Toyota': ['Corolla', 'Camry', 'Yaris', 'RAV4', 'Hilux'],
    'Hyundai': ['Elantra', 'Accent', 'Tucson', 'Sonata', 'Creta'],
    'Kia': ['Cerato', 'Rio', 'Sportage', 'Sorento', 'Picanto'],
    'BMW': ['3 Series', '5 Series', 'X3', 'X5'],
    'Mercedes': ['C-Class', 'E-Class', 'GLC', 'GLE'],
    'Nissan': ['Sunny', 'Sentra', 'Qashqai'],
    'Chevrolet': ['Optra', 'Captiva', 'Aveo'],
    'Renault': ['Logan', 'Sandero', 'Duster'],
    'Volkswagen': ['Jetta', 'Passat', 'Tiguan'],
    'Honda': ['Civic', 'Accord', 'CR-V'],
  };

  final List<String> _colors = const [
    'White',
    'Black',
    'Silver',
    'Grey',
    'Blue',
    'Red',
    'Green',
    'Yellow',
    'Brown',
    'Gold',
  ];

  String? _selectedBrand;
  String? _selectedModel;
  String? _selectedColor;
  final TextEditingController _plateLettersController = TextEditingController();
  final TextEditingController _plateNumbersController = TextEditingController();
  final TextEditingController _yearController = TextEditingController();
  bool _isDefault = false;
  XFile? _pickedImage;
  Uint8List? _pickedImageBytes; // for web

  @override
  void dispose() {
    _plateLettersController.dispose();
    _plateNumbersController.dispose();
    _yearController.dispose();
    super.dispose();
  }

  Future<void> _pickImage() async {
    final ImagePicker picker = ImagePicker();
    final XFile? file = await picker.pickImage(
      source: ImageSource.gallery,
      imageQuality: 80,
    );
    if (file == null) return;
    if (kIsWeb) {
      final bytes = await file.readAsBytes();
      setState(() {
        _pickedImage = file;
        _pickedImageBytes = bytes;
      });
    } else {
      setState(() {
        _pickedImage = file;
        _pickedImageBytes = null;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.transparent,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new, color: Color(0xFF0D4A58)),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Add Car',
          style: TextStyle(
            fontFamily: 'Poppins',
            fontWeight: FontWeight.w700,
            fontSize: 22,
            color: Color(0xFF0D4A58),
          ),
        ),
        centerTitle: false,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _buildLabel('Car Brand'),
                _buildDropdown<String>(
                  value: _selectedBrand,
                  hint: 'Select Car Brand',
                  items: _brandToModels.keys.toList(),
                  onChanged: (val) {
                    setState(() {
                      _selectedBrand = val;
                      _selectedModel = null;
                    });
                  },
                  validator: (val) =>
                      val == null ? 'Please select brand' : null,
                ),

                const SizedBox(height: 16),
                _buildLabel('Car Model'),
                _buildDropdown<String>(
                  value: _selectedModel,
                  hint: 'Select Car Model',
                  items: (_selectedBrand != null)
                      ? _brandToModels[_selectedBrand]!
                      : <String>[],
                  onChanged: (val) => setState(() => _selectedModel = val),
                  validator: (val) =>
                      val == null ? 'Please select model' : null,
                ),

                const SizedBox(height: 16),
                _buildLabel('License Plate Number'),
                Row(
                  children: [
                    Expanded(
                      child: _buildTextField(
                        controller: _plateNumbersController,
                        hint: '1234',
                        keyboardType: TextInputType.number,
                        validator: (value) {
                          final text = (value ?? '').replaceAll(' ', '');
                          // Accept 3 or 4 digits
                          if (!RegExp(r'^\d{3,4}$').hasMatch(text)) {
                            return 'Enter 3 or 4 digits';
                          }
                          return null;
                        },
                      ),
                    ),
                    const SizedBox(width: 12),
                    Expanded(
                      child: Directionality(
                        textDirection: TextDirection.rtl,
                        child: _buildTextField(
                          controller: _plateLettersController,
                          hint: '٣ حروف عربية',
                          textInputAction: TextInputAction.next,
                          textCapitalization: TextCapitalization.none,
                          validator: (value) {
                            final text = (value ?? '').replaceAll(' ', '');
                            // Accept 2 or 3 Arabic letters (ا-ي)
                            final arabic = RegExp(
                              r'^[\u0621-\u063A\u0641-\u064A]{2,3}$',
                            );
                            if (!arabic.hasMatch(text)) {
                              return 'Enter 2 or 3 Arabic letters';
                            }
                            return null;
                          },
                        ),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 16),
                _buildLabel('Car Color'),
                _buildDropdown<String>(
                  value: _selectedColor,
                  hint: 'Select Color',
                  items: _colors,
                  onChanged: (val) => setState(() => _selectedColor = val),
                  validator: (val) =>
                      val == null ? 'Please select color' : null,
                ),

                const SizedBox(height: 16),
                _buildLabel('Year Of Manufacture'),
                _buildTextField(
                  controller: _yearController,
                  hint: 'e.g. 2020',
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    final year = int.tryParse((value ?? '').trim());
                    if (year == null ||
                        year < 1970 ||
                        year > DateTime.now().year) {
                      return 'Enter a valid year';
                    }
                    return null;
                  },
                ),

                const SizedBox(height: 16),
                _buildLabel('Upload Car Photo'),
                Row(
                  children: [
                    ElevatedButton(
                      onPressed: _pickImage,
                      style: ElevatedButton.styleFrom(
                        backgroundColor: const Color(0xFFE04703),
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        foregroundColor: Colors.white,
                        textStyle: const TextStyle(
                          fontFamily: 'Mulish',
                          fontWeight: FontWeight.w600,
                        ),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(6),
                        ),
                      ),
                      child: const Text('Upload Photo'),
                    ),
                    const SizedBox(width: 12),
                    if (_pickedImage != null)
                      ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: SizedBox(
                          width: 160,
                          height: 110,
                          child: kIsWeb && _pickedImageBytes != null
                              ? Image.memory(
                                  _pickedImageBytes!,
                                  fit: BoxFit.cover,
                                )
                              : Image.file(
                                  io.File(_pickedImage!.path),
                                  fit: BoxFit.cover,
                                ),
                        ),
                      ),
                  ],
                ),

                const SizedBox(height: 8),
                Row(
                  children: [
                    Checkbox(
                      value: _isDefault,
                      onChanged: (val) =>
                          setState(() => _isDefault = val ?? false),
                      activeColor: const Color(0xFFE04703),
                    ),
                    const Text(
                      'Set as a default car',
                      style: TextStyle(
                        fontFamily: 'Mulish',
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF0D4A58),
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 100),
              ],
            ),
          ),
        ),
      ),
      bottomNavigationBar: SafeArea(
        top: false,
        child: Padding(
          padding: const EdgeInsets.fromLTRB(16, 8, 16, 16),
          child: SizedBox(
            width: double.infinity,
            height: 50,
            child: ElevatedButton(
              onPressed: _submit,
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xFFE04703),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                foregroundColor: Colors.white,
                textStyle: const TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w700,
                  fontSize: 16,
                ),
              ),
              child: const Text('Add Car'),
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String title) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8),
      child: Text(
        title,
        style: const TextStyle(
          fontFamily: 'Poppins',
          fontWeight: FontWeight.w600,
          fontSize: 13,
          color: Color(0xFF0D4A58),
        ),
      ),
    );
  }

  Widget _buildDropdown<T>({
    required T? value,
    required String hint,
    required List<T> items,
    required void Function(T?) onChanged,
    String? Function(T?)? validator,
  }) {
    return DropdownButtonFormField<T>(
      value: value,
      items: items
          .map(
            (e) => DropdownMenuItem<T>(
              value: e,
              child: Text(
                '$e',
                style: const TextStyle(
                  fontFamily: 'Mulish',
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          )
          .toList(),
      onChanged: onChanged,
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Mulish',
          fontWeight: FontWeight.w500,
          color: Color(0xFF9AA7AE),
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF83B8C6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF83B8C6), width: 2),
        ),
      ),
      icon: const Icon(
        Icons.keyboard_arrow_down_rounded,
        color: Color(0xFF83B8C6),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    TextInputType? keyboardType,
    TextInputAction? textInputAction,
    TextCapitalization textCapitalization = TextCapitalization.none,
    String? Function(String?)? validator,
  }) {
    return TextFormField(
      controller: controller,
      keyboardType: keyboardType,
      textInputAction: textInputAction,
      textCapitalization: textCapitalization,
      style: const TextStyle(fontFamily: 'Mulish', fontWeight: FontWeight.w600),
      validator: validator,
      decoration: InputDecoration(
        hintText: hint,
        hintStyle: const TextStyle(
          fontFamily: 'Mulish',
          color: Color(0xFF9AA7AE),
          fontWeight: FontWeight.w500,
        ),
        contentPadding: const EdgeInsets.symmetric(
          horizontal: 12,
          vertical: 12,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF83B8C6)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.circular(8),
          borderSide: const BorderSide(color: Color(0xFF83B8C6), width: 2),
        ),
      ),
    );
  }

  void _submit() {
    if (!_formKey.currentState!.validate()) return;
    final plateLetters = _plateLettersController.text.trim().toUpperCase();
    final plateNumbers = _plateNumbersController.text.trim();
    final car = {
      'brand': _selectedBrand,
      'model': _selectedModel,
      'color': _selectedColor,
      'plate': '$plateLetters $plateNumbers',
      'year': _yearController.text.trim(),
      'isDefault': _isDefault,
      'photoPath': _pickedImage?.path,
    };
    Navigator.pop(context, car);
  }
}
