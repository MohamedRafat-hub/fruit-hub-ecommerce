import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_paypal_payment/flutter_paypal_payment.dart';
import 'package:fruit_hub/core/helper_functions/build_show_snack_bar.dart';
import 'package:fruit_hub/core/widgets/custom_material_button.dart';
import 'package:fruit_hub/features/checkout/domain/entities/order_entity.dart';
import 'package:fruit_hub/features/checkout/domain/entities/payment_entity.dart';
import 'package:fruit_hub/features/checkout/presentation/managers/add_order_cubit/add_order_cubit.dart';
import 'package:gap/gap.dart';
import 'checkout_page_view.dart';
import 'checkout_steps.dart';

class CheckoutViewBody extends StatefulWidget {
  const CheckoutViewBody({super.key});

  @override
  State<CheckoutViewBody> createState() => _CheckoutViewBodyState();
}

class _CheckoutViewBodyState extends State<CheckoutViewBody> {
  late PageController pageController;
  int currentPageIndex = 0;
  final GlobalKey<FormState> formKey = GlobalKey();
  ValueNotifier<AutovalidateMode> valueNotifier =
      ValueNotifier(AutovalidateMode.disabled);

  @override
  void initState() {
    pageController = PageController();
    pageController.addListener(() {
      setState(() {
        currentPageIndex = pageController.page!.round();
      });
    });
    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    valueNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Gap(20),
        CheckoutSteps(
          formKey: formKey,
          currentPageIndex: currentPageIndex,
          pageController: pageController,
        ),
        CheckoutPageView(
          pageController: pageController,
          formKey: formKey,
          valueListenable: valueNotifier,
        ),
        BlocBuilder<AddOrderCubit, AddOrderState>(
          builder: (context, state) {
            return CustomMaterialButton(
              isLoading: state is AddOrderLoading,
                buttonName: getNextButtonText(),
                onPressed: () {
                  if (currentPageIndex == 0) {
                    log('cache ${context.read<OrderEntity>().payWithCache}');
                    handleShippingSectionValidation(context);
                  } else if (currentPageIndex == 1) {
                    handleAddressingSectionValidation();
                  } else {
                    var orderEntity = context.read<OrderEntity>();
                    context
                        .read<AddOrderCubit>()
                        .addOrder(orderEntity: orderEntity);
                  }
                });
          },
        ),
        Gap(50),
      ],
    );
  }

  void handleShippingSectionValidation(BuildContext context) {
    if (context.read<OrderEntity>().payWithCache != null) {
      pageController.nextPage(
          duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
    } else {
      showSnackBar(context,
          message: 'برجاء اختيار طريقة الدفع', color: Colors.red);
    }
  }

  String getNextButtonText() {
    switch (currentPageIndex) {
      case 0:
        return 'التالي';
      case 1:
        return 'التالي';
      case 2:
        return 'الدفع باستخدام PayPal';
      default:
        return 'التالي';
    }
  }

  void handleAddressingSectionValidation() {
    if (formKey.currentState!.validate()) {
      formKey.currentState!.save();
      pageController.nextPage(
          duration: Duration(milliseconds: 150), curve: Curves.easeInOut);
    } else {
      valueNotifier.value = AutovalidateMode.always;
    }
  }

  void _processPayment() {
    var orderEntity = context.read<OrderEntity>();
    PaypalPaymentEntity paymentEntity =
        PaypalPaymentEntity.fromEntity(orderEntity);
    Navigator.of(context).push(MaterialPageRoute(
      builder: (BuildContext context) => PaypalCheckoutView(
        sandboxMode: true,
        // Test ?
        clientId: "",
        secretKey: "",
        transactions: [
          paymentEntity.toJson(),
        ],
        note: "Contact us for any questions on your order.",
        onSuccess: (Map params) async {
          print("onSuccess: $params");
        },
        onError: (error) {
          print("onError: $error");
          Navigator.pop(context);
        },
        onCancel: () {
          print('cancelled:');
        },
      ),
    ));
  }
}
