import 'package:fruit_hub/features/checkout/domain/entities/shipping_address_entity.dart';
import 'package:fruit_hub/features/home/domain/entities/cart_entity.dart';

class OrderEntity {
  final String uid;
  final CartEntity cartEntity;
  bool? payWithCache;
  // final String orderNumber;
  ShippingAddressEntity shippingAddress;

  OrderEntity(
      {this.payWithCache,
       required this.shippingAddress,
      required this.cartEntity, required this.uid });


  int calculateShippingDiscount()
  {
    return 0;
  }


  double calculateShippingCost()
  {
    return 30.0;
  }


  num calculateTotalPriceWithShipping()
  {
    return cartEntity.calculateTotalPrice() + calculateShippingDiscount() + calculateShippingCost();
  }


  String getCurrency()
  {
    return "EG";
  }
}
