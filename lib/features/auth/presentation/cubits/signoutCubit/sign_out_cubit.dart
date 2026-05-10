import 'package:bloc/bloc.dart';
import 'package:fruit_hub/core/errors/failure.dart';
import 'package:fruit_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:meta/meta.dart';

part 'sign_out_state.dart';

class SignOutCubit extends Cubit<SignOutState> {
  SignOutCubit({required this.authRepo}) : super(SignOutInitial());
  final AuthRepo authRepo;

  Future<void> signOut() async {
    emit(SignOutLoading());
    final result = await authRepo.signOut();
    result.fold(
        (failure) =>
            emit(SignOutFailure(ServerFailure(failure.message).toString())),
        (_) => emit(SignOutSuccess()));
  }
}
