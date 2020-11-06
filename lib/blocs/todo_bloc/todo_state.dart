part of 'todo_bloc.dart';

abstract class TodoState extends Equatable {
  const TodoState();
}

class TodoInitialState extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoadingState extends TodoState {
  @override
  List<Object> get props => [];
}

class TodoLoadedState extends TodoState {
  //final List<Map> todos;
  final List<TodoModel> todos;

  TodoLoadedState({@required this.todos});
  Map<String, double> calcDetails() {
    /// Map<String,double> map = {'percentage':double,'completed':double,'uncompleted':double}
    double number = 0.0;
    Map<String, double> map = Map();
    todos.forEach((todoInstance) {
      // Tüm Todo elemanlarını gez ve Done olanların sayısını belirle
      if (todoInstance.getIsDone == 1) {
        number++;
      }
    });
    map = {
      'percentage': (number / todos.length),
      'completed': number,
      'uncompleted': (todos.length - number)
    };
    return map;
  }

  List<TodoModel> entireList(int catId) {
    List<TodoModel> entireList = List();
    todos.forEach((todoInstance) {
      if (todoInstance.getKategoriId == catId) {
        entireList.add(todoInstance);
      }
    });
    return entireList;
  }

  List<TodoModel> todoUncompleted(int catId) {
    List<TodoModel> unCompletedList = List();
    var newTodos = entireList(catId);
    newTodos.forEach((todoInstance) {
      if (todoInstance.getIsDone == 0) {
        unCompletedList.add(todoInstance); //0-> UnCompleted, 1->Completed
      }
    });
    return unCompletedList;
  }

  List<TodoModel> todoCompleted(int catId) {
    List<TodoModel> completedList = List();
    var newTodos = entireList(catId);
    newTodos.forEach((todoInstance) {
      if (todoInstance.getIsDone == 1) {
        //0-> UnCompleted, 1-> Completed
        completedList.add(todoInstance);
      }
    });
    return completedList;
  }

  List<TodoModel> todoCompletedTotal() {
    List<TodoModel> total = List();
    todos.forEach((element) {
      if (element.getIsDone == 1) {
        total.add(element);
      }
    });

    return total;
  }

  double percentage(int kategorID) {
    List coletedList = todoCompleted(kategorID);
    List entList = entireList(kategorID);

    double result = (coletedList.length / entList.length);

    return result;
  }

  @override
  List<Object> get props => [todos];
}

class TodoErrorState extends TodoState implements Exception {
  final String error;

  TodoErrorState({this.error});

  @override
  List<Object> get props => [];
}
