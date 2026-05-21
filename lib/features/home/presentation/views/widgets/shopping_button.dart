import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:fruit_hub/features/home/presentation/views/main_view.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/custom_bottom_navbar.dart';
import 'package:provider/provider.dart';

import '../../../../../core/utils/app_colors.dart';

class ShoppingButton extends StatelessWidget {
  const ShoppingButton({super.key, this.onPressed});
  final void Function()? onPressed;
  @override
  Widget build(BuildContext context) {
    return MaterialButton(
      onPressed: (){
        Provider.of<BottomNavProvider>(context , listen: false).changeIndex(1);
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