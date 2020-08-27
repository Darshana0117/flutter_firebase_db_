import 'package:flutter/material.dart';
import 'package:flutterfirebasedb/auth/auth.controller.dart';
import 'package:flutterfirebasedb/todo/widgets/todo_iteam.dart';
import 'package:get/get.dart';

import '../../app_drawer.dart';
import '../todo.controller.dart';

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  AuthController authController = AuthController.to;
  final GlobalKey<ScaffoldState> scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void dispose() {
    // TODO: implement dispose

    super.dispose();
     // authController.disposeKey("");

  }
  @override
  Widget build(BuildContext context) {
    TodoController c = Get.put<TodoController>(TodoController());
    Future<void> _refreshInfo() async
    {
    Get.offAllNamed(
        "/");
  //    await getData();


    }
    print(authController?.user?.value?.email);
    return Scaffold(
      key: scaffoldKey,
      //  drawer: AppDrawer(),
      appBar: AppBar(
        title: authController.user != null
            ? Text(" ${authController?.user?.value?.email.split("@")[0]}",overflow: TextOverflow.ellipsis,)
            : Container(),
        centerTitle: true,
        leading: IconButton(
            onPressed: () {
              scaffoldKey.currentState.openDrawer();
            },
            icon: Icon(Icons.menu)),
        actions: <Widget>[
          IconButton(
              icon: Icon(Icons.exit_to_app),
              onPressed: () {

                authController.handleSignOut();
              })
        ],
      ),
      body: Obx(() {
        if (c.isLoadingTodos.value) {
          return Container(child: Center(child: CircularProgressIndicator()));
        }

        if (c.todos.length == 0) {
          return Center(child: Text('Nothing to do'));
        }
        return RefreshIndicator(
          onRefresh: _refreshInfo,
          child: ListView.builder(
              itemCount: c.todos.length,
              itemBuilder: (context, index) {
                return TodoItem(c.todos.elementAt(index));
              }),
        );
      }),
      floatingActionButton: FloatingActionButton(
        onPressed: () => Get.toNamed("/add-todo"),
        child: Icon(
          Icons.add,
        ),
      ),
    );
  }
}


