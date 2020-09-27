import 'package:division/division.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:todoapp/bloc/todo/todobloc_bloc.dart';
import 'package:todoapp/models/todo_model.dart';
import 'package:todoapp/styles/my_styles.dart';

class HomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Txt(
            'Todo App',
            style: MyStyles.txtStyle.clone()
              ..fontSize(20)
              ..fontWeight(FontWeight.bold),
          ),
          elevation: 0,
          backgroundColor: Colors.transparent,
        ),
        body: Stack(
          children: [
            Container(
              height: Get.height * 0.7,
              width: Get.width,
              child: Align(
                alignment: Alignment.center,
                child: Txt(
                  "hello_world".tr,
                  style: MyStyles.txtStyle
                    ..clone()
                    ..fontSize(30),
                ),
              ),
            ),
            BlocProvider<TodoBlocBloc>(
              create: (context) => TodoBlocBloc()..add(TodoBlocGetList()),
              child: ListTodoView(),
            )
          ],
        ));
  }
}

class ListTodoController extends GetxController {
  final _obj = ''.obs;
  set obj(value) => this._obj.value = value;
  get obj => this._obj.value;
}

class ListTodoView extends GetView<ListTodoController> {
  TodoBlocBloc todoBlocBloc;

  @override
  Widget build(BuildContext context) {
    todoBlocBloc = BlocProvider.of<TodoBlocBloc>(context);
    return BlocBuilder<TodoBlocBloc, TodoBlocState>(
      builder: (context, state) {
        if (state is TodoBlocListLoaded) {
          TodoBlocListLoaded todoBlocListLoaded = state;
          return SizedBox.expand(
            child: DraggableScrollableSheet(
                maxChildSize: 0.85,
                builder:
                    (BuildContext context, ScrollController scrollController) {
                  return Parent(
                    style: ParentStyle()
                      ..borderRadius(topLeft: 20, topRight: 20)
                      ..background.color(Colors.white),
                    child: Stack(
                      overflow: Overflow.visible,
                      children: [
                        Container(
                            child: ListView.builder(
                                controller: scrollController,
                                itemCount: todoBlocListLoaded.listTodo.length,
                                itemBuilder: (BuildContext context, int index) {
                                  return ItemListTodo(
                                      todoBlocListLoaded.listTodo[index]);
                                })),
                        Positioned(
                          top: -30,
                          right: 10,
                          child: FloatingActionButton(
                            onPressed: () =>
                                Get.toNamed('/todo', arguments: {'id': 0}),
                            child: Icon(Icons.add),
                          ),
                        ),
                      ],
                    ),
                  );
                }),
          );
        }
        return EmptyListTodo();
      },
    );
  }
}

class ItemListTodo extends StatelessWidget {
  final TodoModel todoModel;

  const ItemListTodo(this.todoModel);
  @override
  Widget build(BuildContext context) {
    return Parent(
      child: ListTile(
        isThreeLine: true,
        title: Txt("${todoModel.title}"),
        subtitle: Txt("${todoModel.updated}"),
      ),
      gesture: Gestures()
        ..onTap(() => Get.toNamed('/todo', arguments: {'id': todoModel.id})),
    );
  }
}

class EmptyListTodo extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SizedBox.expand(
      child: DraggableScrollableSheet(
          builder: (BuildContext context, ScrollController scrollController) {
        return Parent(
          gesture: Gestures()
            ..onTap(() => Get.toNamed('/todo', arguments: {'id': 0})),
          style: ParentStyle()
            ..borderRadius(topLeft: 20, topRight: 20)
            ..background.color(Colors.white),
          child: Container(
              child: Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  Icons.add_box_rounded,
                  color: Colors.blueAccent[300],
                  size: 70,
                ),
                Txt(
                  "empty_data".tr,
                  style: MyStyles.txtStyle.clone()
                    ..fontSize(20)
                    ..textColor(Colors.black54),
                ),
              ],
            ),
          )),
        );
      }),
    );
  }
}
