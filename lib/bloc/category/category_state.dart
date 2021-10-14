import 'package:equatable/equatable.dart';
import 'package:xen_shop/models/category/category.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitial extends CategoryState {
  const CategoryInitial();
  @override
  List<Object> get props => [];
}

class CategoryLoading extends CategoryState {
  const CategoryLoading();
  @override
  List<Object> get props => [];
}

class CategoryLoaded extends CategoryState {
  final List<Category> categories;
  const CategoryLoaded(this.categories);
  @override
  List<Object> get props => [categories];
}

class CategoryError extends CategoryState {
  final String message;
  const CategoryError(this.message);
  @override
  List<Object> get props => [message];
}