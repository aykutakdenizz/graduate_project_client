import 'package:business_travel/helpers/location_functions.dart';
import 'package:flutter/material.dart';

class LocationProvider with ChangeNotifier {
  bool _isAllowedBackgroundTracking = false;

  bool get isAllowedBackgroundTracking {
    bool copyIsAllowedBackgroundTracking = _isAllowedBackgroundTracking;
    return copyIsAllowedBackgroundTracking;
  }

  void allowBackgroundTracking() async {
    _isAllowedBackgroundTracking = true;
    if (await LocationFunctions.checkLocationPermission()) {
      LocationFunctions.startLocator();
      print("yes");
    } else {
      print(
          "---> In Location Provider allowBackgroundTracking => Occurred Error !!");
    }
    LocationFunctions.startLocator();
    notifyListeners();
  }

  void deniedBackgroundTracking() {
    _isAllowedBackgroundTracking = false;
    LocationFunctions.stopLocator();
    notifyListeners();
  }

  void toogleBackgroundTracking() {
    if (isAllowedBackgroundTracking) {
      deniedBackgroundTracking();
    } else {
      allowBackgroundTracking();
    }
    notifyListeners();
  }
}
