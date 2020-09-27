import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todoapp/bloc/todo/todobloc_bloc.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:get/get.dart';

class CuTodoController extends GetxController {
  final TodoModel todoModel;
  CuTodoController({this.todoModel = null});
  final todo = TodoModel().obs;
  initTodo(TodoModel todoModel) {
    todo.update((val) {
      val.id = todoModel.id;
      val.title = todoModel.title;
      val.content = todoModel.content;
      val.updated = todoModel.updated;
      val.created = todoModel.created;
    });
  }

  @override
  void onInit() {
    initTodo(this.todoModel);
    super.onInit();
  }
}

class CuTodoPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocProvider<TodoBlocBloc>(
        create: (context) =>
            TodoBlocBloc()..add(TodoBlocGet(id: Get.arguments['id'])),
        child: TodoItemView());
  }
}

class TodoItemView extends GetView<CuTodoController> {
  TodoBlocBloc todoBlocBloc;
  @override
  Widget build(BuildContext context) {
    todoBlocBloc = BlocProvider.of<TodoBlocBloc>(context);
    return BlocBuilder<TodoBlocBloc, TodoBlocState>(
      builder: (context, state) {
        if (state is TodoBlocLoaded) {
          TodoModel todoModel = state.todoModel;
          return GetX<CuTodoController>(
            init: CuTodoController(todoModel: todoModel),
            builder: (_) => Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: Icon(
                    Icons.arrow_left,
                    size: 40,
                  ),
                  onPressed: () => Get.offAllNamed('/'),
                ),
                actions: [
                  IconButton(
                      icon: Icon(Icons.save),
                      onPressed: () {
                        todoBlocBloc..add(TodoBlocInsert(_.todo.value));
                      }),
                  (todoModel.id != 0)
                      ? IconButton(
                          icon: Icon(Icons.delete),
                          onPressed: () {
                            todoBlocBloc..add(TodoBlocDelete(_.todo.value));
                            Get.offAllNamed("/");
                          })
                      : Container()
                ],
                elevation: 0,
                backgroundColor: Colors.transparent,
                title: TextFormField(
                  initialValue: _.todo.value.title ?? 'empty_title'.tr,
                  onChanged: (value) {
                    _.todo.update((val) {
                      val.title = value;
                    });
                  },
                  style: TextStyle(color: Colors.white),
                  decoration: InputDecoration(
                      border: InputBorder.none,
                      hintText: "empty_title".tr,
                      hintStyle: TextStyle(color: Colors.black54)),
                ),
              ),
              body: Container(
                child: Stack(
                  children: [
                    Parent(
                        child: TextFormField(
                          maxLines: 99,
                          keyboardType: TextInputType.multiline,
                          style: TextStyle(color: Colors.black87),
                          decoration: InputDecoration(border: InputBorder.none),
                          initialValue: _.todo.value.content ?? '',
                          toolbarOptions: ToolbarOptions(
                              copy: true,
                              paste: true,
                              selectAll: true,
                              cut: true),
                          onChanged: (value) {
                            _.todo.update((val) {
                              val.content = value;
                            });
                          },
                        ),
                        style: ParentStyle()
                          ..background.color(Colors.white)
                          ..height(Get.height * 0.88)
                          ..borderRadius(all: 10)
                          ..margin(horizontal: 10)
                          ..padding(all: 20)),
                  ],
                ),
              ),
            ),
          );
        }
        return Scaffold(
          body: Container(),
        );
      },
    );
  }
}
