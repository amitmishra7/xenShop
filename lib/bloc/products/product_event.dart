import 'package:equatable/equatable.dart';

abstract class ProductEvent extends Equatable {
  const ProductEvent();
}

class GetProducts extends ProductEvent {
  final String category;

  const GetProducts({this.category});

  @override
  List<Object> get props => [];
}
