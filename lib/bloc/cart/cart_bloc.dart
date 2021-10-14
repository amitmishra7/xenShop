import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xen_shop/bloc/cart/cart_event.dart';
import 'package:xen_shop/bloc/cart/cart_state.dart';
import 'package:xen_shop/models/error/error_model.dart';
import 'package:xen_shop/repository/cart_repository/cart_repository.dart';

class CartBloc extends Bloc<CartEvent, CartState> {
  CartRepository repository;

  CartBloc(this.repository) : super(null);

  @override
  CartState get initialState => CartInitial();

  @override
  Stream<CartState> mapEventToState(
    CartEvent event,
  ) async* {
    yield CartLoading();

    if (event is GetCart) {
      try {
        final cart = await repository.fetchCart();
        yield CartLoaded(cart.products);
      } on NetworkError catch (networkError) {
        yield CartError(repository.parseError(networkError.message));
      }
    } else if (event is UpdateCart) {
      yield CartLoaded(event.cartList);
    }
  }
}
