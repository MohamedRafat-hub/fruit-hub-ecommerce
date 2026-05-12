import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_text.dart';

AppBar buildAppBar({required String title}) {
  return AppBar(
    centerTitle: true,
    title: CustomText(
        text: title,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF0C0D0D)),
    backgroundColor: Colors.transparent,
    elevation: 0,
      // surfaceTintColor: Colors.transparent,
  );
}