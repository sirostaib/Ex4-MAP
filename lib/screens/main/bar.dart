// TODO Complete the file, main/bar.dart
//-----------------------------------------------------------------------------------------------------------------------------
//? Things to do:
//   1. Build this screen with conditional UI technique (based on
//      whether the user has logged in or not).
//      This includes:
//        a. The app bar shows 'unknown user' logo and the 'Login' button if
//           the user has not logged in yet.
//
//        b. Otherwise (if the user has logged in), the app bar shows the user
//           photo and name, as well as the 'Logout' button.
//
//   2. Perform the following operations:
//        a. Login  - This operation will navigate to the '/login' route.
//        b. Logout - This will reset the 'user' state to 'null'.
//-----------------------------------------------------------------------------------------------------------------------------

import 'package:exercise3/models/user.dart';
import 'package:flutter/material.dart';

import 'main_screen.dart';

class Bar extends StatelessWidget implements PreferredSizeWidget {
  @override
  Size get preferredSize => Size.fromHeight(60.0);

  final MainScreenState _state;
  const Bar({state}) : _state = state;

  @override
  Widget build(BuildContext context) {
    return AppBar(
      leading: _state.user == null
          ? CircleAvatar(backgroundImage: AssetImage('assets/unknown_user.png'))
          : CircleAvatar(backgroundImage: NetworkImage(_state.user.photoUrl)),
      title: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('My Todo List'),
          _state.user == null
              ? Text('User name goes here', style: TextStyle(fontSize: 12.0))
              : Text(_state.user.name, style: TextStyle(fontSize: 12.0)),
        ],
      ),
      actions: [
        IconButton(
          icon: _state.user == null ? Icon(Icons.login) : Icon(Icons.logout),
          onPressed: _state.user == null
              ? () async {
                  final user = await Navigator.pushNamed(context, '/login');
                  _state.user = user;
                  _state.refreshME();
                }
              : () async {
                  _state.user = null;
                  _state.todolist = null;
                  final user = await Navigator.pushNamed(context, '/login');
                  _state.refreshME();
                  _state.user = user;
                },
        )
      ],
    );
  }
}
