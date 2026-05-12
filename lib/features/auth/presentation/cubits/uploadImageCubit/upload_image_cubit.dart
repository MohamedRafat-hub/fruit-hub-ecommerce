import 'package:bloc/bloc.dart';
import 'package:fruit_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:fruit_hub/features/auth/domain/repos/image_repo.dart';
import 'package:meta/meta.dart';
part 'upload_image_state.dart';

class UploadImageCubit extends Cubit<UploadImageState> {
  UploadImageCubit({required this.imageRepo, required this.authRepo}) : super(UploadImageInitial());
  final ImageRepo imageRepo;
  final AuthRepo authRepo;
  Future<void> uploadImage({required String path ,required String fileName , required String uid})async {
    emit(UploadImageLoading());
    var result =await imageRepo.uploadImage(path, fileName);
    result.fold((error){
      emit(UploadImageFailure(error.message));
    }, (imageUrl)async{
      var updateResult = await authRepo.updateUserProfileImage(uid: uid, imageUrl: imageUrl);
      updateResult.fold((error){
        emit(UploadImageFailure(error.message));
      }, (success){
        emit(UploadImageSuccess(imageUrl));
      });
    });
  }
}
