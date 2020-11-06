part of 'category_bloc.dart';

abstract class CategoryState extends Equatable {
  const CategoryState();
}

class CategoryInitialState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryLoadedState extends CategoryState {
  final List<CategoryModel> categories;

  CategoryLoadedState({@required this.categories});

  @override
  List<Object> get props => [categories];
}

class CategoryLoadingState extends CategoryState {
  @override
  List<Object> get props => [];
}

class CategoryErrorState extends CategoryState implements Exception{
  final String e;
  String exception()=>e;
  CategoryErrorState({this.e});
  @override
  List<Object> get props => [];
}
