import 'package:equatable/equatable.dart';
import 'package:xen_shop/models/product/product_model.dart';

abstract class ProductState extends Equatable {
  const ProductState();
}

class ProductsInitial extends ProductState {
  const ProductsInitial();
  @override
  List<Object> get props => [];
}

class ProductsLoading extends ProductState {
  const ProductsLoading();
  @override
  List<Object> get props => [];
}

class ProductsLoaded extends ProductState {
  final List<ProductModel> products;
  const ProductsLoaded(this.products);
  @override
  List<Object> get props => [products];
}

class ProductsError extends ProductState {
  final String message;
  const ProductsError(this.message);
  @override
  List<Object> get props => [message];
}