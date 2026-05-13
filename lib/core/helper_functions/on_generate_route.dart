import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_hub/features/auth/presentation/views/login_view.dart';
import 'package:fruit_hub/features/auth/presentation/views/signup_view.dart';
import 'package:fruit_hub/features/best_selling_fruits/presentation/views/best_selling_view.dart';
import 'package:fruit_hub/features/checkout/presentation/views/checkout_view.dart';
import 'package:fruit_hub/features/home/domain/entities/cart_entity.dart';
import 'package:fruit_hub/features/home/domain/entities/cart_item_entity.dart';
import 'package:fruit_hub/features/home/presentation/views/main_view.dart';
import 'package:fruit_hub/features/home/presentation/views/products_view.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/home_view.dart';
import 'package:fruit_hub/features/onboarding/presentation/views/onboarding_view.dart';
import 'package:fruit_hub/features/splash/presentation/views/splah_view.dart';

Route<dynamic>onGenerateRoute(RouteSettings settings) {
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
      return MaterialPageRoute(builder: (context) => CheckoutView(
        cartEntity: settings.arguments as CartEntity,
      ));
    default:
      return MaterialPageRoute(builder: (context) => Scaffold());
  }
}
