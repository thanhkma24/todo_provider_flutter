import 'package:flutter/cupertino.dart';
import 'package:todolist_finally_provider/main.dart';
import 'package:todolist_finally_provider/todo_model.dart';

class TodoListProvider with ChangeNotifier {
  List<Todo> items = [
    Todo('Item 1'),
    Todo('Item 2'),
    Todo('Item 3'),
    Todo('Item 4'),
  ];
  List<Todo> listSelect = [];

  void editTask(Todo item, String description) {
    if (description != null && description != '') {
      item.description = description;
      notifyListeners();
    }
  }

  void removeItem(Todo item) {
    items.remove(item);
    listSelect.remove(item);
    notifyListeners();
  }

  void addNewTask(String description) {
    if (description != null && description != '') {
      items.add(Todo(description));
      notifyListeners();
    }
  }

  void changeCompleteness(Todo item) {
    item.complete != item.complete;
    notifyListeners();
  }

  void selectItem(Todo todo) {
    if(listSelect.contains(todo)){
      listSelect.remove(todo);
    } else {
      listSelect.add(todo);
    }
    notifyListeners();
  }

  // void unselectItem(Todo item) {
  //   listSelect.remove(item);
  //   notifyListeners();
  // }
}
