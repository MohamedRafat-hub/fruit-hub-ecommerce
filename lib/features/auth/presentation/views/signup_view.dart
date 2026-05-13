import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/services/git_it_service.dart';
import 'package:fruit_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/signup_cubit/signup_cubit.dart';

import 'package:fruit_hub/features/auth/presentation/views/widgets/signup_view_body_bloc_consumer.dart';


import 'widgets/build_app_bar.dart';

class SignupView extends StatelessWidget {
  const SignupView({super.key});

  static const String routeName = 'SignupView';

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SignupCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(
          title: 'حساب جديد',
          hasLeading: true,
          context: context,
        ),
        body: SignUpBlocConsumer(),
      ),
    );
  }
}


