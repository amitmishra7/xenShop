import 'package:equatable/equatable.dart';
import 'package:xen_shop/models/cart/cart_model.dart';

abstract class CartEvent extends Equatable {
  const CartEvent();
}

class GetCart extends CartEvent {
  const GetCart();

  @override
  List<Object> get props => [];
}

class UpdateCart extends CartEvent {
  final List<Products> cartList;
  const UpdateCart(this.cartList);

  @override
  List<Object> get props => [cartList];
}
