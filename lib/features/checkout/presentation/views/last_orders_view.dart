import 'package:flutter/material.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/build_app_bar.dart';

class LastOrdersView extends StatelessWidget {
  const LastOrdersView({super.key});
  static const String routeName = 'last-orders';
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: 'طلباتي', context: context , hasLeading: true),
    );
  }
}
