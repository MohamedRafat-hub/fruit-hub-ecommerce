import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruit_hub/core/repos/product_repo.dart';
import 'package:fruit_hub/core/services/git_it_service.dart';
import 'widgets/home_view_body.dart';

class HomeView extends StatelessWidget {
  const HomeView({
    super.key,
  });
  static const routeName = 'Home View';
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => ProductsCubit(getIt.get<ProductRepo>()),
      child: Padding(
        padding: const EdgeInsets.only(right: 16),
        child: HomeViewBody(),
      ),
    );
  }
}






