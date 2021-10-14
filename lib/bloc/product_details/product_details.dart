import 'package:equatable/equatable.dart';

abstract class ProductDetailsEvent extends Equatable {
  const ProductDetailsEvent();
}

class GetProductDetails extends ProductDetailsEvent {
  final int id;

  const GetProductDetails({this.id});

  @override
  List<Object> get props => [];
}
