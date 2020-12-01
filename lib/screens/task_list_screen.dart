import 'package:business_travel/providers/location_provider.dart';
import 'package:business_travel/providers/task_provider.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

import '../providers/tasks_provider.dart';
import '../screens/map_screen.dart';
import '../screens/setting_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:provider/provider.dart';

class TaskListScreen extends StatefulWidget {
  static String routeName = "/task_list";
  @override
  _TaskListScreenState createState() => _TaskListScreenState();
}

class _TaskListScreenState extends State<TaskListScreen> {
  int _bottomNavigationBarIndex;

  @override
  void initState() {
    super.initState();
    _bottomNavigationBarIndex = 0;
  }

  void bottomNavigationBarOnTap(int index) {
    setState(() {
      _bottomNavigationBarIndex = index;
    });
    switch (index) {
      case 0:
        break;
      case 1:
        break;
      case 2:
        break;
      case 3:
        break;
      default:
    }
  }

  Widget listItem({
    String name,
    String description,
    price,
    Widget action,
  }) {
    return Container(
      padding: EdgeInsets.only(left: 12, right: 12, top: 5),
      width: MediaQuery.of(context).size.width,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(name),
          Text(description),
          Text(price.runtimeType == String ? price : price.toStringAsFixed(2)),
          action,
        ],
      ),
    );
  }

  Widget drawerWidget(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
            ),
            child: Text(
              'Control Panel',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
              ),
            ),
          ),
          Consumer<LocationProvider>(
            builder: (context, locationProvider, child) {
              return ListTile(
                leading: Icon(Icons.location_on),
                title: Text(locationProvider.isAllowedBackgroundTracking
                    ? 'Stop Track Location'
                    : 'Start Track Location'),
                selectedTileColor: Theme.of(context).primaryColor.withAlpha(50),
                onTap: () {
                  locationProvider.toogleBackgroundTracking();
                },
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text('Profile'),
            selectedTileColor: Theme.of(context).primaryColor.withAlpha(50),
            onTap: () {},
          ),
        ],
      ),
    );
  }

  Widget bottomNavigationBar() {
    return Theme(
      data: Theme.of(context).copyWith(
        canvasColor: Theme.of(context).primaryColor,
      ),
      child: BottomNavigationBar(
        currentIndex: _bottomNavigationBarIndex,
        onTap: bottomNavigationBarOnTap,
        type: BottomNavigationBarType.fixed,
        fixedColor: Theme.of(context).focusColor,
        items: <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.list_alt_outlined),
            label: 'All',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_taxi),
            label: 'Tranportation',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.local_restaurant),
            label: 'Food',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment_rounded),
            label: 'Other',
          ),
        ],
      ),
    );
  }

  Widget providers(Widget scaffold) {
    return ChangeNotifierProvider<TasksProvider>(
      create: (context) => TasksProvider(),
      child: ChangeNotifierProvider<LocationProvider>(
        create: (context) => LocationProvider(),
        child: Builder(
          builder: (context) {
            return scaffold;
          },
        ),
      ),
    );
  }

  Future<void> _refreshIndicator(BuildContext context) async {
    return;
  }

  @override
  Widget build(BuildContext context) {
    final tasksProvider = Provider.of<TasksProvider>(context);
    final taskProvider = Provider.of<TaskProvider>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text('Tasks'),
        actions: [
          IconButton(
              icon: Icon(Icons.settings),
              onPressed: () =>
                  Navigator.pushNamed(context, SettingScreen.routeName)),
        ],
      ),
      drawer: drawerWidget(context),
      bottomNavigationBar: bottomNavigationBar(),
      body: RefreshIndicator(
        onRefresh: () => _refreshIndicator(context),
        child: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: ListView.builder(
            itemCount: tasksProvider.allList.length,
            itemBuilder: (BuildContext context, int index) => Slidable(
              actionPane: SlidableDrawerActionPane(),
              actionExtentRatio: 0.25,
              child: GestureDetector(
                onTap: () {
                  taskProvider.copyValues(tasksProvider.getTask(index));
                  Navigator.pushNamed(context, MapScreen.routeName);
                },
                child: Container(
                  color: Colors.white,
                  child: listItem(
                    name: tasksProvider.allList[index].name,
                    description: tasksProvider.allList[index].description,
                    price: tasksProvider.allList[index].price,
                    action: RaisedButton(
                      child: Text('Start'),
                      onPressed: () {
                        taskProvider.copyValues(tasksProvider.getTask(index));
                        Navigator.pushNamed(context, MapScreen.routeName);
                      },
                    ),
                  ),
                ),
              ),
              actions: <Widget>[
                IconSlideAction(
                  caption: 'Görevi Başlat',
                  color: Colors.blue,
                  icon: Icons.assignment_turned_in_outlined,
                  onTap: null,
                ),
              ],
              secondaryActions: <Widget>[
                IconSlideAction(
                  caption: 'Bilgi',
                  color: Colors.black45,
                  icon: Icons.more_horiz,
                  onTap: null,
                ),
                IconSlideAction(
                  caption: 'Fatura Ekle',
                  color: Colors.green,
                  icon: Icons.add_a_photo,
                  onTap: null,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
