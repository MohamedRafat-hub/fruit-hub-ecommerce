import '../../domain/entities/shipping_address_entity.dart';

class ShippingAddressModel {
  String? name;
  String? address;
  String? city;
  String? phoneNumber;

  ShippingAddressModel({ this.name,
    this.address,
    this.city,
    this.phoneNumber,
  });

  factory ShippingAddressModel.fromEntity(ShippingAddressEntity entity) {
    return ShippingAddressModel(
        name: entity.name,
        address: entity.address,
        city: entity.city,
        phoneNumber: entity.phoneNumber,
     );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'address': address,
      'city': city,
      'phoneNumber': phoneNumber,
    };
  }
}