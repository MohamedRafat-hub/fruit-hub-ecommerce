import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/services/git_it_service.dart';
import 'package:fruit_hub/features/checkout/domain/entities/order_entity.dart';
import 'package:fruit_hub/features/checkout/domain/repos/add_order_repo.dart';
import 'package:fruit_hub/features/checkout/domain/entities/shipping_address_entity.dart';
import 'package:fruit_hub/features/checkout/presentation/managers/add_order_cubit/add_order_cubit.dart';
import 'package:fruit_hub/features/checkout/presentation/views/widgets/add_order_cubit_bloc_builder.dart';
import 'package:fruit_hub/features/checkout/presentation/views/widgets/checkout_app_bar.dart';
import 'package:fruit_hub/features/checkout/presentation/views/widgets/checkout_view_body.dart';
import 'package:fruit_hub/features/home/domain/entities/cart_entity.dart';
import 'package:fruit_hub/features/home/presentation/managers/cartCubit/cart_cubit.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

class CheckoutView extends StatefulWidget {
  const CheckoutView({
    super.key,
    required this.cartEntity,
  });

  static const routeName = 'Checkout View';
  final CartEntity cartEntity;

  @override
  State<CheckoutView> createState() => _CheckoutViewState();
}

class _CheckoutViewState extends State<CheckoutView> {
  late OrderEntity orderEntity;

  @override
  void initState() {
    orderEntity = OrderEntity(
        date: DateFormat('d MMMM ,yyyy', 'ar').format(DateTime.now()),
        uid: FirebaseAuth.instance.currentUser!.uid,
        cartEntity: widget.cartEntity,
        shippingAddress: ShippingAddressEntity());
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<AddOrderCubit>(
          create: (context) => AddOrderCubit(getIt.get<AddOrderRepo>()),
        ),
      ],
      child: Scaffold(
        appBar: checkoutAppBar(
            title: 'الشحن', onPressed: () => Navigator.pop(context)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Provider.value(
              value: orderEntity,
              child: AddOrderCubitBlocBuilder(child: CheckoutViewBody())),
        ),
      ),
    );
  }
}
