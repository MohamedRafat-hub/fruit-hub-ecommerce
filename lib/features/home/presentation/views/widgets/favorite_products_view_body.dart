import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/cubits/products_cubit/products_cubit.dart';
import '../../../../../core/entities/product_entity.dart';
import '../../managers/favouriteCubit/favourite_cubit.dart';
import 'best_selling_gridview.dart';

class FavouriteProductsViewBody extends StatefulWidget {
  const FavouriteProductsViewBody({super.key});

  @override
  State<FavouriteProductsViewBody> createState() =>
      _FavouriteProductsViewBodyState();
}

class _FavouriteProductsViewBodyState extends State<FavouriteProductsViewBody> {

  @override
  void initState() {
    super.initState();
    context.read<ProductsCubit>().getProducts();
    context.read<FavouriteCubit>().getFavouriteProducts(); // ✅ بس دي
  }

  @override
  Widget build(BuildContext context) {
    List<ProductEntity> allProducts = []; // ✅ قائمة لتخزين كل المنتجات

    return CustomScrollView(
      slivers: [
        BlocBuilder<ProductsCubit, ProductsState>(
          builder: (context, state) {
            if(state is ProductsSuccess)
              {
                allProducts = state.products; // ✅ تحديث المنتجات عند النجاح
              }
            return BlocBuilder<FavouriteCubit, FavouriteState>(
              builder: (context, state) {
                if (state is FavouriteLoading) {
                  return SliverToBoxAdapter(
                    child: Center(child: CircularProgressIndicator()),
                  );
                }
                if (state is FavouriteFailure) {
                  return SliverToBoxAdapter(
                    child: Center(child: Text(state.errorMessage)),
                  );
                }
                if (state is FavouriteSuccess) {
                  // ✅ فلتر مباشرة في الـ builder
                  final favouriteProducts = allProducts
                      .where((product) =>
                      state.favouriteProducts!.contains(product.code))
                      .toList();
                  log('All products count: ${allProducts.length}');
                  log('Favourite products count: ${favouriteProducts.length}');
                  return BestSellingGridView(products: favouriteProducts);
                }
                return SliverToBoxAdapter(child: SizedBox());
              },
            );
          },
        ),
      ],
    );
  }
}
