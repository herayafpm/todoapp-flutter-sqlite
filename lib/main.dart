import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:ui' as ui;

import 'package:todoapp/translations/my_translation.dart';
import 'package:todoapp/ui/pages/cu_todo_page.dart';
import 'package:todoapp/ui/pages/home_page.dart';

void main() {
  runApp(App());
}

final ThemeData appThemeData = ThemeData(
  primaryColor: Colors.blueAccent,
  accentColor: Colors.blue,
  fontFamily: 'Georgia',
  scaffoldBackgroundColor: Colors.deepPurpleAccent[200],
  textTheme: TextTheme(
    headline1: TextStyle(fontSize: 72.0, fontWeight: FontWeight.bold),
  ),
);

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      translations: MyTranslation(),
      locale: ui.window.locale,
      fallbackLocale: Locale('en', 'US'),
      initialRoute: '/',
      getPages: AppPages.pages,
      title: "Todo App",
      theme: appThemeData,
      defaultTransition: Transition.fade,
    );
  }
}

abstract class AppPages {
  static final pages = [
    GetPage(
      name: '/',
      page: () => HomePage(),
    ),
    GetPage(name: '/todo', page: () => CuTodoPage())
  ];
}
