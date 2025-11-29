import 'package:flutter/material.dart';
import 'image_screen.dart';

class SetupAccountScreen extends StatefulWidget {
  const SetupAccountScreen({super.key});

  @override
  State<SetupAccountScreen> createState() => _SetupAccountScreenState();
}

class _SetupAccountScreenState extends State<SetupAccountScreen> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController salonNameController = TextEditingController();
  final TextEditingController locationController = TextEditingController();
  String? selectedSalonType;
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 19, minute: 0);
  bool _isSubmitting = false;

  final List<String> salonTypes = [
    'Unisex',
    'Men Only',
    'Women Only',
    'Kids Salon',
    'Spa & Wellness',
  ];

  String _formatTime(TimeOfDay time) {
    final hour = time.hourOfPeriod == 0 ? 12 : time.hourOfPeriod;
    final minute = time.minute.toString().padLeft(2, '0');
    final period = time.period == DayPeriod.am ? 'am' : 'pm';
    return '${hour.toString().padLeft(2, '0')}:$minute $period';
  }

  Future<void> _selectTime(bool isStartTime) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: isStartTime ? startTime : endTime,
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            timePickerTheme: TimePickerThemeData(
              backgroundColor: Colors.white,
              hourMinuteColor: const Color(0xFF1565C0).withOpacity(0.1),
              hourMinuteTextColor: const Color(0xFF1565C0),
              dialHandColor: const Color(0xFF1565C0),
              dialBackgroundColor: const Color(0xFFF5F5F5),
              dialTextColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? Colors.white
                      : const Color(0xFF1565C0)),
              entryModeIconColor: const Color(0xFF1565C0),
              dayPeriodColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? const Color(0xFF1565C0)
                      : Colors.transparent),
              dayPeriodTextColor: WidgetStateColor.resolveWith((states) =>
                  states.contains(WidgetState.selected)
                      ? Colors.white
                      : const Color(0xFF1565C0)),
              dayPeriodBorderSide: const BorderSide(
                  color: Color(0xFF1565C0), width: 1),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(24),
              ),
              hourMinuteShape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(12),
              ),
            ),
            colorScheme: const ColorScheme.light(
              primary: Color(0xFF1565C0),
              onPrimary: Colors.white,
              surface: Colors.white,
              onSurface: Color(0xFF1565C0),
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartTime) {
          startTime = picked;
        } else {
          endTime = picked;
        }
      });
    }
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
  }

  String? _validateRequired(String? value, String fieldName) {
    if (value == null || value.trim().isEmpty) {
      return 'Please enter $fieldName';
    }
    return null;
  }

  @override
  void dispose() {
    salonNameController.dispose();
    locationController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                // Back arrow
                Padding(
                  padding: const EdgeInsets.only(left: 16.0, top: 16.0),
                  child: Align(
                    alignment: Alignment.topLeft,
                    child: IconButton(
                      onPressed: () {
                        Navigator.pop(context);
                      },
                      icon: const Icon(
                        Icons.arrow_back,
                        color: Colors.black,
                        size: 28,
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 24.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(height: 20),
                      // Title
                      const Center(
                        child: Text(
                          'Setup Your Account',
                          style: TextStyle(
                            fontSize: 32,
                            fontWeight: FontWeight.bold,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 60),
                      // Salon Name Label
                      const Text(
                        'Salon Name',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Salon Name input field
                      Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: TextFormField(
                          controller: salonNameController,
                          validator: (value) => _validateRequired(value, 'salon name'),
                          decoration: const InputDecoration(
                            hintText: 'Enter Your Salon Name',
                            hintStyle: TextStyle(
                              fontSize: 16,
                              color: Colors.black38,
                            ),
                            border: InputBorder.none,
                            contentPadding: EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Salon Type Label
                      const Text(
                        'Salon Type',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Salon Type dropdown
                      Container(
                        height: 64,
                        padding: const EdgeInsets.symmetric(horizontal: 20),
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: DropdownButtonHideUnderline(
                          child: DropdownButton<String>(
                            value: selectedSalonType,
                            hint: const Text(
                              'Select Salon type Ex: Unisex',
                              style: TextStyle(
                                color: Colors.black38,
                                fontSize: 16,
                              ),
                            ),
                            isExpanded: true,
                            icon: const Icon(Icons.keyboard_arrow_down,
                                color: Colors.black38),
                            items: salonTypes.map((type) {
                              return DropdownMenuItem(
                                value: type,
                                child: Text(
                                  type,
                                  style: const TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                  ),
                                ),
                              );
                            }).toList(),
                            onChanged: (value) =>
                                setState(() => selectedSalonType = value),
                          ),
                        ),
                      ),
                      const SizedBox(height: 24),
                      // Working Hours Label
                      const Text(
                        'Working Hours',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Working Hours time pickers
                      Row(
                        children: [
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectTime(true),
                              child: Container(
                                height: 64,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatTime(startTime),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.black38,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                          const SizedBox(width: 16),
                          Expanded(
                            child: GestureDetector(
                              onTap: () => _selectTime(false),
                              child: Container(
                                height: 64,
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: Colors.grey.shade300,
                                    width: 1.5,
                                  ),
                                ),
                                child: Row(
                                  children: [
                                    Expanded(
                                      child: Text(
                                        _formatTime(endTime),
                                        style: const TextStyle(
                                          fontSize: 16,
                                          color: Colors.black,
                                        ),
                                      ),
                                    ),
                                    const Icon(
                                      Icons.access_time,
                                      color: Colors.black38,
                                      size: 20,
                                    ),
                                  ],
                                ),
                              ),
                            ),
                          ),
                        ],
                      ),
                      const SizedBox(height: 24),
                      // Location Label
                      const Text(
                        'Set Your Salon Location',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.black87,
                        ),
                      ),
                      const SizedBox(height: 12),
                      // Location input field
                      Container(
                        height: 64,
                        decoration: BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: TextFormField(
                          controller: locationController,
                          validator: (value) => _validateRequired(value, 'location'),
                          decoration: InputDecoration(
                            hintText: 'High level road, Maharagama, Sri Lanka',
                            hintStyle: const TextStyle(
                              fontSize: 16,
                              color: Colors.black38,
                            ),
                            suffixIcon: Icon(
                              Icons.location_on,
                              color: Colors.grey.shade400,
                            ),
                            border: InputBorder.none,
                            contentPadding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 20),
                          ),
                          style: const TextStyle(
                            fontSize: 16,
                            color: Colors.black,
                          ),
                        ),
                      ),
                      const SizedBox(height: 8),
                      Text(
                        'Click on the map to pick location',
                        style: TextStyle(
                          fontSize: 14,
                          color: Colors.grey.shade600,
                        ),
                      ),
                      const SizedBox(height: 16),
                      // Map Placeholder
                      Container(
                        height: 200,
                        decoration: BoxDecoration(
                          color: const Color(0xFFF5F5F5),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(
                            color: Colors.grey.shade300,
                            width: 1.5,
                          ),
                        ),
                        child: Stack(
                          children: [
                            Center(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                children: [
                                  Container(
                                    width: 56,
                                    height: 56,
                                    decoration: BoxDecoration(
                                      color: const Color(0xFF1565C0)
                                          .withOpacity(0.1),
                                      shape: BoxShape.circle,
                                    ),
                                    child: const Icon(
                                      Icons.location_on,
                                      color: Color(0xFF1565C0),
                                      size: 28,
                                    ),
                                  ),
                                  const SizedBox(height: 12),
                                  Text(
                                    'Map View',
                                    style: TextStyle(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                      color: Colors.grey.shade700,
                                    ),
                                  ),
                                  const SizedBox(height: 4),
                                  Text(
                                    'Location picker will appear here',
                                    style: TextStyle(
                                      fontSize: 14,
                                      color: Colors.grey.shade500,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            // Map marker
                            Positioned(
                              top: 60,
                              left: 0,
                              right: 0,
                              child: Icon(
                                Icons.location_on,
                                color: Colors.red.shade600,
                                size: 32,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(height: 40),
                      // Next Button
                      SizedBox(
                        width: double.infinity,
                        height: 56,
                        child: ElevatedButton(
                          onPressed: _isSubmitting
                              ? null
                              : () async {
                                  // Validate form
                                  if (!_formKey.currentState!.validate()) {
                                    return;
                                  }
                                  
                                  // Check salon type selection
                                  if (selectedSalonType == null) {
                                    _showErrorSnackBar('Please select a salon type');
                                    return;
                                  }

                                  setState(() => _isSubmitting = true);

                                  // Simulate processing
                                  await Future.delayed(const Duration(milliseconds: 500));

                                  if (!mounted) return;

                                  setState(() => _isSubmitting = false);

                                  // Navigate to Upload Salon Image Screen
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) => const UploadSalonImageScreen(),
                                    ),
                                  );
                                },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: const Color(0xFF1565C0),
                            foregroundColor: Colors.white,
                            disabledBackgroundColor: Colors.grey.shade400,
                            shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12),
                            ),
                            elevation: 0,
                          ),
                          child: _isSubmitting
                              ? const SizedBox(
                                  width: 24,
                                  height: 24,
                                  child: CircularProgressIndicator(
                                    color: Colors.white,
                                    strokeWidth: 2,
                                  ),
                                )
                              : const Text(
                                  'Next',
                                  style: TextStyle(
                                    fontSize: 18,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                        ),
                      ),
                      const SizedBox(height: 24),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}