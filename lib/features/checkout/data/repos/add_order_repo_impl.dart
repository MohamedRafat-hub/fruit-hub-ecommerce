import 'package:dartz/dartz.dart';

import 'package:fruit_hub/core/errors/failure.dart';
import 'package:fruit_hub/core/services/database_service.dart';
import 'package:fruit_hub/core/utils/backend_endpoint.dart';
import 'package:fruit_hub/features/checkout/data/models/order_model.dart';

import 'package:fruit_hub/features/checkout/domain/entities/order_entity.dart';

import '../../domain/repos/add_order_repo.dart';

class AddOrderRepoImpl implements AddOrderRepo {
  final DatabaseService databaseService;

  AddOrderRepoImpl(this.databaseService);

  @override
  Future<Either<Failure, void>> addOrder({required OrderEntity orderEntity})async {
    try {
      final orderNumber = await databaseService.getNextOrderNumber(path: BackendEndpoint.counters, doc: BackendEndpoint.orders);
      databaseService.addData(
          path: BackendEndpoint.orders,
          data: OrderModel.fromEntity(orderEntity , orderNumber: orderNumber).toJson());
      return right(null);
    }catch (e) {
      return left(ServerFailure(e.toString()));
    }
  }
}
