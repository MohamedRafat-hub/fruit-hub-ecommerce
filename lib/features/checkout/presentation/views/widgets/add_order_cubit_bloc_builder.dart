import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/helper_functions/build_show_snack_bar.dart';
import 'package:fruit_hub/features/checkout/presentation/managers/add_order_cubit/add_order_cubit.dart';
import 'package:fruit_hub/features/checkout/presentation/views/last_orders_view.dart';
import 'package:modal_progress_hud_nsn/modal_progress_hud_nsn.dart';

import '../../../../home/presentation/managers/cartCubit/cart_cubit.dart';

class AddOrderCubitBlocBuilder extends StatelessWidget {
  const AddOrderCubitBlocBuilder({super.key, required this.child});

  final Widget child;

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AddOrderCubit,AddOrderState>(builder: (context, state) {
      return child;
    }, listener: (context, state) {
      if (state is AddOrderSuccess) {
        context.read<CartCubit>().clearCart();
        Navigator.pushReplacementNamed(context, LastOrdersView.routeName);
        showSnackBar(context, message: 'تم اضافة الطلب بنجاح');
      } else if (state is AddOrderFailure) {
        showSnackBar(context, message: state.errorMessage);
      }
    });
  }
}
