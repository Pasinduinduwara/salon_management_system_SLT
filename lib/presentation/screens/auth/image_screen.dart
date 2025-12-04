import 'dart:io';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/file_info_display.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/finish_setup_button.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/image_picker_box.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/upload_image_app_bar.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/interactive_map_picker.dart';
import 'package:owner_salon_management/presentation/screens/home/dashboard.dart';

class UploadSalonImageScreen extends StatefulWidget {
  const UploadSalonImageScreen({super.key});

  @override
  State<UploadSalonImageScreen> createState() => _UploadSalonImageScreenState();
}

class _UploadSalonImageScreenState extends State<UploadSalonImageScreen> {
  File? selectedImage;
  LatLng? _selectedLocation;
  String? _selectedAddress;

  void _onLocationSelected(LatLng location, String address) {
    setState(() {
      _selectedLocation = location;
      _selectedAddress = address;
    });
    debugPrint('Location selected: $location, Address: $address');
  }

  void _finishSetup() {
    // Validate image selection
    if (selectedImage == null) {
      _showErrorSnackBar('Please select an image');
      return;
    }
    
    // Validate image file
    if (!_isValidImageFile(selectedImage!)) {
      _showErrorSnackBar('Please select a valid image file (JPG, PNG, or GIF)');
      return;
    }
    
    // Validate location selection (both coordinates and address)
    if (_selectedLocation == null) {
      _showErrorSnackBar('Please select your salon location from the map');
      return;
    }
    
    if (_selectedAddress == null || _selectedAddress!.isEmpty) {
      _showErrorSnackBar('Please ensure a valid address is selected');
      return;
    }
    
    // All validations passed
    debugPrint('Image uploaded: ${selectedImage!.path}');
    debugPrint('Location: $_selectedLocation, Address: $_selectedAddress');
    _showSuccessSnackBar('Setup completed successfully!');
    // Navigate to dashboard after successful setup
    Future.delayed(const Duration(seconds: 1), () {
      Navigator.of(context).pushAndRemoveUntil(
        MaterialPageRoute(builder: (context) => const Dashboard()),
        (route) => false,
      );
    });
  }

  bool _isValidImageFile(File file) {
    final extension = file.path.split('.').last.toLowerCase();
    return ['jpg', 'jpeg', 'png', 'gif'].contains(extension);
  }

  void _showSuccessSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.green,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(8),
        ),
        margin: const EdgeInsets.all(16),
      ),
    );
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECECEC),
      appBar: const UploadImageAppBar(),
      body: SafeArea(
        child: Column(
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 24.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'Add a professional photo of your salon to attract more customers',
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                        height: 1.4,
                      ),
                      textAlign: TextAlign.center,
                    ),
                    const SizedBox(height: 40),
                    ImagePickerBox(
                      selectedImage: selectedImage,
                      onImageSelected: (image) {
                        setState(() {
                          selectedImage = image;
                        });
                      },
                    ),
                    const SizedBox(height: 16),
                    FileInfoDisplay(selectedImage: selectedImage),
                    const SizedBox(height: 24),
                    // Salon Location Section
                    const Text(
                      'Salon Location',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
                    ),
                    const SizedBox(height: 12),
                    Text(
                      _selectedAddress ?? 'Select your salon location from the map',
                      style: TextStyle(
                        fontSize: 14,
                        color: _selectedAddress != null ? Colors.black87 : Colors.grey.shade600,
                        fontWeight: FontWeight.w400,
                      ),
                    ),
                    const SizedBox(height: 16),
                    InteractiveMapPicker(
                      onLocationSelected: _onLocationSelected,
                      initialLocation: _selectedLocation,
                      initialAddress: _selectedAddress,
                    ),
                    const SizedBox(height: 24),
                    // Image Guidelines
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: const Color(0xFF1565C0).withOpacity(0.1),
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: const Color(0xFF1565C0).withOpacity(0.3),
                          width: 1,
                        ),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              Icon(
                                Icons.info_outline,
                                color: const Color(0xFF1565C0),
                                size: 20,
                              ),
                              const SizedBox(width: 8),
                              const Text(
                                'Image Guidelines',
                                style: TextStyle(
                                  fontSize: 14,
                                  fontWeight: FontWeight.w600,
                                  color: Color(0xFF1565C0),
                                ),
                              ),
                            ],
                          ),
                          const SizedBox(height: 8),
                          Text(
                            '• High-quality, well-lit photos\n• Show your salon\'s interior or exterior\n• No text or logos overlaid on image\n• Recommended size: 1080x720 pixels',
                            style: TextStyle(
                              fontSize: 12,
                              color: Colors.grey.shade700,
                              height: 1.4,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(24.0),
              child: FinishSetupButton(onPressed: _finishSetup),
            ),
          ],
        ),
      ),
    );
  }
}