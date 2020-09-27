import 'package:sqflite/sqlite_api.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/services/sqlite_service.dart';

class TodoRepository {
  String _table = 'todo';
  String _id = 'id';
  String _title = 'title';
  String _content = 'content';
  String _created = 'created';
  String _updated = 'updated';
  SqliteService sqliteHelper = SqliteService();
  Future<List<TodoModel>> getTodos({int limit = 10, int offset}) async {
    Database db = await sqliteHelper.initDb();
    var listData = await db.query(_table,
        orderBy: 'created DESC', limit: limit, offset: offset);
    List<TodoModel> listTodos = await TodoModel.createList(listData);
    return listTodos;
  }

  Future<TodoModel> getTodo(int id) async {
    Database db = await sqliteHelper.initDb();
    var data = await db.query(_table, where: '$_id = ?', whereArgs: [id]);
    if (data.isEmpty) {
      return TodoModel.dummyTodo();
    } else {
      TodoModel todoModel = await TodoModel.create(data.first);
      return todoModel;
    }
  }

  Future<int> insertTodo(TodoModel todoModel) async {
    Database db = await sqliteHelper.initDb();
    return db.insert(_table, todoModel.toJson());
  }

  Future<int> updateTodo(TodoModel todoModel) async {
    Database db = await sqliteHelper.initDb();
    return db.update(_table, todoModel.toJson(updated: true),
        where: '$_id = ?', whereArgs: [todoModel.id]);
  }

  Future<int> deleteTodo(int id) async {
    Database db = await sqliteHelper.initDb();
    return db.delete(_table, where: '$_id = ?', whereArgs: [id]);
  }
}
