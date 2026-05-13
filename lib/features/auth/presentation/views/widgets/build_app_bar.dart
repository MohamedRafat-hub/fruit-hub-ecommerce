import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../../../../core/widgets/custom_text.dart';

AppBar buildAppBar(
    {required String title,
    bool? hasLeading = true,
    required BuildContext context}) {
  return AppBar(
    automaticallyImplyLeading: false,
    centerTitle: true,
    title: CustomText(
        text: title,
        fontSize: 20,
        fontWeight: FontWeight.w700,
        color: const Color(0xFF0C0D0D)),
    backgroundColor: Colors.transparent,
    elevation: 0,
    leading: hasLeading!
        ? IconButton(
            onPressed: () {
              Navigator.pop(context);
            },
            icon: Icon(CupertinoIcons.back))
        : null,
    // surfaceTintColor: Colors.transparent,
  );
}
