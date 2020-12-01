import 'package:business_travel/models/task.dart';
import 'package:flutter/material.dart';

class TaskProvider with ChangeNotifier {
  Task _selectedTask;

  Task get task {
    return _selectedTask;
  }

  double get startLatitude => _selectedTask.startLatitude;
  double get startLongitude => _selectedTask.startLongitude;
  double get finishLatitude => _selectedTask.finishLatitude;
  double get finishLongitude => _selectedTask.finishLongitude;

  void copyValues(Task selectedTask) => this._selectedTask = selectedTask;
  set startLatitude(double startLatitude) =>
      this._selectedTask.startLatitude = startLatitude;
  set startLongitude(double startLongitude) =>
      this._selectedTask.startLongitude = startLongitude;
  set finishLatitude(double finishLatitude) =>
      this._selectedTask.finishLatitude = finishLatitude;
  set finishLongitude(double finishLongitude) {
    this._selectedTask.finishLongitude = finishLongitude;
    print("------\nSTART:\n${_selectedTask.startLatitude},${_selectedTask.startLongitude}\n" +
        "FINISH\n${_selectedTask.finishLatitude},${_selectedTask.finishLongitude}\n------");
  }
}
