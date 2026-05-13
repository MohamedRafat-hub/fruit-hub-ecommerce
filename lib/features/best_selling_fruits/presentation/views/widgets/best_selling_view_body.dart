import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/best_selling_gridview.dart';

class BestSellingViewBody extends StatefulWidget {
  const BestSellingViewBody({super.key});

  @override
  State<BestSellingViewBody> createState() =>
      _BestSellingViewBodyState();
}

class _BestSellingViewBodyState
    extends State<BestSellingViewBody> {

  @override
  void initState() {
    super.initState();

    context.read<ProductsCubit>()
        .getBestSellingProducts();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),

      child: CustomScrollView(
        slivers: [

          BlocBuilder<ProductsCubit, ProductsState>(
            builder: (context, state) {

              if (state is ProductsLoading) {
                return const SliverFillRemaining(
                  child: Center(
                    child: CircularProgressIndicator(),
                  ),
                );
              }

              if (state is ProductsFailure) {
                return SliverFillRemaining(
                  child: Center(
                    child: Text(state.errorMessage),
                  ),
                );
              }

              if (state is ProductsSuccess) {
                return BestSellingGridView(
                  products: state.products,
                );
              }

              return const SliverToBoxAdapter(
                child: SizedBox.shrink(),
              );
            },
          ),
        ],
      ),
    );
  }
}