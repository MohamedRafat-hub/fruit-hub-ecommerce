part of 'get_profile_data_cubit.dart';

@immutable
sealed class GetProfileDataState {}

final class GetProfileDataInitial extends GetProfileDataState {}
final class GetProfileDataLoading extends GetProfileDataState {}
final class GetProfileDataSuccess extends GetProfileDataState {
  final UserEntity userEntity;

  GetProfileDataSuccess(this.userEntity);

}
final class GetProfileDataFailure extends GetProfileDataState {
  final String errorMessage;

  GetProfileDataFailure(this.errorMessage);
}

