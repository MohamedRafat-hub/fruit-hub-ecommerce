import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/services/database_service.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/getProfileDataCubit/get_profile_data_cubit.dart';
import 'package:fruit_hub/features/auth/presentation/views/login_view.dart';
import 'package:fruit_hub/features/auth/presentation/views/my_account_view.dart';
import 'package:fruit_hub/features/auth/presentation/views/signup_view.dart';
import 'package:fruit_hub/features/best_selling_fruits/presentation/views/best_selling_view.dart';
import 'package:fruit_hub/features/checkout/presentation/views/checkout_view.dart';
import 'package:fruit_hub/features/checkout/presentation/views/payments_view.dart';
import 'package:fruit_hub/features/home/domain/entities/cart_entity.dart';
import 'package:fruit_hub/features/home/domain/entities/cart_item_entity.dart';
import 'package:fruit_hub/features/home/presentation/views/favourite_products_view.dart';
import 'package:fruit_hub/features/home/presentation/views/main_view.dart';
import 'package:fruit_hub/features/home/presentation/views/products_view.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/about_us_view.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/home_view.dart';
import 'package:fruit_hub/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:fruit_hub/features/splash/presentation/views/splah_view.dart';

import '../services/git_it_service.dart';

Route<dynamic> onGenerateRoute(RouteSettings settings) {
  switch (settings.name) {
    case SplashView.routeName:
      return MaterialPageRoute(builder: (context) => SplashView());
    case ProductsView.routeName:
      return MaterialPageRoute(builder: (context) => ProductsView());
    case OnboardingView.routeName:
      return MaterialPageRoute(builder: (context) => OnboardingView());
    case LoginView.routeName:
      return MaterialPageRoute(builder: (context) => LoginView());
    case SignupView.routeName:
      return MaterialPageRoute(builder: (context) => SignupView());
    case MainView.routeName:
      return MaterialPageRoute(builder: (context) => MainView());
    case BestSellingView.routeName :
      return MaterialPageRoute(builder: (context) => BestSellingView());
    case HomeView.routeName:
      return MaterialPageRoute(builder: (context) => HomeView());
    case CheckoutView.routeName:
      return MaterialPageRoute(builder: (context) =>
          CheckoutView(
            cartEntity: settings.arguments as CartEntity,
          ));
    case FavouriteProductsView.routeName :
      return MaterialPageRoute(builder: (context) => FavouriteProductsView());
    case AboutUsView.routeName :
      return MaterialPageRoute(builder: (context) => AboutUsView());
    case MyAccountView.routeName :
      return MaterialPageRoute(builder: (context) =>
          BlocProvider(
            create: (context) => GetProfileDataCubit(fireStoreService: getIt.get<DatabaseService>()),
            child: MyAccountView(),
          ));
    case PaymentsView.routeName:
      return MaterialPageRoute(builder: (context) => PaymentsView());
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
