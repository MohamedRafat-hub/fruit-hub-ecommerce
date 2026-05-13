import 'dart:math';

import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:fruit_hub/features/home/domain/repos/favourite_repo.dart';
import 'package:meta/meta.dart';

part 'favourite_state.dart';

class FavouriteCubit extends Cubit<FavouriteState> {
  FavouriteCubit({required this.favouriteRepo}) : super(FavouriteInitial());
  final FavouriteRepo favouriteRepo;
  List<String> favouriteIds = [];

  Future<void> addToFavourite(String productId) async {
    emit(FavouriteLoading());
    var result = await favouriteRepo.addToFavourite(productId);
    result.fold((error) {
      emit(FavouriteFailure(error.message));
    }, (success) {
      favouriteIds.add(productId);
      emit(FavouriteSuccess(
        favouriteProducts: favouriteIds,
      ));
    });
  }

  Future<void> removeFromFavourite(String productId) async {
    emit(FavouriteLoading());
    var result = await favouriteRepo.removeFromFavourite(productId);
    result.fold((error) {
      emit(FavouriteFailure(error.message));
    }, (success) {
      favouriteIds.remove(productId);
      emit(FavouriteSuccess(favouriteProducts: favouriteIds));
    });
  }

  Future<void> getFavouriteProducts() async {
    emit(FavouriteLoading());
    var result = await favouriteRepo.getFavouriteProductsIds();
    result.fold((error) {
      emit(FavouriteFailure(error.message));
    }, (favProducts) {
      favouriteIds = favProducts;
      emit(FavouriteSuccess(favouriteProducts: favProducts));
    });
  }
}
