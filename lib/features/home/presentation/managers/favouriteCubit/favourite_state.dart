part of 'favourite_cubit.dart';

@immutable
sealed class FavouriteState {}

final class FavouriteInitial extends FavouriteState {}
final class FavouriteLoading extends FavouriteState {}
final class FavouriteSuccess extends FavouriteState {
  List<String>? favouriteProducts = [];
  FavouriteSuccess({this.favouriteProducts});
}
final class FavouriteFailure extends FavouriteState {
  final String errorMessage;
  FavouriteFailure(this.errorMessage);
}
