import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:xen_shop/bloc/category/category_event.dart';
import 'package:xen_shop/bloc/category/category_state.dart';
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
    // Emitting a state from the asynchronous generator
    yield CategoryLoading();
    // Branching the executed logic by checking the event type
    if (event is GetCategory) {
      // Emit either Loaded or Error
      try {
        final categories = await repository.fetchCategoryList();
        yield CategoryLoaded(categories);
      } on NetworkError {
        yield CategoryError("Network Error");
      }
    }
  }
}
