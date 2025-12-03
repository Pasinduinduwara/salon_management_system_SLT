import 'dart:io';
import 'package:flutter/material.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/file_info_display.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/finish_setup_button.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/image_picker_box.dart';
import 'package:owner_salon_management/presentation/screens/auth/widgets/upload_image_app_bar.dart';

class UploadSalonImageScreen extends StatefulWidget {
  const UploadSalonImageScreen({super.key});

  @override
  State<UploadSalonImageScreen> createState() => _UploadSalonImageScreenState();
}

class _UploadSalonImageScreenState extends State<UploadSalonImageScreen> {
  File? selectedImage;

  void _finishSetup() {
    if (selectedImage != null) {
      debugPrint('Image uploaded: ${selectedImage!.path}');
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Setup completed successfully!'),
          backgroundColor: Color(0xFF00C853),
        ),
      );
      // TODO: Navigate to home screen
      // Navigator.pushReplacementNamed(context, '/home');
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Please select an image'),
          backgroundColor: Color(0xFFFF0000),
        ),
      );
    }
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
                    const Text(
                      'Upload Salon Image',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w600,
                        color: Colors.black87,
                      ),
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