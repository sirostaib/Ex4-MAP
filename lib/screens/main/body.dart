// TODO Complete the file, main/body.dart
//-----------------------------------------------------------------------------------------------------------------------------
//? Things to do:
//   1. Build this screen with 'FutureBuilder' widget.
//      For todo items with the status has been 'done', they should be displayed
//      with the 'line through'. Otherwise, display it with normal text.
//
//   2. Perform the following operations:
//        a. Edit a todo - i.e., when the user tap a todo.
//           This operation will navigate to the '/edit' route.
//        b. Delete a todo - i.e. when the user long-press a todo
//-----------------------------------------------------------------------------------------------------------------------------

import 'package:flutter/material.dart';

import '../../models/todo.dart';
import 'main_screen.dart';

class Body extends StatelessWidget {
  const Body({state}) : _state = state;

  final MainScreenState _state;

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<Todo>>(
        future: _state.todolistfuture,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            _state.todolist = snapshot.data;
            print("slaw: " + _state.todolist.toString());
            return _listbuilder();
          }
          return Container();
        });
  }

  ListView _listbuilder() {
    return ListView.separated(
      //key: UniqueKey(_state),
      itemCount: _state.user == null ? 0 : _state.todolist.length,
      separatorBuilder: (context, index) => Divider(
        color: Colors.blueGrey,
      ),
      itemBuilder: (context, index) => ListTile(
          title: Text(_state.todolist[index].title,
              style: TextStyle(
                  decoration: _state.todolist[index].done
                      ? TextDecoration.lineThrough
                      : null)),
          subtitle: Text(_state.todolist[index].description),
          onTap: () async {
            final Todo todo = await Navigator.of(context).pushNamed('/edit',
                arguments: Todo.copy(_state.todolist[index])) as Todo;
            if (todo != null) {
              _state.updateTodo(index: index, todo: todo);
            }
          },
          onLongPress: () => _state.removeTodo(index)),
    );
  }
}
