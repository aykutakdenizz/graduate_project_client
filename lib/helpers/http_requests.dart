import 'package:business_travel/models/location.dart';
import 'package:business_travel/services/database.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:latlong/latlong.dart';

class HttpRequests {
  static String _serverAddress;

  static String get serverAddress {
    String address = _serverAddress;
    return address;
  }

  static Future<void> checkAndSendLocation(LatLng location) async {

    int numberOfFailedRequest = await DatabaseConnection.listSize(1);

    if (numberOfFailedRequest != 0) {//Onceki verileri kontrol edip eger vrsa yollayıp vtden siliyorum
      List<DbLocation> list = await DatabaseConnection.getLocationWithId(1);
      for (int i = 0; i < list.length; i++) {
        bool isSuccess =
            await sendLocation(LatLng(list[i].latitude, list[i].longitude));
        if (isSuccess) {
          DatabaseConnection.deleteData(list[i].id);
        }
      }
    }
    bool isSuccess = await sendLocation(location);
    if (!isSuccess) {
      DatabaseConnection.writeDb(
        location.latitude,
        location.longitude,
        1,
      );
    }
  }

  static Future<bool> sendLocation(LatLng location) async {
    String apiURL = '/api';
    var body = {"latitude": location.latitude, "longitude": location.longitude};
    var response;
    try {
      response = await http.post(
        serverAddress + apiURL,
        body: body,
      );
      if (response.statusCode >= 400) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print("Error occurred in http_request sendLocation!\nError:" +
          e.toString());
      return false;
    }
  }

  static Future<bool> sendImage(String base64Image) async {
    String apiURL = '/api';
    var body = {"image": base64Image};
    var response;

    try {
      response = await http.post(
        serverAddress + apiURL,
        body: body,
      );
      if (response.statusCode >= 400) {
        return false;
      } else {
        return true;
      }
    } catch (e) {
      print("Error occurred in http_request sendImage!\nError:" + e.toString());
      return false;
    }
  }
}
