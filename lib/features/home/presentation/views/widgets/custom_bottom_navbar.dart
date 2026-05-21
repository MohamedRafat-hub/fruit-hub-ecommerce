import 'package:flutter/material.dart';

import '../main_view.dart';
import 'bottom_navbar_item.dart';

class CustomBottomNavBar extends StatelessWidget {

  const CustomBottomNavBar({
    super.key,
    required this.onItemTapped,
    required this.currentIndex,
  });

  final ValueChanged<int> onItemTapped;
  final int currentIndex;

  @override
  Widget build(BuildContext context) {

    return Container(
      height: 70,

      decoration: ShapeDecoration(
        color: Colors.white,

        shape: const RoundedRectangleBorder(
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(30),
            topRight: Radius.circular(30),
          ),
        ),

        shadows: const [
          BoxShadow(
            color: Color(0x19000000),
            blurRadius: 25,
            offset: Offset(0, -2),
            spreadRadius: 0,
          )
        ],
      ),

      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,

        children: bottomNavBarItems.asMap().entries.map((e) {

          var index = e.key;
          var entity = e.value;

          return GestureDetector(

            onTap: () {

              onItemTapped(index);

            },

            child: BottomNavBarItem(

              isSelected: currentIndex == index,

              bottomNavBarEntity: entity,
            ),
          );
        }).toList(),
      ),
    );
  }
}