
import 'package:flutter/material.dart';

ScaffoldFeatureController<SnackBar, SnackBarClosedReason> showSnackBar(BuildContext context , {required String message , Color? color}) {
  return ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Center(
        child: Text(message , style: TextStyle(
          color: Colors.white,
          fontSize: 14,
          fontFamily: 'Cairo',
          fontWeight: FontWeight.w400,
          height: 1.60,
        ),),
      ), backgroundColor: color ?? Colors.green, duration: Duration(seconds: 2),)
  );
}
