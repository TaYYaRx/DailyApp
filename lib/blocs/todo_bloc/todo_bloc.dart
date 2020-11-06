import 'package:daily/pack.dart';

part 'todo_event.dart';
part 'todo_state.dart';

class TodoBloc extends Bloc<TodoEvent, TodoState> {
  DailyRepository _locator = locator.get<DailyRepository>();
  @override
  TodoState get initialState => TodoInitialState();

  @override
  Stream<TodoState> mapEventToState(
    TodoEvent event,
  ) async* {
    if (event is FetchAllTodosEvent) {
     // yield TodoLoadingState();

      var todos = await _locator.getListFromRepositoryForTodos();
      yield TodoLoadedState(todos: todos);

    } else if (event is AddTodoItemEvent) {//ADD
      await _locator.liftTodoModelToRepo(event.model);

      var todos = await _locator.getListFromRepositoryForTodos();
      yield TodoLoadedState(todos: todos);

    } else if (event is DeleteTodoItemEvent) {//DELETE
      await _locator.deleteTodo(event.model);

      var todos = await _locator.getListFromRepositoryForTodos();
      yield TodoLoadedState(todos: todos);

    } else if (event is UpdateTodoItemEvent) {//UPDATE
      await _locator.updateTodoModel(event.model);

      var todos = await _locator.getListFromRepositoryForTodos();
      yield TodoLoadedState(todos: todos);

    } else if (event is RefleshTodosEvent) {//REFLESH
      await _locator.refleshTodos(event.categoryId);

      var todos = await _locator.getListFromRepositoryForTodos();
      yield TodoLoadedState(todos: todos);

    } else if (event is ClearAllTodosEvent) {//CLEAR
      await _locator.deleteAllTodos(event.categoryId);

      var todos = await _locator.getListFromRepositoryForTodos();
      yield TodoLoadedState(todos: todos);
    }
  }
}
