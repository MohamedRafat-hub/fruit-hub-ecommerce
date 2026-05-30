import 'package:flutter/material.dart';

import '../utils/app_colors.dart';

class CustomMaterialButton extends StatelessWidget {
  const CustomMaterialButton({
    super.key,
    this.onPressed,
    required this.buttonName,
    this.color,
    this.isLoading = false, // ✅
  });

  final void Function()? onPressed;
  final String buttonName;
  final Color? color;
  final bool isLoading; // ✅

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      height: 50,
      onPressed: isLoading ? null : onPressed, // ✅ متضغطش وهو بيلود
      child: isLoading
          ? CircularProgressIndicator(color: AppColors.primaryColor) // ✅
          : Text(
        buttonName,
        style: TextStyle(
          color: Colors.white,
          fontSize: 16,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w700,
        ),
      ),
      color: color ?? AppColors.primaryColor,
      minWidth: double.infinity,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
    );
  }
}