import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/services/git_it_service.dart';
import 'package:fruit_hub/core/utils/app_colors.dart';
import 'package:fruit_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:fruit_hub/features/auth/domain/repos/image_repo.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/signoutCubit/sign_out_cubit.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/uploadImageCubit/upload_image_cubit.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/build_app_bar.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/signout_button.dart';
import 'package:fruit_hub/features/auth/presentation/views/widgets/user_data.dart';
import 'package:fruit_hub/features/home/presentation/views/favourite_products_view.dart';
import 'package:fruit_hub/features/home/presentation/views/widgets/about_us_view.dart';
import 'package:gap/gap.dart';

import '../../../checkout/presentation/views/payments_view.dart';
import 'my_account_view.dart';

class ProfileView extends StatefulWidget {
  const ProfileView({super.key});

  @override
  State<ProfileView> createState() => _ProfileViewState();
}

class _ProfileViewState extends State<ProfileView> {
  bool notificationsEnabled = true;

  bool darkModeEnabled = false;

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

            // const Text('عام',
            //     style:
            //         TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            // const SizedBox(height: 10),
            _buildListTile(Icons.person_outline, 'الملف الشخصي',
                hasNavigation: true , onTap: (){
              Navigator.pushNamed(context, MyAccountView.routeName);
                }),
            _buildListTile(Icons.inventory_2_outlined, 'طلباتي',
                hasNavigation: true , onTap: (){
              Navigator.pushNamed(context, 'last-orders');
            }),
            _buildListTile(Icons.account_balance_wallet_outlined, 'المدفوعات',
                hasNavigation: true , onTap: (){
              Navigator.pushNamed(context, PaymentsView.routeName);
            }),
            _buildListTile(Icons.favorite_border, 'المفضلة',
                hasNavigation: true, onTap: () {
              log('Navigating to Favourite Products View');
              Navigator.pushNamed(context, FavouriteProductsView.routeName);
            }),
            _buildListTile(Icons.language, 'اللغة',
                trailingText: 'العربية', hasNavigation: true),

            _buildSwitchTile(title: 'الوضع', value: darkModeEnabled, onChanged: (value) {
              setState(() {
                darkModeEnabled = value;
              });
            }),

            const SizedBox(height: 20),

            // قسم المساعدة
            const Text('المساعده',
                style:
                    TextStyle(color: Colors.grey, fontWeight: FontWeight.bold)),
            const SizedBox(height: 10),
            _buildListTile(Icons.info_outline, 'من نحن', hasNavigation: true , onTap: (){
              Navigator.pushNamed(context, AboutUsView.routeName);
            }),

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
      leading: Icon(icon, color: AppColors.primaryColor),
      title: Text(title, style: const TextStyle(color: Colors.grey)),
      trailing: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          if (trailingText != null)
            Text(trailingText, style: const TextStyle(color: Colors.grey)),
          if (hasNavigation)
            const Icon(Icons.arrow_forward_ios_outlined,
                size: 16, color: Colors.grey),
        ],
      ),
      onTap: onTap,
    );
  }

   Widget _buildSwitchTile({
     required String title,
     required bool value,
     required Function(bool) onChanged,
   }) {
     return ListTile(
       contentPadding: EdgeInsets.zero,

       leading: value
           ? const Icon(
         Icons.notifications_none_outlined,
         color: Colors.grey,
       )
           : const Icon(
         Icons.notifications_off_outlined,
         color: Colors.grey,
       ),

       title: Text(
         title,
         style: const TextStyle(color: Colors.grey),
       ),

       trailing: Switch(
         value: value,

         onChanged: onChanged,

         activeColor: Colors.green,
       ),
     );
   }
}
