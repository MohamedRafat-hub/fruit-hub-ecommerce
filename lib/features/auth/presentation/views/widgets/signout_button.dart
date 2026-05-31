import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';

import '../../../../../core/helper_functions/build_show_snack_bar.dart';
import '../../../../../core/widgets/custom_material_button.dart';
import '../../cubits/signoutCubit/sign_out_cubit.dart';
import '../login_view.dart';

class SignOutButton extends StatelessWidget {
  const SignOutButton({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<SignOutCubit, SignOutState>(
      listener: (context, state) {
        if (state is SignOutSuccess) {
          showSnackBar(context, message: 'تم تسجيل الخروج بنجاح');
          Navigator.pushReplacementNamed(context, LoginView.routeName);
        } else if (state is SignOutFailure) {
          showSnackBar(context, message: state.errorMessage, color: Colors.red);
        }
      },
      builder: (context, state) {
        return state is SignOutLoading
            ? CircularProgressIndicator(
          color: AppColors.primaryColor,
        )
            : CustomMaterialButton(
          buttonName: 'تسجيل الخروج',
          onPressed: () => _showSignOutDialog(context),
        );
      },
    );
  }

  void _showSignOutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (dialogContext) => AlertDialog(
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
        title: Text(
          'هل ترغب في تسجيل الخروج ؟',
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
        ),
        actions: [
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    Navigator.pop(dialogContext);
                    context.read<SignOutCubit>().signOut();
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primaryColor,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('تأكيد', style: TextStyle(color: Colors.white , fontSize: 16)),
                ),
              ),
              SizedBox(width: 12),
              Expanded(
                child: OutlinedButton(
                  onPressed: () => Navigator.pop(dialogContext),
                  style: OutlinedButton.styleFrom(
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(12)),
                  ),
                  child: Text('لا أرغب', style: TextStyle(color: Colors.black , fontSize: 16)),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}