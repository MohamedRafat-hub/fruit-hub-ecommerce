import 'package:flutter/material.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/build_app_bar.dart';

class PaymentsView extends StatelessWidget {
  const PaymentsView({super.key});

  static const String routeName = "PaymentsView";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar:
            buildAppBar(title: 'المدفوعات', context: context, hasLeading: true),
        body: Center(
          child: Text(
            'لا يوجد مدفوعات بعد',
            style: TextStyle(
                fontSize: 20, color: Colors.grey, fontWeight: FontWeight.w600),
          ),
        ));
  }
}
