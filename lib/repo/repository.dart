import 'package:daily/pack.dart';


class DailyRepository {
  SqlClient _locatorSql = locator.get<SqlClient>();

  //Category
  Future<List<CategoryModel>> getListFromRepositoryForCategories() async {
    List<CategoryModel> categoryFromSQL = List();
    await _locatorSql.getListFromDbForCategory().then((list) {
      list.forEach((map) {
        categoryFromSQL.add(CategoryModel.factoryFromMap(map));
      });
    });

    return categoryFromSQL;
  }

  Future<int> liftCategoryModelToRepo(CategoryModel model) {
    return _locatorSql.addCategoryToSql(model);
  }

  Future<int> deleteCategory(CategoryModel model) {
    return _locatorSql.deleteCategoryFromSql(model);
  }

  Future<int> updateCategoryModel(CategoryModel model) {
    return _locatorSql.updateCategorySql(model);
  }

  //Todo--
  Future<List<TodoModel>> getListFromRepositoryForTodos() async {
    List<TodoModel> todosFromSQL = List();
    await _locatorSql.getListFromDbForCTodos().then((list) {
      list.forEach((map) {
        todosFromSQL.add(TodoModel.factoryFromMap(map));
      });
    });
    return todosFromSQL;
  }

  Future<int> liftTodoModelToRepo(TodoModel model) {
    return _locatorSql.addTodotoSQL(model);
  }

  Future<int> deleteTodo(TodoModel model) {
    return _locatorSql.deleteTodoFromSql(model);
  }

  Future<int> updateTodoModel(TodoModel model) {
    return _locatorSql.updateTodoSql(model);
  }

  refleshTodos(int catId) {
    getListFromRepositoryForTodos().then((list) {
      list.forEach((todo) {
        if (todo.getIsDone == 1 && todo.getKategoriId == catId) {
          var model = TodoModel.withID(
              todo.getTodoId, todo.getTitle, 0, todo.getKategoriId,
              content: todo.getContent);
          updateTodoModel(model);
        }
      });
    });
  }

  deleteAllTodos(int catId) {
    getListFromRepositoryForTodos().then((list) {
      list.forEach((todo) {
        if (todo.getKategoriId == catId) {
          deleteTodo(todo);
        }
      });
    });
  }
}
