import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/services/database_service.dart';
import 'package:fruit_hub/core/services/git_it_service.dart';
import 'package:fruit_hub/core/widgets/custom_material_button.dart';
import 'package:fruit_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/getProfileDataCubit/get_profile_data_cubit.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/updatePasswordCubit/update_password_cubit.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/build_app_bar.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/custom_text_form_field.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/my_account_view_body.dart';

import '../../../../core/helper_functions/build_show_snack_bar.dart';

class MyAccountView extends StatelessWidget {
  const MyAccountView({super.key});

  static const routeName = 'My Account View';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => UpdatePasswordCubit(authRepo: getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(
            title: 'الملف الشخصي', context: context, hasLeading: true),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 12),
          child: MyAccountViewBody(),
        ),
      ),
    );
  }
}


