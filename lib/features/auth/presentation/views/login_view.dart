import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/services/git_it_service.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/login_cubit/login_cubit.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/build_app_bar.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/login_view_body_bloc_consumer.dart';
import '../../domain/repos/auth_repo.dart';

class LoginView extends StatelessWidget {
  const LoginView({super.key});

  static const String routeName = "LoginView";

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => LoginCubit(getIt.get<AuthRepo>()),
      child: Scaffold(
        appBar: buildAppBar(
          title: 'تسجيل الدخول',
          hasLeading: false,
          context: context,
        ),
        body: LoginViewBodyBlocConsumer(),
      ),
    );
  }
}


