part of 'todobloc_bloc.dart';

@immutable
abstract class TodoBlocEvent {}

class TodoBlocGetList extends TodoBlocEvent {
  final bool refresh;

  TodoBlocGetList({this.refresh = false});
}

class TodoBlocGet extends TodoBlocEvent {
  final int id;
  final bool refresh;

  TodoBlocGet({this.id = 0, this.refresh = false});
}

class TodoBlocInsert extends TodoBlocEvent {
  final TodoModel todoModel;

  TodoBlocInsert(this.todoModel);
}

class TodoBlocDelete extends TodoBlocEvent {
  final TodoModel todoModel;

  TodoBlocDelete(this.todoModel);
}
