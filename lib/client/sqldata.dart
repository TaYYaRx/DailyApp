import 'package:daily/pack.dart';

class SqlClient {
  DatabaseHelper _helper = locator.get<DatabaseHelper>();

  Future<List<Map>> getListFromDbForCategory() async {
    return await _helper.getAllCategories();
  }

  Future<int> addCategoryToSql(CategoryModel model) {
    return _helper.addCategoryToSQL(model);
  }

  Future<int> deleteCategoryFromSql(CategoryModel model) {
    return _helper.deleteCategory(model);
  }

  Future<int> updateCategorySql(CategoryModel model) {
    return _helper.updateCategory(model);
  }

//Todo
  Future<List<Map>> getListFromDbForCTodos() async {
    return await _helper.getAllTodos();
  }

  Future<int> addTodotoSQL(TodoModel model) {
    return _helper.addTodoToSQL(model);
  }

  Future<int> deleteTodoFromSql(TodoModel model) {
    return _helper.deleteTodo(model);
  }

  Future<int> updateTodoSql(TodoModel model) {
    return _helper.updateTodo(model);
  }
}
