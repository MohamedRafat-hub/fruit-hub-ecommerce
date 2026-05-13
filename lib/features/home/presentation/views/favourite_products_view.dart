
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruit_hub/core/repos/product_repo.dart';
import 'package:fruit_hub/core/services/git_it_service.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/build_app_bar.dart';
import 'package:fruit_hub/features/home/domain/repos/favourite_repo.dart';
import 'package:fruit_hub/features/home/presentation/managers/favouriteCubit/favourite_cubit.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/favorite_products_view_body.dart';

class FavouriteProductsView extends StatelessWidget {
  const FavouriteProductsView({super.key});

  static const routeName = 'Favourite Products View';

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<ProductsCubit>(
          create: (context) => ProductsCubit(getIt.get<ProductRepo>()),
        ),
        BlocProvider<FavouriteCubit>(
          create: (context) =>
              FavouriteCubit(favouriteRepo: getIt.get<FavouriteRepo>()),
        ),
      ],
      child: Scaffold(
        appBar:
            buildAppBar(title: 'المفضلة', hasLeading: true, context: context),
        body: Padding(
          padding: const EdgeInsets.only(right: 12),
          child: FavouriteProductsViewBody(),
        ),
      ),
    );
  }
}

