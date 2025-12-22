import 'package:flutter/material.dart';
import '../../../data/services/auth_service.dart';
import '../auth/widgets/salon_name_form_field.dart';
import '../auth/widgets/location_form_field.dart';
import '../auth/widgets/working_hours_picker.dart';
import '../auth/widgets/salon_type_dropdown.dart';

class EditProfilePage extends StatefulWidget {
  final Map<String, dynamic> salonData;
  const EditProfilePage({Key? key, required this.salonData}) : super(key: key);

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  late TextEditingController nameController;
  late TextEditingController emailController;
  late TextEditingController locationController;
  TimeOfDay startTime = const TimeOfDay(hour: 9, minute: 0);
  TimeOfDay endTime = const TimeOfDay(hour: 19, minute: 0);
  String? selectedSalonType;
  final List<String> salonTypes = [
    'Unisex',
    'Men Only',
    'Women Only',
    'Kids Salon',
    'Spa & Wellness',
  ];

  @override
  void initState() {
    super.initState();
    nameController = TextEditingController(
      text: widget.salonData['name'] ?? '',
    );
    emailController = TextEditingController(
      text: widget.salonData['email'] ?? '',
    );
    locationController = TextEditingController(
      text: widget.salonData['location'] ?? '',
    );
    final type = widget.salonData['salonType'];
    if (type is String && salonTypes.contains(type)) {
      selectedSalonType = type;
    } else {
      selectedSalonType = null;
    }
    final workingHours = widget.salonData['workingHours'] ?? {};
    if (workingHours is Map<String, dynamic>) {
      final start = workingHours['start'] ?? '';
      final end = workingHours['end'] ?? '';
      if (start is String && start.isNotEmpty) {
        final parts = start.split(":");
        if (parts.length == 2) {
          final hour = int.tryParse(parts[0]) ?? 9;
          final minute = int.tryParse(parts[1].split(' ')[0]) ?? 0;
          startTime = TimeOfDay(hour: hour, minute: minute);
        }
      }
      if (end is String && end.isNotEmpty) {
        final parts = end.split(":");
        if (parts.length == 2) {
          final hour = int.tryParse(parts[0]) ?? 19;
          final minute = int.tryParse(parts[1].split(' ')[0]) ?? 0;
          endTime = TimeOfDay(hour: hour, minute: minute);
        }
      }
    }
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    locationController.dispose();
    super.dispose();
  }

  bool _isSaving = false;

  Future<void> _saveProfile() async {
    setState(() => _isSaving = true);
    try {
      final id = widget.salonData['id'] ?? widget.salonData['_id'];
      if (id == null) throw Exception('Salon ID not found');
      String formatTime(TimeOfDay t) {
        final hour = t.hour.toString().padLeft(2, '0');
        final minute = t.minute.toString().padLeft(2, '0');
        final period = t.period == DayPeriod.am ? 'am' : 'pm';
        return '$hour:$minute $period';
      }

      await AuthService.updateOwnerProfile(
        id: id,
        name: nameController.text.trim(),
        email: emailController.text.trim(),
        location: locationController.text.trim(),
        salonType: selectedSalonType,
        workingHoursStart: formatTime(startTime),
        workingHoursEnd: formatTime(endTime),
      );
      if (mounted) {
        // Update local salonData so dropdown shows new value if page is reopened
        widget.salonData['salonType'] = selectedSalonType;
        Navigator.pop(context, true);
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text('Profile updated successfully!')),
        );
      }
    } catch (e) {
      if (mounted) {
        ScaffoldMessenger.of(
          context,
        ).showSnackBar(SnackBar(content: Text('Failed to update profile: $e')));
      }
    } finally {
      if (mounted) setState(() => _isSaving = false);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Icon(Icons.arrow_back, color: Colors.black, size: 28),
        ),
        title: const Text(
          'Edit Profile',
          style: TextStyle(
            fontSize: 24,
            fontWeight: FontWeight.bold,
            color: Colors.black,
          ),
        ),
        centerTitle: true,
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 24.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(height: 40),
                SalonNameFormField(controller: nameController),
                const SizedBox(height: 24),
                // Email field (not editable for now)
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text(
                      'Email',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    TextFormField(
                      controller: emailController,
                      readOnly: true,
                      decoration: InputDecoration(
                        hintText: 'Email',
                        filled: true,
                        fillColor: Colors.grey.shade100,
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                        enabledBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: BorderSide(
                            color: Colors.grey.shade300,
                            width: 1.0,
                          ),
                        ),
                        focusedBorder: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(8),
                          borderSide: const BorderSide(
                            color: Colors.blue,
                            width: 2.0,
                          ),
                        ),
                        contentPadding: const EdgeInsets.symmetric(
                          horizontal: 20,
                          vertical: 20,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 24),
                SalonTypeDropdown(
                  selectedSalonType: selectedSalonType,
                  onChanged: (value) =>
                      setState(() => selectedSalonType = value),
                  salonTypes: salonTypes,
                ),
                const SizedBox(height: 24),
                WorkingHoursPicker(
                  startTime: startTime,
                  endTime: endTime,
                  onStartTimeChanged: (time) =>
                      setState(() => startTime = time),
                  onEndTimeChanged: (time) => setState(() => endTime = time),
                ),
                const SizedBox(height: 24),
                LocationFormField(controller: locationController),
                const SizedBox(height: 40),
                SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _isSaving ? null : _saveProfile,
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue.shade900,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12),
                      ),
                    ),
                    child: _isSaving
                        ? const SizedBox(
                            width: 24,
                            height: 24,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2.5,
                            ),
                          )
                        : const Text(
                            'Save Changes',
                            style: TextStyle(
                              fontSize: 17,
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                  ),
                ),
                const SizedBox(height: 24),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
