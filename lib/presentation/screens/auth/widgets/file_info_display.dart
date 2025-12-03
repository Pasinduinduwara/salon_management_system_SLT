import 'dart:io';
import 'package:flutter/material.dart';

class FileInfoDisplay extends StatelessWidget {
  final File? selectedImage;

  const FileInfoDisplay({super.key, this.selectedImage});

  String _getFileName() {
    if (selectedImage == null) return 'salon.png.jpg';
    return selectedImage!.path.split('/').last;
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 8,
          ),
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(8),
            border: Border.all(
              color: Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: const Text(
            'Choose File',
            style: TextStyle(
              fontSize: 14,
              color: Colors.black54,
            ),
          ),
        ),
        const SizedBox(width: 12),
        Text(
          _getFileName(),
          style: TextStyle(
            fontSize: 14,
            color: Colors.grey.shade600,
          ),
        ),
      ],
    );
  }
}
