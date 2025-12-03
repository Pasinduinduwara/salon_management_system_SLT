// import 'package:flutter/material.dart';
//
// class PasswordFormField extends StatefulWidget {
//   final TextEditingController controller;
//
//   const PasswordFormField({super.key, required this.controller});
//
//   @override
//   State<PasswordFormField> createState() => _PasswordFormFieldState();
// }
//
// class _PasswordFormFieldState extends State<PasswordFormField> {
//   bool _obscurePassword = true;
//
//   @override
//   Widget build(BuildContext context) {
//     return TextFormField(
//       controller: widget.controller,
//       obscureText: _obscurePassword,
//       keyboardType: TextInputType.visiblePassword,
//       decoration: InputDecoration(
//         hintText: 'Enter Your Password',
//         hintStyle: const TextStyle(
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
//         contentPadding: const EdgeInsets.symmetric(
//           horizontal: 16,
//           vertical: 18,
//         ),
//         suffixIcon: IconButton(
//           icon: Icon(
//             _obscurePassword ? Icons.visibility_off_outlined : Icons.visibility_outlined,
//             color: Colors.grey.shade400,
//             size: 22,
//           ),
//           onPressed: () {
//             setState(() {
//               _obscurePassword = !_obscurePassword;
//             });
//           },
//         ),
//         errorStyle: const TextStyle(
//           fontSize: 11,
//           height: 0.8,
//           color: Colors.red,
//         ),
//         errorMaxLines: 1,
//         isDense: true,
//       ),
//       style: const TextStyle(
//         fontSize: 15,
//         color: Colors.black,
//       ),
//       validator: (value) {
//         if (value == null || value.isEmpty) {
//           return 'Please enter your password';
//         }
//         if (value.length < 6) {
//           return 'Password must be at least 6 characters';
//         }
//         return null;
//       },
//     );
//   }
// }