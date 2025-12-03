// import 'package:flutter/material.dart';
//
// class EmailFormField extends StatelessWidget {
//   final TextEditingController controller;
//
//   const EmailFormField({super.key, required this.controller});
//
//   bool _isValidEmail(String email) {
//     return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
//   }
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: controller,
//       keyboardType: TextInputType.emailAddress,
//       decoration: const InputDecoration(
//         hintText: 'Enter Your Email',
//         hintStyle: TextStyle(
//           fontSize: 15,
//           color: Color(0xFFBDBDBD),
//           fontWeight: FontWeight.w400,
//         ),
//         filled: true,
//         fillColor: Colors.white,
//         border: InputBorder.none,
//         enabledBorder: InputBorder.none,
//         focusedBorder: InputBorder.none,
//         errorBorder: InputBorder.none,
//         focusedErrorBorder: InputBorder.none,
//         contentPadding: EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 18,
//         ),
//         errorStyle: TextStyle(
//           fontSize: 11,
//           height: 0.8,
//           color: Colors.red,
//         ),
//         errorMaxLines: 1,
//       ),
//       style: const TextStyle(
//         fontSize: 15,
//         color: Colors.black,
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your email';
//         }
//         if (!_isValidEmail(value)) {
//           return 'Please enter a valid email';
//         }
//         return null;
//       },
//     );
//   }
// }