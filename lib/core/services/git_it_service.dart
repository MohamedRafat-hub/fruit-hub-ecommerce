import 'package:fruit_hub/core/repos/product_repo.dart';
import 'package:fruit_hub/core/repos/product_repo_impl.dart';
import 'package:fruit_hub/core/services/cloudinary_storage.dart';
import 'package:fruit_hub/core/services/database_service.dart';
import 'package:fruit_hub/core/services/firebase_auth_service.dart';
import 'package:fruit_hub/core/services/firestore_service.dart';
import 'package:fruit_hub/core/services/storage_service.dart';
import 'package:fruit_hub/features/auth/data/repos/auth_repo_impl.dart';
import 'package:fruit_hub/features/auth/domain/repos/auth_repo.dart';
import 'package:fruit_hub/features/auth/domain/repos/image_repo.dart';
import 'package:fruit_hub/features/checkout/data/repos/add_order_repo_impl.dart';
import 'package:fruit_hub/features/checkout/domain/repos/add_order_repo.dart';
import 'package:fruit_hub/features/home/data/repos/favourite_repo_impl.dart';
import 'package:fruit_hub/features/home/domain/repos/favourite_repo.dart';
import 'package:get_it/get_it.dart';
import 'package:http/http.dart';

import '../../features/auth/data/repos/image_repo_impl.dart';

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

  getIt.registerSingleton<StorageService>(
    CloudinaryStorage(),
  );

  getIt
      .registerSingleton<ImageRepo>(ImageRepoImpl(getIt.get<StorageService>()));

  getIt.registerSingleton<FavouriteRepo>(
      FavouriteRepoImpl(getIt.get<DatabaseService>()));
}
