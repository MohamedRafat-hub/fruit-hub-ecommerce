import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/services/git_it_service.dart';
import 'package:fruit_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:fruit_hub/features/auth/domain/repos/image_repo.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/signoutCubit/sign_out_cubit.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/uploadImageCubit/upload_image_cubit.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/build_app_bar.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/signout_button.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/user_data.dart';
import 'package:fruit_hub/features/home/presentation/views/favourite_products_view.dart';
import 'package:gap/gap.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider<SignOutCubit>(
          create: (context) => SignOutCubit(authRepo: getIt.get<AuthRepo>()),
        ),
        BlocProvider<UploadImageCubit>(
            create: (context) => UploadImageCubit(
                imageRepo: getIt.get<ImageRepo>(),
                authRepo: getIt.get<AuthRepo>())),
      ],
      child: Scaffold(
        backgroundColor: Colors.white,
        appBar: buildAppBar(title: 'حسابي' , hasLeading: false, context: context),
        body: ListView(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          children: [
            const Gap(20),
            const UserData(),
            const Gap(30),

            const Text('عام',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildListTile(Icons.person_outline, 'الملف الشخصي',
                hasNavigation: true),
            _buildListTile(Icons.inventory_2_outlined, 'طلباتي',
                hasNavigation: true),
            _buildListTile(Icons.account_balance_wallet_outlined, 'المدفوعات',
                hasNavigation: true),
            _buildListTile(Icons.favorite_border, 'المفضلة',
                hasNavigation: true, onTap: () {
              log('Navigating to Favourite Products View');
              Navigator.pushNamed(context, FavouriteProductsView.routeName);
            }),
            _buildSwitchTile(Icons.notifications_none, 'الاشعارات', true),
            _buildListTile(Icons.language, 'اللغة',
                trailingText: 'العربية', hasNavigation: true),
            _buildSwitchTile(Icons.edit_road_outlined, 'الوضع', false),

            const SizedBox(height: 20),

            // قسم المساعدة
            const Text('المساعده',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildListTile(Icons.info_outline, 'من نحن', hasNavigation: true),

            const SizedBox(height: 30),

            SignOutButton(),
            Gap(50),
          ],
        ),
      ),
    );
  }

  Widget _buildListTile(IconData icon, String title,
      {bool hasNavigation = false, String? trailingText, Function()? onTap}) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(color: Colors.grey)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(trailingText, style: const TextStyle(color: Colors.grey)),
          if (hasNavigation)
            const Icon(Icons.arrow_back_ios_new,
                size: 16, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }

  Widget _buildSwitchTile(IconData icon, String title, bool value) {
    return ListTile(
      contentPadding: EdgeInsets.zero,
      leading: Icon(icon, color: Colors.grey[700]),
      title: Text(title, style: const TextStyle(color: Colors.grey)),
      trailing: Switch(
        value: value,
        onChanged: (val) {},
        activeColor: Colors.green,
      ),
    );
  }
}
