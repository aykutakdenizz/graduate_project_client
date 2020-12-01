import 'package:business_travel/helpers/location_functions.dart';
import 'package:business_travel/models/task.dart';
import 'package:business_travel/providers/task_provider.dart';
import 'package:flutter/material.dart';

import 'dart:isolate';
import 'dart:ui';

import 'package:background_locator/location_dto.dart';

import 'package:flutter_map/flutter_map.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:latlong/latlong.dart';
import 'package:background_locator/background_locator.dart';
import 'package:provider/provider.dart';

import '../models/location.dart';
import '../services/database.dart';
import '../services/location_service_repository.dart';

class MapScreen extends StatefulWidget {
  static const String routeName = "/map_screen";

  @override
  _MapScreenState createState() => _MapScreenState();
}

class _MapScreenState extends State<MapScreen> {
  MapController _mapController = new MapController();
  FlutterMap _flutterMap;
  MapOptions _mapOptions;
  double _zoomLevel;

  ReceivePort port = ReceivePort();

  bool isRunning;
  Task _selectedTask;

  @override
  void initState() {
    initDatabase();
    _mapOptions = new MapOptions(
      center: new LatLng(
        41.001,
        29.0123,
      ),
      zoom: 11,
      minZoom: 1.0,
      maxZoom: 18.0,
      onPositionChanged: (position, hasGesture) {
        _zoomLevel = position.zoom;
        print("ZOOM LEVEL:" + _zoomLevel.toString());
      },
    );
    _flutterMap = new FlutterMap(
      mapController: _mapController,
      options: _mapOptions,
      layers: [
        new TileLayerOptions(
            urlTemplate: "https://{s}.tile.openstreetmap.org/{z}/{x}/{y}.png",
            subdomains: ['a', 'b', 'c']),
        /*new MarkerLayerOptions(markers: [
          Marker(
            width: 45.0,
            height: 45.0,
            point: LatLng(41.001, 29.0123),
            builder: (ctx) => new Container(
              child: Icon(
                Icons.location_on,
                color: Colors.green,
                size: 45,
              ),
            ),
          ),
        ],),*/
      ],
    );

    if (IsolateNameServer.lookupPortByName(
            LocationServiceRepository.isolateName) !=
        null) {
      IsolateNameServer.removePortNameMapping(
          LocationServiceRepository.isolateName);
    }

    IsolateNameServer.registerPortWithName(
        port.sendPort, LocationServiceRepository.isolateName);

    port.listen(
      (dynamic data) async {
        await updateUI(data);
      },
    );
    initPlatformState();

    Future.delayed(Duration.zero).then((_) {
      final taskProvider = Provider.of<TaskProvider>(context, listen: false);
      _selectedTask = taskProvider.task;
    });
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  Future<void> initDatabase() async {
    await DatabaseConnection.init();
  }

  Future<void> updateUI(LocationDto data) async {
    await _updateNotificationText(data);
  }

  Future<void> _updateNotificationText(LocationDto data) async {
    if (data == null) {
      return;
    }

    await BackgroundLocator.updateNotificationText(
        title: "new location received",
        msg: "${DateTime.now()}",
        bigMsg: "${data.latitude}, ${data.longitude}");
    await DatabaseConnection.writeDb(
        data.latitude, data.longitude, _selectedTask.id);
  }

  Future<void> initPlatformState() async {
    print('Initializing...');
    await BackgroundLocator.initialize();

    print('Initialization done');
    final _isRunning = await BackgroundLocator.isServiceRunning();
    setState(() {
      isRunning = _isRunning;
    });
    print('Running ${isRunning.toString()}');
  }

  Future<List<LatLng>> getLocationList(int taskId) async {
    List<DbLocation> list = await DatabaseConnection.getLocationWithId(taskId);
    List<LatLng> latlngList = List();

    for (int i = 0; i < list.length; i++) {
      latlngList.add(new LatLng(list[i].latitude, list[i].longitude));
    }
    return latlngList;
  }

  void _drawLocations(List<LatLng> list) {
    _flutterMap.layers.add(
      new PolylineLayerOptions(
        polylines: [
          new Polyline(
            points: list,
            color: Colors.black,
            borderColor: Colors.black,
            strokeWidth: 4,
          ),
        ],
      ),
    );
    _flutterMap.layers.add(
      new MarkerLayerOptions(
        markers: list
            .map(
              (location) => Marker(
                width: 35.0,
                height: 35.0,
                point: LatLng(location.latitude, location.longitude),
                builder: (ctx) => GestureDetector(
                  child: new Container(
                    child: Icon(
                      Icons.location_on,
                      color: Colors.blue,
                      size: 35,
                    ),
                  ),
                  onLongPress: () {
                    _markerOnLongPress(location);
                  },
                ),
              ),
            )
            .toList(),
      ),
    );
  }

  void showColoredToast(String text) {
    Fluttertoast.showToast(
        msg: text,
        toastLength: Toast.LENGTH_SHORT,
        backgroundColor: Colors.green,
        textColor: Colors.white);
  }

  void _markerOnLongPress(LatLng location) {
    showDialog(
      context: context,
      builder: (_) => SimpleDialog(
        title: Text(
            '${location.latitude},${location.longitude} noktasını başlangıç veya bitiş noktası olarak seçiniz.'),
        children: <Widget>[
          SimpleDialogOption(
            onPressed: () {
              final taskProvider =
                  Provider.of<TaskProvider>(context, listen: false);
              taskProvider.startLatitude = location.latitude;
              taskProvider.startLongitude = location.longitude;
              Navigator.pop(context);
              showColoredToast(
                  "Geçerli konum, başlangıç noktası olarak eklendi.");
            },
            child: const Text('Başlagıç noktası'),
          ),
          SimpleDialogOption(
            onPressed: () {
              final taskProvider =
                  Provider.of<TaskProvider>(context, listen: false);
              taskProvider.finishLatitude = location.latitude;
              taskProvider.finishLongitude = location.longitude;
              Navigator.pop(context);
              showColoredToast("Geçerli konum, bitiş noktası olarak eklendi.");
            },
            child: const Text('Bitiş noktası'),
          ),
          SimpleDialogOption(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text('Vazgeç'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Location'),
      ),
      body: _flutterMap,
      bottomNavigationBar: BottomAppBar(
        child: Container(
          height: 50,
          child: Row(
            mainAxisSize: MainAxisSize.max,
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
              IconButton(
                icon: Icon(Icons.location_on),
                tooltip: 'Start location service',
                onPressed: () async {
                  if (await LocationFunctions.checkLocationPermission()) {
                    LocationFunctions.startLocator();
                    showColoredToast("Start");
                    final _isRunning =
                        await BackgroundLocator.isServiceRunning();

                    setState(() {
                      isRunning = _isRunning;
                    });
                  } else {
                    // show error
                  }
                },
              ),
              IconButton(
                  icon: Icon(Icons.location_off),
                  tooltip: 'Stop location service',
                  onPressed: () {
                    LocationFunctions.stopLocator();
                    showColoredToast("Stop");
                  }),
              IconButton(
                icon: Icon(Icons.details),
                tooltip: 'Draw locations',
                onPressed: () async {
                  List<LatLng> list = await getLocationList(_selectedTask.id);
                  _drawLocations(list);
                  showColoredToast("Draw Completed");
                  print("Draw Completed");
                },
                color: Colors.blue[900],
              ),
              IconButton(
                icon: Icon(Icons.format_list_numbered),
                tooltip: 'Lenght',
                onPressed: () async {
                  int lenght =
                      await DatabaseConnection.listSize(_selectedTask.id);
                  showColoredToast("Lenght:$lenght");
                },
                color: Colors.purple,
              ),
              IconButton(
                icon: Icon(Icons.delete),
                tooltip: 'Draw locations',
                onPressed: DatabaseConnection.deleteAllData,
                color: Colors.red,
              ),
            ],
          ),
        ),
        color: Theme.of(context).primaryColor,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () async {
          //_mapController.move(_mapController.center, _mapController.zoom + 1);
          if (_flutterMap.layers.length > 1) {
            _flutterMap.layers.removeLast();
            showColoredToast("Removed");
          } else {
            showColoredToast("Not removed(there is only map layer)");
          }
        },
        child: Icon(Icons.remove),
        backgroundColor: Colors.redAccent,
      ),
    );
  }
}
