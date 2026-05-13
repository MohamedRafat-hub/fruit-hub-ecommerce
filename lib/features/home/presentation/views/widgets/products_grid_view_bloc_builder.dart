import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/helper_functions/get_dummy_products.dart';
import 'package:fruit_hub/core/widgets/custom_error_message.dart';
import 'package:fruit_hub/features/home/presentation/managers/favouriteCubit/favourite_cubit.dart';
import 'package:skeletonizer/skeletonizer.dart';

import '../../../../../core/cubits/products_cubit/products_cubit.dart';
import 'best_selling_gridview.dart';

class ProductsGridViewBlocBuilder extends StatelessWidget {
 const  ProductsGridViewBlocBuilder({
    super.key,
  });
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ProductsCubit, ProductsState>(
      builder: (context, state) {
        if (state is ProductsSuccess) {
          return BestSellingGridView(
            products: state.products,
          );
        }
        else if (state is ProductsFailure) {
          return SliverToBoxAdapter(
              child: CustomErrorMessage(state.errorMessage));
        }
        else {
          return Skeletonizer.sliver(
              enabled: true,
              child: BestSellingGridView(
                products: getDummyProducts(),
              ));
        }
      },
    );
  }
}