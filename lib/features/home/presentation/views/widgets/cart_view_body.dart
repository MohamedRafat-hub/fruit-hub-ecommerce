import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/payment_button.dart';
import 'package:gap/gap.dart';
import '../../managers/cartCubit/cart_cubit.dart';
import 'cart_item_list.dart';
import 'cart_view_app_bar.dart';

class CartViewBody extends StatefulWidget {
  const CartViewBody({super.key});

  @override
  State<CartViewBody> createState() => _CartViewBodyState();
}

class _CartViewBodyState extends State<CartViewBody> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        children: [
          CartViewAppBar(),
          Padding(
            padding: const EdgeInsets.only(left: 12, right: 12),
            child: Container(
                width: double.infinity,
                padding: EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  color: const Color(0xFFEBF9F1) /* Green1-50 */,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  spacing: 8,
                  children: [
                    Text(
                      'لديك ${context.watch<CartCubit>().cartEntity.cartItems.length} منتجات في سله التسوق',
                      style: TextStyle(
                        color: const Color(0xFF1B5E37) /* Green1-500 */,
                        fontSize: 13,
                        fontFamily: 'Cairo',
                        fontWeight: FontWeight.w400,
                        height: 1.60,
                      ),
                    ),
                  ],
                )),
          ),
          Gap(20),
          BlocBuilder<CartCubit, CartState>(
            builder: (context, state) {
              return CartItemList(
                cartItems: context.read<CartCubit>().cartEntity.cartItems,
              );
            },
          ),
          Gap(70),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            child: PaymentButton(),
          ),
          Gap(70),
        ],
      ),
    );
  }
}
