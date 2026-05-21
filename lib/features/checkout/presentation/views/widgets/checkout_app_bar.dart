import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_text.dart';

AppBar checkoutAppBar({required String title , void Function()? onPressed}) {
  return AppBar(
    backgroundColor: Colors.transparent,
    leading: IconButton(
      onPressed: onPressed,
      icon: const Icon(
        Icons.arrow_back_ios,
        color: Color(0xFF0C0D0D),
      ),
    ),
    centerTitle: true,
    title: CustomText(
        text: title,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF0C0D0D)),
  );
}