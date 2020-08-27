import 'package:flutter/material.dart';
import 'package:flutterfirebasedb/todo/models/todo.model.dart';
import 'package:flutterfirebasedb/todo/views/todo_list.view.dart';
import 'package:get/get.dart';


import '../todo.controller.dart';

class AddTodo extends StatefulWidget {
  AddTodo({Key key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController titleController = new TextEditingController();
  Todo todo;

  @override
  void initState() {

    if (Get.parameters != null) {
      var id = Get.parameters["id"];
      if (id != null) {
        TodoController.to.loadDetails(id).then((value) => setState(() {
          todo = value;
          titleController.text = value.title;
        }));
      }
    }
    super.initState();
  }
  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
   // titleController.clear();
  //  Get.parameters.clear();
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Add Todo"),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
        child: Column(
          children: <Widget>[
            TextFormField(
              controller: titleController,
              decoration: InputDecoration(
                hintText: "Add title",
                border: OutlineInputBorder(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: GestureDetector(
                onTap: () {
                  if (titleController.text != "") {
                    if (todo != null) {
                      todo.title = titleController.text;
                      TodoController.to.updateTodo(todo);
                      titleController.clear();
                      Get.offAllNamed("/");
                    } else {
                      TodoController.to.addTodo(titleController.text);
                      titleController.clear();
                          Get.offAllNamed("/");
                    /*  Navigator.of(context)
                          .push(MaterialPageRoute(builder: (context) => TodoList()));*/
                     // Navigator.pop(context);
                    }
                  }
                },
                child: Container(
                  width: MediaQuery.of(context).size.width * .6,
                  height: 50,
                  child: Center(
                    child: Text(
                      "Save",
                      style: TextStyle(
                        color: Colors.white,
                        fontSize: 17,
                      ),
                    ),
                  ),
                  color: Colors.blue,
                ),
              ),
            ),
            Obx(
                  () => TodoController.to.isAddingTodo.value
                  ? Container(
                child: Center(
                    child: CircularProgressIndicator(
                      backgroundColor: Colors.green,
                    )),
              )
                  : Container(),
            )
          ],
        ),
      ),
    );
  }
}