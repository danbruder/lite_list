import 'package:flutter/material.dart';

void main() {
  runApp(App());
}

class Todo {
  int id;
  String title = "";
  bool checked = false;
  Todo({this.id, this.title, this.checked});
}

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(home: TodoList());
  }
}

class TodoList extends StatefulWidget {
  @override
  _TodoListState createState() => _TodoListState();
}

class _TodoListState extends State<TodoList> {
  // save data
  final List<Todo> _todoList = <Todo>[];
  int _maxId = 0;

  // text field
  final TextEditingController _textFieldController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('To-Do List')),
      body: ListView(children: _getItems()),
      // add items to the to-do list
      floatingActionButton: FloatingActionButton(
          onPressed: () => _displayDialog(context),
          tooltip: 'Add Item',
          child: Icon(Icons.add)),
    );
  }

  void _addTodoItem(String title) {
    // Wrapping it inside a set state will notify
    // the app that the state has changed
    final newItem = Todo(id: _maxId + 1, title: title, checked: false);
    setState(() {
      _todoList.add(newItem);
      _maxId = _maxId + 1;
    });
    _textFieldController.clear();
  }

  // this Generate list of item widgets
  Widget _buildTodoItem(Todo item) {
    return CheckboxListTile(
      title: Text(item.title),
      value: item.checked,
      onChanged: (value) {
        setState(() {
          final todo = _todoList[
              _todoList.indexWhere((element) => element.id == item.id)];
          todo.checked = value;
        });
      },
    );
  }

  // display a dialog for the user to enter items
  Future<AlertDialog> _displayDialog(BuildContext context) async {
    // alter the app state to show a dialog
    return showDialog(
        context: context,
        builder: (BuildContext context) {
          return AlertDialog(
            title: const Text('Add a ADELYNN to your list'),
            content: TextField(
              controller: _textFieldController,
              decoration: const InputDecoration(hintText: 'Enter task here'),
            ),
            actions: <Widget>[
              // Cancel button
              FlatButton(
                child: const Text('CANCEL'),
                onPressed: () {
                  Navigator.of(context).pop();
                },
              ),
              // add button
              FlatButton(
                child: const Text('ADD'),
                onPressed: () {
                  Navigator.of(context).pop();
                  _addTodoItem(_textFieldController.text);
                },
              ),
            ],
          );
        });
  }

  // iterates through our todo list title
  List<Widget> _getItems() {
    final List<Widget> _todoWidgets = <Widget>[];
    for (Todo item in _todoList) {
      _todoWidgets.add(_buildTodoItem(item));
    }
    return _todoWidgets;
  }
}
