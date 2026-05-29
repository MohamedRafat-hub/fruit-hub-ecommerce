import 'package:flutter/material.dart';

import 'home_featured_item.dart';

class HomeFeaturedList extends StatelessWidget {
  const HomeFeaturedList({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) => HomeFeaturedItem(),
      itemCount: 1,
      scrollDirection: Axis.horizontal,
    );
  }
}