import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/features/auth/presentation/views/profile_view.dart';
import 'package:fruit_hub/features/home/presentation/managers/cartCubit/cart_cubit.dart';
import 'package:fruit_hub/features/home/presentation/views/cart_view.dart';
import 'package:fruit_hub/features/home/presentation/views/products_view.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/custom_bottom_navbar.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/home_view.dart';

import '../../../../core/helper_functions/build_show_snack_bar.dart';
import '../../domain/entities/bottom_navbar_entity.dart';

class MainView extends StatefulWidget {
  const MainView({super.key});

  static const routeName = 'HomeView';

  @override
  State<MainView> createState() => _MainViewState();
}

class _MainViewState extends State<MainView> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => CartCubit(),
      child: Scaffold(
        body: BlocListener<CartCubit, CartState>(
          listener: (context, state) {
            if (state is CartItemAdded) {
              showSnackBar(context,
                  message: 'تم إضافة المنتج إلى سلة التسوق بنجاح');
            } else if (state is CartItemRemoved) {
              showSnackBar(context, message: 'تم حذف المنتج من سلة التسوق');
            }
          },
          child: IndexedStack(
            index: currentIndex,
            children: [
              HomeView(),
              ProductsView(),
              CartView(),
              ProfileView(),
            ],
          ),
        ),
        bottomNavigationBar: CustomBottomNavBar(
          onItemTapped: (int index) {
            setState(() {
              currentIndex = index;
            });
          },
        ),
      ),
    );
  }
}

List<BottomNavBarEntity> get bottomNavBarItems => [
      BottomNavBarEntity(
          activeIcon: 'assets/icons/home_active_icon.svg',
          inActiveIcon: 'assets/icons/home_icon.svg',
          title: ' الرئيسية '),
      BottomNavBarEntity(
          activeIcon: 'assets/icons/products_active_icon.svg',
          inActiveIcon: 'assets/icons/products_icon.svg',
          title: ' المنتجات '),
      BottomNavBarEntity(
          activeIcon: 'assets/icons/cart_active_icon.svg',
          inActiveIcon: 'assets/icons/cart_icon.svg',
          title: ' سلة التسوق '),
      BottomNavBarEntity(
          activeIcon: 'assets/icons/user_active_icon.svg',
          inActiveIcon: 'assets/icons/user_icon.svg',
          title: ' حسابي '),
    ];
