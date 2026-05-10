import 'package:fruit_hub/core/repos/product_repo.dart';
import 'package:fruit_hub/core/repos/product_repo_impl.dart';
import 'package:fruit_hub/core/services/database_service.dart';
import 'package:fruit_hub/core/services/firebase_auth_service.dart';
import 'package:fruit_hub/core/services/firestore_service.dart';
import 'package:fruit_hub/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruit_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:fruit_hub/features/checkout/data/repos/add_order_repo_impl.dart';
import 'package:fruit_hub/features/checkout/domain/repos/add_order_repo.dart';
import 'package:get_it/get_it.dart';

GetIt getIt = GetIt.instance;

void setupLocator() {
  getIt.registerSingleton<FirebaseAuthService>(FirebaseAuthService());
  getIt.registerSingleton<DatabaseService>(FireStoreService());
  getIt.registerSingleton<AuthRepo>(AuthRepoImpl(
      databaseService: getIt.get<DatabaseService>(),
      firebaseAuthService: getIt.get<FirebaseAuthService>()));

  getIt.registerSingleton<ProductRepo>(
      ProductRepoImpl(getIt.get<DatabaseService>()));

  getIt.registerSingleton<AddOrderRepo>(
      AddOrderRepoImpl(getIt.get<DatabaseService>()));

}
