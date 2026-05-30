import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/services/database_service.dart';
import 'package:fruit_hub/core/services/git_it_service.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/getProfileDataCubit/get_profile_data_cubit.dart';
import 'package:fruit_hub/features/auth/presentation/views/profile_view.dart';
import 'package:fruit_hub/features/home/domain/repos/favourite_repo.dart';
import 'package:fruit_hub/features/home/presentation/managers/cartCubit/cart_cubit.dart';
import 'package:fruit_hub/features/home/presentation/managers/favouriteCubit/favourite_cubit.dart';
import 'package:fruit_hub/features/home/presentation/views/cart_view.dart';
import 'package:fruit_hub/features/home/presentation/views/products_view.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/custom_bottom_navbar.dart';
import 'package:fruit_hub/features/home/presentation/views/home_view.dart';
import 'package:provider/provider.dart';

import '../../../../core/helper_functions/build_show_snack_bar.dart';
import '../../domain/entities/bottom_navbar_entity.dart';

class MainView extends StatelessWidget {
  const MainView({super.key});

  static const routeName = 'HomeView';

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
        create: (context) => BottomNavProvider(), child: MainViewBody());
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

class BottomNavProvider extends ChangeNotifier {
  int currentIndex = 0;

  void changeIndex(int index) {
    currentIndex = index;
    notifyListeners();
  }
}

class MainViewBody extends StatefulWidget {
  const MainViewBody({super.key});

  @override
  State<MainViewBody> createState() => _MainViewBodyState();
}

class _MainViewBodyState extends State<MainViewBody> {
  @override
  Widget build(BuildContext context) {

    final bottomNavProvider = Provider.of<BottomNavProvider>(context);
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => GetProfileDataCubit(
            fireStoreService: getIt.get<DatabaseService>(),
          )..getProfileData(
            uid: FirebaseAuth.instance.currentUser!.uid,
          ),
        ),

        BlocProvider<FavouriteCubit>(
          create: (context) => FavouriteCubit(
            favouriteRepo: getIt.get<FavouriteRepo>(),
          ),
        ),
      ],

      child: Scaffold(
        body: BlocListener<CartCubit, CartState>(
          listener: (context, state) {

            if (state is CartItemAdded) {

              showSnackBar(
                context,
                message: 'تم إضافة المنتج إلى سلة التسوق بنجاح',
              );

            } else if (state is CartItemRemoved) {

              showSnackBar(
                context,
                message: 'تم حذف المنتج من سلة التسوق',
              );
            }
          },

          child: IndexedStack(
            index: bottomNavProvider.currentIndex,

            children: const [
              HomeView(),
              ProductsView(),
              CartView(),
              ProfileView(),
            ],
          ),
        ),

        bottomNavigationBar: CustomBottomNavBar(
          currentIndex: bottomNavProvider.currentIndex,
          onItemTapped: (int index) {
            bottomNavProvider.changeIndex(index);
          },
        ),
      ),
    );
  }
}
