// TODO Complete the file, login/body.dart
//-----------------------------------------------------------------------------------------------------------------------------
//? Things to do:
//   1. Build this screen with conditional UI technique.
//      This includes:
//        a. Show or hide the entered password (by tapping on the 'eye' icon)
//        b. Show the error message if the user entered wrong username
//           or password.
//
//   2. Update the states and reflect the changes on the UI:
//        a. when the user types in the 'Username'.
//        b. when the user types in the 'Password'.
//        c. when the user taps on the 'eye' icon (to show/hide the password).
//
//   3. Perform the following operations:
//        a. Proceed to Login - i.e. when the 'Log in' button is tapped on.
//        b. Cancel the login - i.e. when the 'Cancel' button is tapped on.
//-----------------------------------------------------------------------------------------------------------------------------

import 'dart:developer';

import 'package:flutter/material.dart';

import '../../services/user_service.dart';
import '../../models/user.dart';
import 'login_screen.dart';

class Body extends StatelessWidget {
  const Body({state}) : _state = state;
  final LoginScreenState _state;

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        TextField(
          decoration: InputDecoration(
            hintText: 'Username',
            prefixIcon: Icon(Icons.people),
          ),
          onChanged: (text) {
            _state.username = text;
          },
        ),
        TextField(
          decoration: InputDecoration(
            hintText: "Password",
            prefixIcon: Icons.lock != null ? Icon(Icons.lock) : null,
            suffixIcon: IconButton(
                icon: Icon(Icons.visibility),
                onPressed: () {
                  _state.togglepassword = !_state.togglepassword;
                }),
          ),
          obscureText: _state.togglepassword,
          onChanged: (text) {
            _state.password = text;
          },
        ),
        _state.invlid
            ? Text(
                'Invalid username or password!',
                style: TextStyle(color: Colors.red, fontSize: 20.0),
              )
            : Text(" "),
        SizedBox(height: 10.0),
        _buildButtons(context)
      ],
    );
  }

  Row _buildButtons(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        ElevatedButton(
          child: Text('Log in'),
          onPressed: () {
            print("Username: " + _state.username);
            print("Password: " + _state.password);
            login(context);
            //AlertDialog()
          },
        ),
        SizedBox(width: 10.0),
        ElevatedButton(
          child: Text('Cancel'),
          onPressed: () {
            Navigator.pop(context, null);
          },
        ),
      ],
    );
  }

  void login(context) async {
    final User user = await UserService.getUserByLoginAndPassword(
        login: _state.username, password: _state.password);

    if (user == null) {
      _state.invlid = true;
      print("invalid login");
    } else {
      _state.invlid = false;
      inspect(user);
      Navigator.of(context).pop(user);
    }
  }
}
