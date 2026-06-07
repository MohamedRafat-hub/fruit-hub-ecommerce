import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cubits/theme_cubit.dart';

class CustomTextFormField extends StatelessWidget {
  const CustomTextFormField({
    super.key,
    required this.hintText,
    required this.keyboardType,
    this.icon,
    this.onSaved,
    this.obscureText = false,
    this.controller,
    this.readOnly = false,
    this.isPhoneNumber = false,
    this.stringOnly = false,
  });

  final String hintText;
  final TextInputType keyboardType;
  final Widget? icon;
  final void Function(String?)? onSaved;
  final bool obscureText;
  final TextEditingController? controller;
  final bool readOnly;
  final bool isPhoneNumber;
  final bool stringOnly;

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      readOnly: readOnly,
      controller: controller,
      obscureText: obscureText,
      onChanged: onSaved,
      validator: (value) {
        if (value == null || value.isEmpty) {
          return 'هذا الحقل مطلوب';
        }
        if (isPhoneNumber == true) {
          if (!RegExp(r'^[0-9]+$').hasMatch(value)) {
            return 'رقم الهاتف يجب أن يحتوي على أرقام فقط';
          }

          if (value.length != 11) {
            return 'رقم الهاتف يجب أن يكون 11 رقم';
          }
        }
        if (stringOnly) {
          if (!RegExp(r'^[a-zA-Z\u0600-\u06FF\s]+$').hasMatch(value)) {
            return 'يجب إدخال حروف فقط';
          }
        }
        return null;
      },
      keyboardType: keyboardType,
      decoration: InputDecoration(
          suffixIcon: icon,
          hintText: hintText,
          hintStyle: TextStyle(
              color: const Color(0xFF949D9E),
              fontSize: 13,
              fontWeight: FontWeight.w700),
          filled: true,
          fillColor: context.read<ThemeCubit>().state == ThemeMode.dark
              ? Color(0xFF1C1C1C)
              : Colors.white,
          border: buildBorder(),
          enabledBorder: buildBorder()),
    );
  }

  OutlineInputBorder buildBorder() {
    return OutlineInputBorder(
        borderRadius: BorderRadius.circular(8),
        borderSide: BorderSide(
          width: 1,
          color: Color(0xFFE6E9E9),
        ));
  }
}
