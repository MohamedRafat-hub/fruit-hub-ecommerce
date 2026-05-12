import 'dart:developer' show log;

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:fruit_hub/core/helper_functions/build_show_snack_bar.dart';
import 'package:fruit_hub/features/auth/presentation/cubits/uploadImageCubit/upload_image_cubit.dart';
import 'package:gap/gap.dart';
import 'package:image_picker/image_picker.dart';

class UserData extends StatelessWidget {
  const UserData({super.key});

  Future<void> _pickAndUploadImage(BuildContext context) async {
    final picker = ImagePicker();
    final pickedFile = await picker.pickImage(source: ImageSource.gallery);
    if (pickedFile != null) {
      final fileName = pickedFile.name;
      final path = pickedFile.path;

      if (context.mounted) {
        context
            .read<UploadImageCubit>()
            .uploadImage(path: path, fileName: fileName , uid: FirebaseAuth.instance.currentUser!.uid);
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        BlocConsumer<UploadImageCubit, UploadImageState>(
          listener: (context, state) {
            if(state is UploadImageFailure)
              {
                log("error is ${state.errorMessage}");
                showSnackBar(context, message: state.errorMessage, color: Colors.red);
              }
            else if(state is UploadImageSuccess)
              {
                showSnackBar(context, message:'تم رفع الصورة بنجاح ✅');
              }
          },
          builder: (context, state) {
            return GestureDetector(
              onTap: () {
                _pickAndUploadImage(context);
              },
              child: Stack(
                alignment: Alignment.bottomLeft,
                children: [
                  CircleAvatar(
                    radius: 45,
                    backgroundImage: NetworkImage(
                        'https://via.placeholder.com/150'), // حط صورتك هنا
                  ),
                  CircleAvatar(
                    radius: 15,
                    backgroundColor: Colors.white,
                    child: Icon(Icons.camera_alt_outlined,
                        size: 18, color: Colors.green[700]),
                  ),
                ],
              ),
            );
          },
        ),
        Gap(10),
        Column(
          children: [
            const Text(
              'أحمد ياسر',
              style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            Text(
              'mail@mail.com',
              style: TextStyle(color: Colors.grey[600]),
            ),
          ],
        ),
      ],
    );
  }
}
