import 'package:flutter/material.dart';

import '../../../../../core/utils/app_colors.dart';

class ShoppingButton extends StatelessWidget {
  const ShoppingButton({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: () {
        Navigator.pushNamed(context, 'products_view');    
      },
      padding: EdgeInsets.symmetric(horizontal: 24 , vertical: 8),
      child: Text(
        'تسوق الان',
        style: TextStyle(
          color: AppColors.primaryColor,
          fontSize: 13,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w700,
        ),
      ),
      color: Colors.white,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(8),
      ),
    );

  }
}