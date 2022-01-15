// TODO Complete the file main_screen.dart
//-----------------------------------------------------------------------------------------------------------------------------
//? Things to do:
//
//   1. Declare all the states required for this screen. To be done in this file.
//      You may also want to define getters and setters for the states.
//      The states should include:
//        a. the 'logged in user'                    done...
//        b. the 'list of todos'                     done...
//        c. a 'Future' data for the todo list
//
//   2. Define several methods in the 'MainScreenState' class
//      to synchronize changes on UI and data update on REST server:
//        a. to get all the list of todos for the current user
//        b. addTodo(): to add a new todo
//        c. updateTodo(): to edit a todo
//        d. deleteTodo(): to delete a todo
//
//   3. Build this screen with conditional UI technique (based on
//      whether the user has logged in or not).
//      This includes:
//        a. The app bar shows 'unknown user' or 'logged user'
//           This part is to be done in 'bar.dart'
//
//        b. The body shows nothing if the user hasn't logged in. Otherwise,
//           it shows the list of todo items for the logged in user.
//           This part is to be done here in this file.
//
//        c. The floatingActionButton shows nothing if the user hasn't logged in.
//           Otherwise, it shows the 'Plus' and 'Refresh' buttons
//           This part is to be done here in this file.
//
//   3. Build the UI by composing from its components, i.e., Bar, Body and Float.
//      Besides, you will also need to pass the 'states' to the components.
//-----------------------------------------------------------------------------------------------------------------------------

import 'package:flutter/material.dart';

import '../../models/user.dart';
import '../../models/todo.dart';
import '../../services/todo_service.dart';

import 'bar.dart';
import 'body.dart';
import 'float.dart';

class MainScreen extends StatefulWidget {
  static Route route() => MaterialPageRoute(builder: (context) => MainScreen());

  @override
  MainScreenState createState() => MainScreenState();
}

class MainScreenState extends State<MainScreen> {
  User _user;

  User get user => this._user;
  set user(User user) => setState(() {
        _user = user;
      });

  List<Todo> _todo;
  Future<List<Todo>> _todoFuture;

  List<Todo> get todolist => this._todo;
  set todolist(List<Todo> todo) => this._todo = todo;

  Future<List<Todo>> get todolistfuture => this._todoFuture;
  set todolistfuture(Future<List<Todo>> value) => this._todoFuture = value;

  void refreshME() {
    if (_user == null) {
      setState(() {
        _todoFuture = null;
        _todo = null;
      });
    } else {
      setState(() {
        _todoFuture = TodoService.getTodoListByUser(user.id);
        //_todo = _todoFuture as List<Todo>;
      });
    }
  }

  void addTodo(Todo todo) async {
    todo.user = _user.id;
    final newTodo = await TodoService.addTodo(todo);
    todolist.add(newTodo);
    setState(() {});
  }

  void updateTodo({int index, Todo todo}) async {
    todo.user = _user.id;
    final updatedTodo = await TodoService.updateTodo(todo);
    todolist[index] = updatedTodo;
    setState(() {});
  }

  void removeTodo(int index) async {
    await TodoService.removeTodo(todolist[index]);
    todolist.removeAt(index);
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    // _user == null ? null : updateTTodo();
    return WillPopScope(
      onWillPop: () => Future.value(false),
      child: SafeArea(
        child: Scaffold(
          appBar: Bar(
            state: this,
          ),
          body: user != null
              ? Body(
                  state: this,
                )
              : Container(),
          floatingActionButton: user != null
              ? Float(
                  state: this,
                )
              : Container(),
        ),
      ),
    );
  }

  // Future<void> updateTTodo() async {
  //   _todo = await TodoService.getTodoListByUser(_user.id);
  //   setState(() {});
  // }
}
