import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:http/http.dart';

import '../../../../../core/helper_functions/build_show_snack_bar.dart';
import '../../../../../core/widgets/custom_material_button.dart';
import '../../cubits/getProfileDataCubit/get_profile_data_cubit.dart'
    show GetProfileDataCubit, GetProfileDataSuccess, GetProfileDataState;
import '../../cubits/updatePasswordCubit/update_password_cubit.dart';
import 'custom_text_form_field.dart';

class MyAccountViewBody extends StatefulWidget {
  const MyAccountViewBody({super.key});

  @override
  State<MyAccountViewBody> createState() => _MyAccountViewBodyState();
}

class _MyAccountViewBodyState extends State<MyAccountViewBody> {
  bool obscureCurrentPassword = true;
  bool obscureNewPassword = true;
  bool obscureConfirmPassword = true;
  late TextEditingController nameController;

  late TextEditingController emailController;

  final TextEditingController currentPasswordController =
      TextEditingController();

  final TextEditingController newPasswordController = TextEditingController();

  final TextEditingController confirmPasswordController =
      TextEditingController();

  @override
  void initState() {
    context
        .read<GetProfileDataCubit>()
        .getProfileData(uid: FirebaseAuth.instance.currentUser!.uid);
    final state = context.read<GetProfileDataCubit>().state;
    final user = state is GetProfileDataSuccess ? state.userEntity : null;
    nameController = TextEditingController(text: user?.name ?? '');
    emailController = TextEditingController(text: user?.email ?? '');
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    emailController.dispose();
    currentPasswordController.dispose();
    newPasswordController.dispose();
    confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
      builder: (context, state) {
        if (state is GetProfileDataSuccess) {
          nameController =
              TextEditingController(text: state.userEntity.name ?? '');
          emailController =
              TextEditingController(text: state.userEntity.email ?? '');
        }
        return BlocListener<UpdatePasswordCubit, UpdatePasswordState>(
          listener: (context, state) {
            if (state is UpdatePasswordLoading) {
              showDialog(
                context: context,
                barrierDismissible: false,
                builder: (_) => Center(child: CircularProgressIndicator()),
              );
            } else if (state is UpdatePasswordSuccess) {
              Navigator.pop(context);
              showSnackBar(context, message: 'تم تغيير كلمة المرور بنجاح ✅');
            } else if (state is UpdatePasswordFailure) {
              Navigator.pop(context);
              showSnackBar(context,
                  message: state.errorMessage, color: Colors.red);
            }
          },
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              spacing: 10,
              children: [
                Text(
                  'المعلومات الشخصية',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
                CustomTextFormField(
                  readOnly: true,
                  controller: nameController,
                  hintText: 'اسم المستخدم',
                  keyboardType: TextInputType.text,
                ),
                CustomTextFormField(
                    readOnly: true,
                    controller: emailController,
                    hintText: 'الايميل',
                    keyboardType: TextInputType.text),
                Text(
                  'تغيير كلمة المرور',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              CustomTextFormField(
                obscureText: obscureCurrentPassword,
                controller: currentPasswordController,
                hintText: 'كلمة المرور الحالية',
                keyboardType: TextInputType.text,
                icon: IconButton(
                  onPressed: () {
                    setState(() {
                      obscureCurrentPassword =
                      !obscureCurrentPassword;
                    });
                  },
                  icon: Icon(
                    obscureCurrentPassword
                        ? CupertinoIcons.eye_slash_fill
                        : Icons.remove_red_eye_rounded,
                    color: Colors.grey,
                  ),
                ),
              ),
                CustomTextFormField(
                  obscureText: obscureNewPassword,
                  controller: newPasswordController,
                  hintText: 'كلمة المرور الجديدة',
                  keyboardType: TextInputType.text,
                  icon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureNewPassword =
                        !obscureNewPassword;
                      });
                    },
                    icon: Icon(
                      obscureNewPassword
                          ? CupertinoIcons.eye_slash_fill
                          : Icons.remove_red_eye_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
                CustomTextFormField(
                  obscureText: obscureConfirmPassword,
                  controller: confirmPasswordController,
                  hintText: 'تأكيد كلمة المرور الجديدة',
                  keyboardType: TextInputType.text,
                  icon: IconButton(
                    onPressed: () {
                      setState(() {
                        obscureConfirmPassword = !obscureConfirmPassword;
                      });
                    },
                    icon: Icon(
                      obscureConfirmPassword
                          ? CupertinoIcons.eye_slash_fill
                          : Icons.remove_red_eye_rounded,
                      color: Colors.grey,
                    ),
                  ),
                ),
                SizedBox(height: 20),
                CustomMaterialButton(
                    buttonName: 'حفظ التغييرات',
                    onPressed: () {
                      context.read<UpdatePasswordCubit>().updatePassword(
                          currentPassword: currentPasswordController.text,
                          newPassword: newPasswordController.text,
                          confirmPassword: confirmPasswordController.text);
                    }),
              ],
            ),
          ),
        );
      },
    );
  }
}
