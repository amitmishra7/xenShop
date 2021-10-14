import 'package:equatable/equatable.dart';

abstract class CategoryEvent extends Equatable {
  const CategoryEvent();
}

class GetCategory extends CategoryEvent {
  const GetCategory();

  @override
  List<Object> get props => [];
}
