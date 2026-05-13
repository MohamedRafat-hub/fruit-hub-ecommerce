import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/getProfileDataCubit/get_profile_data_cubit.dart';

import 'custom_notification_widget.dart';

class CustomAppbarWidget extends StatelessWidget {
  const CustomAppbarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<GetProfileDataCubit, GetProfileDataState>(
      builder: (context, state) {
        final userEntity =
            state is GetProfileDataSuccess ? state.userEntity : null;
        return ListTile(
          leading: userEntity?.profileImage == null
              ? Image.asset('assets/images/profile_photo.png')
              : CircleAvatar(
                  radius: 20,
                  backgroundImage: NetworkImage(userEntity!.profileImage!),
                ),
          title: Text(
            getGreetingMessage(),
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF949D9E) /* Grayscale-400 */,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w400,
              height: 1.40,
            ),
          ),
          subtitle: Text(
            userEntity?.name == null ? '' : userEntity!.name!,
            textAlign: TextAlign.right,
            style: TextStyle(
              color: const Color(0xFF0C0D0D) /* Grayscale-950 */,
              fontSize: 16,
              fontFamily: 'Cairo',
              fontWeight: FontWeight.w700,
            ),
          ),
          trailing: CustomNotificationWidget(),
        );
      },
    );
  }

  String getGreetingMessage() {
    final hour = DateTime.now().hour;
    if (hour < 12) {
      return 'صباح الخير !..';
    } else {
      return 'مساء الخير !..';
    }
  }
}
