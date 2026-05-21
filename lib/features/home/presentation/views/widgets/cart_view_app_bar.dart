import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../main_view.dart';

class CartViewAppBar extends StatelessWidget {
  const CartViewAppBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        IconButton(
          onPressed: () {
            Provider.of<BottomNavProvider>(context , listen: false).changeIndex(0);
          },
          icon: Icon(Icons.arrow_back_ios),
        ),
        Spacer(),
        Text(
          'السلة',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
          ),
        ),
        Spacer(flex: 2),
      ],
    );
  }
}