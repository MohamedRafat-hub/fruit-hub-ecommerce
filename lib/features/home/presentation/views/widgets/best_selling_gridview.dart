import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/entities/product_entity.dart';
import 'package:fruit_hub/features/home/presentation/managers/favouriteCubit/favourite_cubit.dart';

import 'fruit_item.dart';

class BestSellingGridView extends StatelessWidget {
 const BestSellingGridView({super.key, required this.products});

  final List<ProductEntity> products;

  @override
  Widget build(BuildContext context) {
    final favouriteIds = context.watch<FavouriteCubit>().favouriteIds;
    return SliverPadding(
      padding: EdgeInsets.only(left: 12),
      sliver: SliverGrid(
        delegate: SliverChildBuilderDelegate(
          (context, index) {
            return FruitItem(
              productEntity: products[index],
              isFavourite: favouriteIds.contains(products[index].code),
            );
          },
          childCount: products.length,
        ),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
          crossAxisCount: 2,
          mainAxisSpacing: 16,
          crossAxisSpacing: 16,
          childAspectRatio: 0.75,
        ),
      ),
    );
  }
}
