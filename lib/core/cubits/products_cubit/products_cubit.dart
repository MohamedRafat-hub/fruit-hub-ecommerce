import 'package:bloc/bloc.dart';
import 'package:fruit_hub/core/entities/product_entity.dart';
import 'package:fruit_hub/core/repos/product_repo.dart';
import 'package:meta/meta.dart';

part 'products_state.dart';

class ProductsCubit extends Cubit<ProductsState> {
  ProductsCubit(this.productRepo) : super(ProductsInitial());

  final ProductRepo productRepo;
  int productsLength = 0;
  List<ProductEntity> allProducts = [];

  Future<void> getBestSellingProducts() async {
    emit(ProductsLoading());
    var result = await productRepo.getBestSellingProducts();
    result.fold((failure) {
      emit(ProductsFailure(failure.message));
    }, (products) {
      allProducts = products;
      emit(ProductsSuccess(products));
    });
  }

  Future<void> getProducts() async {
    emit(ProductsLoading());

    var result = await productRepo.getProducts();

    result.fold((failure) {
      emit(ProductsFailure(failure.message));
    }, (products) {
      productsLength = products.length;
      allProducts = products;
      emit(ProductsSuccess(products));
    });
  }

  void searchProduct(String query) {
    if (query.isEmpty) {
      emit(ProductsSuccess(allProducts));
      return;
    }
    final filtered = allProducts.where((product) {
      return product.name.toLowerCase().contains(query.toLowerCase());
    }).toList();
    emit(ProductsSuccess(filtered));
  }

}
