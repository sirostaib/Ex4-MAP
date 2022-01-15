// TODO Complete the model class Todo.
//-----------------------------------------------------------------------------------------------------------------------------
//? Things to do:
// Define the following methods:
//   a. all the getters and setters
//   b. the 'copy' constructor
//   c. the 'fromJson' constructor
//   d. the 'toJson' method
//-----------------------------------------------------------------------------------------------------------------------------

// Done

class Todo {
  String _title;
  String _description;
  bool _done;
  int _id;
  int _user;

  String get title {
    return _title;
  }

  void set title(String value) {
    title = value;
  }

  String get description {
    return _description;
  }

  void set description(String value) {
    _description = value;
  }

  bool get done {
    return _done;
  }

  void set done(bool value) {
    _done = value;
  }

  int get id {
    return _id;
  }

  void set id(int value) {
    _id = value;
  }

  int get user {
    return _user;
  }

  void set user(int value) {
    _user = value;
  }

  Todo(
      {String title = '',
      String description = '',
      bool done = false,
      int id,
      int user})
      : _title = title,
        _description = description,
        _done = done,
        _id = id,
        _user = user;

  Todo.copy(Todo from)
      : this(
            title: from.title,
            description: from.description,
            done: from.done,
            id: from.id,
            user: from.user);

  Todo.fromJson(Map<String, dynamic> map)
      : this(
            title: map['title'],
            description: map['description'],
            done: map['done'],
            id: map['id'],
            user: map['user']);

  Map<String, dynamic> toJson() => {
        'title': title,
        'description': description,
        'done': done,
        'id': id,
        'user': user,
      };
}
