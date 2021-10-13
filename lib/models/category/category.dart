import 'package:equatable/equatable.dart';

class Category extends Equatable {
  final String categoryName;

  Category({this.categoryName});

  @override
  List<Object> get props => [categoryName];

}
