import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cubits/products_cubit/products_cubit.dart';
import 'package:gap/gap.dart';

import '../../../../home/presentation/views/widgets/best_selling_gridview.dart';
import 'best_seller_title.dart';

class BestSellingViewBody extends StatefulWidget {
  const BestSellingViewBody({super.key});

  @override
  State<BestSellingViewBody> createState() => _BestSellingViewBodyState();
}

class _BestSellingViewBodyState extends State<BestSellingViewBody> {

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 12),
      child: CustomScrollView(
        slivers: [
          SliverToBoxAdapter(
            child: Column(
              children: [
                Gap(20),
                Row(
                  children: [
                    BestSellerTitle(),
                  ],
                ),
                Gap(12),
              ],
            ),
          ),
          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {
              return BestSellingGridView(
                products: state is ProductsSuccess ? state.products : [],
              );
            },
          ),
        ],
      ),
    );
  }
}