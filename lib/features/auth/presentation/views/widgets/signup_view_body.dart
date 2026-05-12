import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/widgets/custom_material_button.dart';
import 'package:fruit_hub/core/widgets/custom_text.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:gap/gap.dart';

import '../../../../../core/utils/app_colors.dart';

class SignUpViewBody extends StatefulWidget {
  SignUpViewBody({super.key});

  bool? isChecked = false;

  @override
  State<SignUpViewBody> createState() => _SignUpViewBodyState();
}

class _SignUpViewBodyState extends State<SignUpViewBody> {
  GlobalKey<FormState> formKey = GlobalKey();
  AutovalidateMode autoValidateMode = AutovalidateMode.disabled;
  late String name, email, password;
  bool isVisiblePassword = false;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Form(
          key: formKey,
          autovalidateMode: autoValidateMode,
          child: Column(
            spacing: 16,
            children: [
              Gap(20),
              /// fields
              CustomTextFormField(
                  onSaved: (value) {
                    name = value!.trim();
                  },
                  hintText: 'الاسم كامل',
                  keyboardType: TextInputType.name),
              CustomTextFormField(
                  onSaved: (value) {
                    email = value!.trim();
                  },
                  hintText: 'البريد الإلكتروني',
                  keyboardType: TextInputType.emailAddress),


              CustomTextFormField(
                obscureText: !isVisiblePassword,
                onSaved: (value) {
                  password = value!.trim();
                },
                hintText: 'كلمة المرور',
                keyboardType: TextInputType.visiblePassword,
                icon: GestureDetector(
                    onTap: () {
                      setState(() {
                        isVisiblePassword = !isVisiblePassword;
                      });
                    },
                    child: isVisiblePassword
                        ? Icon(CupertinoIcons.eye_fill)
                        : Icon(CupertinoIcons.eye_slash_fill)),
              ),

              /// condition and terminations
              Transform.translate(
                offset: Offset(14, 0),
                child: Row(
                  children: [
                    Checkbox(
                        value: widget.isChecked,
                        onChanged: (value) {
                          widget.isChecked = value;
                          setState(() {});
                        }),
                    Expanded(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(
                              text: 'من خلال إنشاء حساب ، فإنك توافق على ',
                              style: TextStyle(
                                color:
                                    const Color(0xFF949D9E) /* Grayscale-400 */,
                                fontSize: 13,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                                height: 1.70,
                              ),
                            ),
                            TextSpan(
                              text: 'الشروط والأحكام',
                              style: TextStyle(
                                color: const Color(0xFF2D9F5D) /* Green1-600 */,
                                fontSize: 13,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                                height: 1.70,
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                color:
                                    const Color(0xFF616A6B) /* Grayscale-600 */,
                                fontSize: 13,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                                height: 1.70,
                              ),
                            ),
                            TextSpan(
                              text: 'الخاصة',
                              style: TextStyle(
                                color: const Color(0xFF2D9F5D) /* Green1-600 */,
                                fontSize: 13,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                                height: 1.70,
                              ),
                            ),
                            TextSpan(
                              text: ' ',
                              style: TextStyle(
                                color:
                                    const Color(0xFF616A6B) /* Grayscale-600 */,
                                fontSize: 13,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                                height: 1.70,
                              ),
                            ),
                            TextSpan(
                              text: 'بنا',
                              style: TextStyle(
                                color: const Color(0xFF2D9F5D) /* Green1-600 */,
                                fontSize: 13,
                                fontFamily: 'Cairo',
                                fontWeight: FontWeight.w600,
                                height: 1.70,
                              ),
                            ),
                          ],
                        ),
                        textAlign: TextAlign.right,
                      ),
                    )
                  ],
                ),
              ),

              /// SignUp button
              CustomMaterialButton(
                buttonName: 'إنشاء حساب جديد',
                onPressed: () {
                  if (formKey.currentState!.validate()) {
                    formKey.currentState!.save();
                    if(widget.isChecked == false){
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: Colors.red,
                          content: Center(child: Text('يجب الموافقة على الشروط والأحكام' , style: TextStyle(color: Colors.white , fontSize: 16),)),
                        ),
                      );
                      return;
                    }
                    BlocProvider.of<SignupCubit>(context)
                        .signup(name: name, email: email, password: password);
                  } else {
                    setState(() {
                      autoValidateMode = AutovalidateMode.always;
                    });
                  }
                },
              ),

              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'تمتلك حساب بالفعل؟ ',
                    color: Colors.grey,
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: CustomText(
                      text: 'تسجيل دخول',
                      color: AppColors.primaryColor,
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
