import 'package:flutter/material.dart';

import '../models/task.dart';

class TasksProvider with ChangeNotifier {
  List<Task> _allTaskList = [];

  List<Task> get allList {
    fetchAllTasks();
    return [..._allTaskList];
  }
  Task getTask(int index){
    return _allTaskList[index];
  }

  void fetchAllTasks() {
    _allTaskList = [
      Task(
        id: 1,
        name: 'Gorev 1',
        description: 'Aciklama 1',
        price: 12.34,
      ),
      Task(
        id: 2,
        name: 'Gorev 2',
        description: 'Aciklama 2',
        price: 1484.43456456,
      ),
    ];
  }
}
