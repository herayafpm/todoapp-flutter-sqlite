part of 'todobloc_bloc.dart';

@immutable
abstract class TodoBlocState {}

class TodoBlocUninitialized extends TodoBlocState {}

class TodoBlocLoading extends TodoBlocState {}

class TodoBlocListEmpty extends TodoBlocState {}

class TodoBlocLoaded extends TodoBlocState {
  final TodoModel todoModel;
  TodoBlocLoaded(this.todoModel);
}

class TodoBlocListLoaded extends TodoBlocState {
  final List<TodoModel> listTodo;
  final bool hasReachMax;
  TodoBlocListLoaded({this.listTodo, this.hasReachMax});
  TodoBlocListLoaded copyWith({List<TodoModel> listTodo, bool hasReachMax}) {
    return TodoBlocListLoaded(
        listTodo: listTodo ?? this.listTodo,
        hasReachMax: hasReachMax ?? this.hasReachMax);
  }
}

class TodoBlocError extends TodoBlocState {
  final String message;

  TodoBlocError(this.message);
}
