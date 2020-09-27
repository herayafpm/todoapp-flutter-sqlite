import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/repository/todo_repository.dart';

part 'todobloc_event.dart';
part 'todobloc_state.dart';

class TodoBlocBloc extends Bloc<TodoBlocEvent, TodoBlocState> {
  TodoBlocBloc() : super(TodoBlocUninitialized());

  @override
  Stream<TodoBlocState> mapEventToState(
    TodoBlocEvent event,
  ) async* {
    if (event is TodoBlocGetList) {
      List<TodoModel> listTodo;
      if (state is TodoBlocUninitialized || event.refresh) {
        listTodo = await TodoRepository().getTodos();
        yield (listTodo.isEmpty)
            ? TodoBlocListEmpty()
            : TodoBlocListLoaded(listTodo: listTodo, hasReachMax: false);
      } else if (state is TodoBlocListLoaded) {
        TodoBlocListLoaded todoBlocListLoaded = state;
        listTodo = await TodoRepository()
            .getTodos(offset: todoBlocListLoaded.listTodo.length);
        yield (listTodo.isEmpty)
            ? todoBlocListLoaded.copyWith(hasReachMax: true)
            : TodoBlocListLoaded(
                listTodo: todoBlocListLoaded.listTodo + listTodo,
                hasReachMax: false);
      }
    } else if (event is TodoBlocGet) {
      TodoModel todoModel;
      if (state is TodoBlocUninitialized || event.refresh) {
        todoModel = await TodoRepository().getTodo(event.id);
        yield TodoBlocLoaded(
          todoModel,
        );
      }
    } else if (event is TodoBlocInsert) {
      TodoModel todoModel = event.todoModel;
      if (todoModel.id == 0) {
        print("data insert");
        await TodoRepository().insertTodo(todoModel);
      } else {
        print("data update");
        await TodoRepository().updateTodo(todoModel);
      }
      yield TodoBlocLoaded(event.todoModel);
    } else if (event is TodoBlocDelete) {
      TodoModel todoModel = event.todoModel;
      await TodoRepository().deleteTodo(todoModel.id);
      yield TodoBlocUninitialized();
    }
  }
}
