import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xen_shop/bloc/category/category_event.dart';
import 'package:xen_shop/bloc/category/category_state.dart';
import 'package:xen_shop/models/error/error_model.dart';
import 'package:xen_shop/repository/category/category_repository.dart';

class CategoryBloc extends Bloc<CategoryEvent, CategoryState> {
  CategoryRepository repository;

  CategoryBloc(this.repository) : super(null);

  @override
  CategoryState get initialState => CategoryInitial();

  @override
  Stream<CategoryState> mapEventToState(
    CategoryEvent event,
  ) async* {
    yield CategoryLoading();
    if (event is GetCategory) {
      try {
        final categories = await repository.fetchCategoryList();
        yield CategoryLoaded(categories);
      } on NetworkError catch (networkError) {
        yield CategoryError(repository.parseError(networkError.message));
      }
    }
  }
}
