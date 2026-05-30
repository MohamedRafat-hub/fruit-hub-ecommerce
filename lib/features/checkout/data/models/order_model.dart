import 'package:fruit_hub/features/checkout/data/models/shipping_address_model.dart';
import '../../domain/entities/order_entity.dart';
import 'order_prodct_model.dart';

class OrderModel {
  final num totalPrice;
  final String uid;
  final ShippingAddressModel shippingAddressModel;
  final List<OrderProductModel> orderProducts;
  final String paymentMethod;
  final int orderNumber;

  OrderModel(
      {required this.totalPrice,
        required this.uid,
        required this.shippingAddressModel,
        required this.orderProducts,
        required this.paymentMethod, required this.orderNumber});

  factory OrderModel.fromEntity(OrderEntity entity , {required int orderNumber}) {
    return OrderModel(
      orderNumber: orderNumber,
        totalPrice: entity.cartEntity.calculateTotalPrice(),
        uid: entity.uid,
        shippingAddressModel:
        ShippingAddressModel.fromEntity(entity.shippingAddress),
        orderProducts: entity.cartEntity.cartItems
            .map((e) => OrderProductModel.fromEntity(e))
            .toList(),
        paymentMethod: entity.payWithCache! ? 'Cache' : 'Online');
  }

  Map<String, dynamic> toJson() {
    return {
      'orderNumber': orderNumber,
      'status':"pending",
      'totalPrice': totalPrice,
      'uid': uid,
      'date':DateTime.now().toString(),
      'paymentMethod': paymentMethod,
      'shippingAddressModel': shippingAddressModel.toJson(),
      'orderProducts': orderProducts.map((e) => e.toJson()).toList(),
    };
  }
}