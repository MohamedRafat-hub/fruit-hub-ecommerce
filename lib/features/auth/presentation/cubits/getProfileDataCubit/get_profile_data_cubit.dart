import 'package:bloc/bloc.dart';
import 'package:fruit_hub/core/services/firestore_service.dart';
import 'package:fruit_hub/features/auth/domain/entities/user_entity.dart';
import 'package:meta/meta.dart';

part 'get_profile_data_state.dart';

class GetProfileDataCubit extends Cubit<GetProfileDataState> {
  GetProfileDataCubit({required this.fireStoreService}) : super(GetProfileDataInitial());

  final FireStoreService fireStoreService;

  Future<void> getProfileData({required String uid}) async {
    emit(GetProfileDataLoading());
    try {
      var result = await fireStoreService.getData(
        path: 'users',
        documentId: uid,
      );
      emit(GetProfileDataSuccess(
        UserEntity(
          uid: result['uid'],
          name: result['name'],
          email: result['email'],
          profileImage: result['profileImage'],
        ),
      ));
    } catch (e) {
      emit(GetProfileDataFailure(e.toString()));
    }
  }
}
