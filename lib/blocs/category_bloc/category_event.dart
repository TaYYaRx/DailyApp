part of 'category_bloc.dart';

abstract class DailyEvent extends Equatable {
  const DailyEvent();
}

class FetchAllDailysEventForCategory extends DailyEvent {
  @override
  List<Object> get props => throw UnimplementedError();
}

class AddCategoryEvent extends DailyEvent {
  final CategoryModel model;

  AddCategoryEvent({@required this.model});
  @override
  List<Object> get props => [model];
}

class DeleteCategoryEvent extends DailyEvent {
  final CategoryModel model;

  DeleteCategoryEvent({@required this.model});
  @override
  List<Object> get props => [model];
}

class UpdateCategoryEvent extends DailyEvent {
  final CategoryModel model;

  UpdateCategoryEvent({@required this.model});

  @override
  List<Object> get props => [model];
}


