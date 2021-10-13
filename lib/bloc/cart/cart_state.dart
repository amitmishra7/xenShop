import 'package:equatable/equatable.dart';
import 'package:xen_shop/models/cart/cart_model.dart';
import 'package:xen_shop/models/product/product_model.dart';

abstract class CartState extends Equatable {
  const CartState();
}

class CartInitial extends CartState {
  const CartInitial();
  @override
  List<Object> get props => [];
}

class CartLoading extends CartState {
  const CartLoading();
  @override
  List<Object> get props => [];
}

class CartLoaded extends CartState {
  final CartModel cart;
  const CartLoaded(this.cart);
  @override
  List<Object> get props => [cart];
}

class CartError extends CartState {
  final String message;
  const CartError(this.message);
  @override
  List<Object> get props => [message];
}