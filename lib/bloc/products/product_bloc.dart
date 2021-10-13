import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xen_shop/bloc/products/product_event.dart';
import 'package:xen_shop/bloc/products/product_state.dart';
import 'package:xen_shop/models/error/error_model.dart';
import 'package:xen_shop/repository/product_repository/product_repository.dart';

class ProductBloc extends Bloc<ProductEvent, ProductState> {
  ProductRepository repository;

  ProductBloc(this.repository) : super(null);

  @override
  ProductState get initialState => ProductsInitial();

  @override
  Stream<ProductState> mapEventToState(
    ProductEvent event,
  ) async* {
    yield ProductsLoading();

    if (event is GetProducts) {
      try {
        final products = await repository.fetchProducts(event.category);
        yield ProductsLoaded(products);
      } on NetworkError catch (networkError) {
        yield ProductsError(repository.parseError(networkError.message));
      }
    }
  }
}
