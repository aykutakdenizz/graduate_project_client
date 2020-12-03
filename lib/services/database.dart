import 'package:business_travel/models/location.dart';
import 'package:intl/intl.dart';
import 'package:sqflite/sqflite.dart';

class DatabaseConnection {
  static Database database;

  static Future<void> init() async {
    database = await openDatabase('my_db.db');
    await database.execute(
        'CREATE TABLE IF NOT EXISTS Locations (id INTEGER PRIMARY KEY, latitude REAL, longitude REAL, date TEXT, task_id INTEGER)');
  }

  static Future<void> writeDb(
      double latitude, double longitude, int taskId) async {
    try {
      var dateString = DateFormat.Hms().format(DateTime.now());

      await database.transaction((txn) async {
        int id1 = await txn.rawInsert(
            'INSERT INTO Locations(latitude, longitude, date, task_id) VALUES($latitude, $longitude, "$dateString", $taskId)');
        print('inserted: $id1');
      });
    } on Exception catch (error) {
      print("In database.dart writeDB function: " + error.toString());
    }
  }

  static Future<void> deleteAllData() async {
    try {
      await database.rawDelete('DELETE FROM Locations');
      print("Deleted all rows");
    } on Exception catch (error) {
      print("In database.dart deleteAllData function: " + error.toString());
    }
  }

  static Future<void> deleteData(int id) async {
    try {
      await database.rawDelete('DELETE FROM Locations WHERE id=$id');
    } on Exception catch (error) {
      print("In database.dart deleteData function: " + error.toString());
    }
  }

  static Future<List<DbLocation>> getLocations() async {
    List<DbLocation> locationList = new List();
    List<Map> dblist = await database.rawQuery('SELECT * FROM Locations');
    for (int i = 0; i < dblist.length; i++) {
      locationList.add(DbLocation.fromJson(dblist.elementAt(i)));
    }
    return locationList;
  }

  static Future<List<DbLocation>> getLocationWithId(int taskId) async {
    List<DbLocation> locationList = new List();
    List<Map> dblist = await database
        .rawQuery('SELECT * FROM Locations WHERE task_id = $taskId');
    for (int i = 0; i < dblist.length; i++) {
      locationList.add(DbLocation.fromJson(dblist.elementAt(i)));
    }
    return locationList;
  }

  static Future<int> listSize(int taskId) async {
    List<Map> dblist = await database
        .rawQuery('SELECT * FROM Locations WHERE task_id = $taskId');
    return dblist.length;
  }
}
