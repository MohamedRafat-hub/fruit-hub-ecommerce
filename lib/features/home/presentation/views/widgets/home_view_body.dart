import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/cubits/products_cubit/products_cubit.dart';
import 'package:fruit_hub/features/home/presentation/managers/favouriteCubit/favourite_cubit.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/home_featured_item.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/search_text_field.dart';
import 'package:gap/gap.dart';

import '../../../../best_selling_fruits/presentation/views/best_selling_view.dart';
import '../../../../best_selling_fruits/presentation/views/widgets/best_seller_title.dart';
import 'products_grid_view_bloc_builder.dart';
import 'custom_appbar_widget.dart';
import 'home_featured_list.dart';

class HomeViewBody extends StatefulWidget {
  const HomeViewBody({
    super.key,
  });

  @override
  State<HomeViewBody> createState() => _HomeViewBodyState();
}

class _HomeViewBodyState extends State<HomeViewBody> {
  @override
  void initState() {
    context.read<ProductsCubit>().getBestSellingProducts();
    context.read<FavouriteCubit>().getFavouriteProducts();
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
                CustomAppbarWidget(),
                SearchTextField(
                  onChanged: (value) {
                    context.read<ProductsCubit>().searchProduct(value);
                  },
                ),
                Gap(6),
                SizedBox(height: 180, child: HomeFeaturedList()),
                GestureDetector(
                  onTap: () {
                    Navigator.pushNamed(context, BestSellingView.routeName);
                  },
                  child: Row(
                    children: [
                      BestSellerTitle(),
                      Spacer(),
                      Padding(
                        padding: const EdgeInsets.only(left: 12),
                        child: Text(
                          'المزيد',
                          style: TextStyle(
                              color: Color(0xFF949D9E),
                              fontSize: 20,
                              fontFamily: 'Cairo',
                              fontWeight: FontWeight.w700),
                        ),
                      ),
                    ],
                  ),
                ),
                Gap(5),
              ],
            ),
          ),
          ProductsGridViewBlocBuilder(),
        ],
      ),
    );
  }
}
