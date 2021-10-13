import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xen_shop/bloc/product_details/product_details.dart';
import 'package:xen_shop/bloc/product_details/product_details_state.dart';
import 'package:xen_shop/bloc/products/product_event.dart';
import 'package:xen_shop/bloc/products/product_state.dart';
import 'package:xen_shop/models/error/error_model.dart';
import 'package:xen_shop/repository/product_repository/product_repository.dart';

class ProductDetailsBloc
    extends Bloc<ProductDetailsEvent, ProductDetailsState> {
  ProductRepository repository;

  ProductDetailsBloc(this.repository) : super(null);

  @override
  ProductDetailsState get initialState => ProductDetailsInitial();

  @override
  Stream<ProductDetailsState> mapEventToState(
    ProductDetailsEvent event,
  ) async* {
    yield ProductDetailsLoading();
    if (event is GetProductDetails) {
      try {
        final products = await repository.fetchProductDetails(event.id);
        yield ProductDetailsLoaded(products);
      } on NetworkError catch (networkError) {
        yield ProductDetailsError(repository.parseError(networkError.message));
      }
    }
  }
}
