part of 'todo_bloc.dart';

abstract class TodoEvent extends Equatable {
  const TodoEvent();
}

class FetchAllTodosEvent extends TodoEvent {
  @override
  List<Object> get props => [];
}

class AddTodoItemEvent extends TodoEvent {
  final TodoModel model;

  AddTodoItemEvent({@required this.model});

  @override
  List<Object> get props => [model];
}

class DeleteTodoItemEvent extends TodoEvent {
  final TodoModel model;

  DeleteTodoItemEvent({@required this.model});

  @override
  List<Object> get props => [model];
}

class UpdateTodoItemEvent extends TodoEvent {
  final TodoModel model;

  UpdateTodoItemEvent({@required this.model});

  @override
  List<Object> get props => [model];
}

class RefleshTodosEvent extends TodoEvent {
  final int categoryId;

  RefleshTodosEvent({@required this.categoryId});

  @override
  List<Object> get props => [categoryId];
}

class ClearAllTodosEvent extends TodoEvent {
  final int categoryId;

  ClearAllTodosEvent({@required this.categoryId});

  @override
  List<Object> get props => throw UnimplementedError();
}
