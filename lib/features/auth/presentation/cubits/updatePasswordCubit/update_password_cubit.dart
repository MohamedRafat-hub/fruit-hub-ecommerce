import 'package:bloc/bloc.dart';
import 'package:fruit_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'update_password_state.dart';

class UpdatePasswordCubit extends Cubit<UpdatePasswordState> {
  UpdatePasswordCubit({required this.authRepo}) : super(UpdatePasswordInitial());

  final AuthRepo authRepo;

  Future<void> updatePassword({
    required String currentPassword,
    required String newPassword,
    required String confirmPassword,
  }) async {
    if (newPassword != confirmPassword) {
      emit(UpdatePasswordFailure('كلمة المرور الجديدة غير متطابقة!'));
      return;
    }

    emit(UpdatePasswordLoading());
    var result = await authRepo.updatePassword(password: currentPassword, newPassword: newPassword);
    result.fold((error) {
      emit(UpdatePasswordFailure(error.message));
    }, (_) {
      emit(UpdatePasswordSuccess());
    });
  }
}