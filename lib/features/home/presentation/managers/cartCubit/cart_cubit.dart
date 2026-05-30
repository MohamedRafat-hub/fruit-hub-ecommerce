import 'dart:developer';

import 'package:bloc/bloc.dart';
import 'package:fruit_hub/core/entities/product_entity.dart';
import 'package:fruit_hub/features/home/domain/entities/cart_entity.dart';
import 'package:fruit_hub/features/home/domain/entities/cart_item_entity.dart';
import 'package:meta/meta.dart';

part 'cart_state.dart';

class CartCubit extends Cubit<CartState> {
  CartCubit() : super(CartInitial());
  CartEntity cartEntity = CartEntity([]);

  void addProductToCart(ProductEntity productEntity) {
    bool isExist = cartEntity.isExistInCart(productEntity);
    log('is Exist item ${isExist.toString()}');
    if (isExist) {
      for (var cartItem in cartEntity.cartItems) {
        if (cartItem.productEntity == productEntity) {
          cartItem.increaseCount();
        }
      }
    } else {
      CartItemEntity cartItemEntity =
          CartItemEntity(productEntity: productEntity, quantity: 1);
      cartEntity.addCartItem(cartItemEntity);
    }
    emit(CartItemAdded());
  }


  void removeCartItem(CartItemEntity cartItemEntity){
    cartEntity.removeCartItem(cartItemEntity);
    emit(CartItemRemoved());
  }

  void clearCart() {
    cartEntity = CartEntity([]);
    emit(CartInitial());
  }
}
