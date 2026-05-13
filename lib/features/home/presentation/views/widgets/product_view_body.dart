import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/product_view_header.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/search_text_field.dart';
import 'package:gap/gap.dart';
import 'custom_product_app_bar.dart';
import 'products_grid_view_bloc_builder.dart';

class ProductsViewBody extends StatefulWidget {
  const ProductsViewBody({super.key});

  @override
  State<ProductsViewBody> createState() => _ProductsViewBodyState();
}

class _ProductsViewBodyState extends State<ProductsViewBody> {
  @override
  void initState() {
    context.read<ProductsCubit>().getProducts();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              spacing: 10,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                CustomProductsAppBar(),
                SearchTextField(
                  onChanged: (value) {
                    context.read<ProductsCubit>().searchProduct(value);
                  },
                ),
                BlocBuilder<ProductsCubit, ProductsState>(
                  builder: (context, state) {
                    final productsLength = state is ProductsSuccess ? state.products.length : 0;
                    return ProductsViewHeader(
                      productsLength: productsLength,
                    );
                  },
                ),
                Gap(10),
              ],
            ),
          ),
          ProductsGridViewBlocBuilder(),
        ],
      ),
    );
  }
}
