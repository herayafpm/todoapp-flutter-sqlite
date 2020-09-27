import 'dart:ui' as ui;

import 'package:jiffy/jiffy.dart';
import 'package:get/get.dart';

class TodoModel {
  int id;
  String title;
  String content;
  String created;
  String updated;

  TodoModel({this.id, this.title, this.content, this.created, this.updated});

  static Future<TodoModel> create(Map<String, dynamic> json) async {
    return TodoModel(
        id: json['id'],
        title: json['title'],
        content: json['content'],
        created: await toDate(json['created']),
        updated: await toDate(json['updated']));
  }

  static Future<TodoModel> dummyTodo() async {
    return TodoModel(
        id: 0,
        title: 'empty_title'.tr,
        content: '',
        created: await toDate(DateTime.now().millisecondsSinceEpoch),
        updated: await toDate(DateTime.now().millisecondsSinceEpoch));
  }

  static Future<List<TodoModel>> createList(
      List<Map<String, dynamic>> listData) async {
    List<TodoModel> todos = [];
    for (var list in listData) {
      TodoModel todoModel = await TodoModel.create(list);
      todos.add(todoModel);
    }
    return todos;
  }

  static Future<String> toDate(int date) async {
    await Jiffy.locale(ui.window.locale.countryCode);
    return Jiffy(DateTime.fromMillisecondsSinceEpoch(date)).fromNow();
  }

  Map<String, dynamic> toJson({bool updated = false}) {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    // if (this.id == 0) {
    //   data['id'] = this.id;
    // }
    data['title'] = this.title;
    data['content'] = this.content;
    if (updated) {
      data['updated'] = DateTime.now().millisecondsSinceEpoch;
    } else {
      data['created'] = DateTime.now().millisecondsSinceEpoch;
      data['updated'] = DateTime.now().millisecondsSinceEpoch;
    }
    return data;
  }
}
