import 'package:flutterfirebasedb/splashscreen.dart';
import 'package:flutterfirebasedb/todo/views/add_todo.view.dart';
import 'package:flutterfirebasedb/todo/views/edit_todo.view.dart';
import 'package:flutterfirebasedb/todo/views/todo_list.view.dart';
import 'package:get/get.dart';

import 'auth/views/login.dart';
import 'auth/views/register.dart';


class AppRoutes {
  static final routes = [
    GetPage(
      name: '/splashscreen',
      page: () => SplashScreen(),
    ),
    GetPage(
      name: '/',
      page: () => TodoList(), //(uncomment here to swith to todo app)TodoList(),
    ),
    GetPage(
      name: '/login',
      page: () => LoginPage(),
    ),
    GetPage(
      name: '/register',
      page: () => RegisterPage(),
    ),
    GetPage(
      name: '/todos',
      page: () => TodoList(),
    ),
    GetPage(
      name: '/todos/:id/edit',
      page: () => EditTodo(),
    ),
    GetPage(
      name: '/add-todo',
      page: () => AddTodo(),
    ),

  ];
}