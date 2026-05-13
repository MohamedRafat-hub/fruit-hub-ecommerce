import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/build_app_bar.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/custom_text_form_field.dart';

class MyAccountView extends StatelessWidget {
  const MyAccountView({super.key});

  static const routeName = 'My Account View';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(
          title: 'الملف الشخصي', context: context, hasLeading: true),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
        child: MyAccountViewBody(),
      ),
    );
  }
}

class MyAccountViewBody extends StatelessWidget {
  const MyAccountViewBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      spacing: 10,
      children: [
        Text(
          'المعلومات الشخصية',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        CustomTextFormField(
          hintText: 'اسم المستخدم',
          keyboardType: TextInputType.text,
          icon: Icon(Icons.edit_rounded , color: Colors.grey),
        ),
        CustomTextFormField(
            hintText: 'الايميل',
            keyboardType: TextInputType.text,
            icon: Icon(Icons.edit_rounded , color: Colors.grey)),
        Text(
          'تغيير كلمة المرور',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        CustomTextFormField(
            hintText: 'كلمة المرور الحالية',
            keyboardType: TextInputType.text,
            icon: Icon(
              Icons.remove_red_eye_rounded,
              color: Colors.grey,
            )),
        CustomTextFormField(
            hintText: 'كلمة المرور الجديدة',
            keyboardType: TextInputType.text,
            icon: Icon(
              Icons.remove_red_eye_rounded,
              color: Colors.grey,
            )),
        CustomTextFormField(
          hintText: 'تأكيد كلمة المرور الجديدة',
          keyboardType: TextInputType.text,
          icon: Icon(
            Icons.remove_red_eye_rounded,
            color: Colors.grey,
          ),
        ),
      ],
    );
  }
}
