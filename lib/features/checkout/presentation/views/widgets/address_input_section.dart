import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:fruit_hub/features/checkout/domain/entities/order_entity.dart';

class AddressInputSection extends StatelessWidget {
  const AddressInputSection(
      {super.key, required this.formKey, required this.valueListenable});

  final GlobalKey<FormState> formKey;
  final ValueListenable<AutovalidateMode> valueListenable;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: ValueListenableBuilder<AutovalidateMode>(
        valueListenable: valueListenable,
        builder: (context, value, child) => Form(
          key: formKey,
          autovalidateMode: value,
          child: Column(
            spacing: 8,
            children: [
              CustomTextFormField(
                  onSaved: (value) {
                    context.read<OrderEntity>().shippingAddress!.name = value;
                  },
                  hintText: 'الاسم بالكامل',
                  stringOnly: true,
                  keyboardType: TextInputType.text),
              CustomTextFormField(
                stringOnly: true,
                  onSaved: (value) {
                    context.read<OrderEntity>().shippingAddress!.address =
                        value;
                  },
                  hintText: ' العنوان',
                  keyboardType: TextInputType.text),
              CustomTextFormField(
                  onSaved: (value) {
                    context.read<OrderEntity>().shippingAddress!.city = value;
                  },
                  hintText: 'المدينة',
                  stringOnly: true,
                  keyboardType: TextInputType.text),
              CustomTextFormField(
                onSaved: (value) {
                  context.read<OrderEntity>().shippingAddress!.phoneNumber =
                      value;
                },
                hintText: 'رقم الهاتف',
                keyboardType: TextInputType.number,
                isPhoneNumber: true,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
