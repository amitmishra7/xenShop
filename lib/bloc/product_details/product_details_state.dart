import 'package:equatable/equatable.dart';
import 'package:xen_shop/models/product/product_model.dart';

abstract class ProductDetailsState extends Equatable {
  const ProductDetailsState();
}

class ProductDetailsInitial extends ProductDetailsState {
  const ProductDetailsInitial();
  @override
  List<Object> get props => [];
}

class ProductDetailsLoading extends ProductDetailsState {
  const ProductDetailsLoading();
  @override
  List<Object> get props => [];
}

class ProductDetailsLoaded extends ProductDetailsState {
  final ProductModel product;
  const ProductDetailsLoaded(this.product);
  @override
  List<Object> get props => [product];
}

class ProductDetailsError extends ProductDetailsState {
  final String message;
  const ProductDetailsError(this.message);
  @override
  List<Object> get props => [message];
}