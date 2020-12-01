import 'package:business_travel/providers/auth_provider.dart';
import 'package:business_travel/providers/location_provider.dart';
import 'package:business_travel/providers/task_provider.dart';
import 'package:business_travel/providers/tasks_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import './screens/login_screen.dart';
import './screens/map_screen.dart';
import './screens/setting_screen.dart';
import './screens/sign_up_screen.dart';
import './screens/task_list_screen.dart';
import './widgets/task_list_card_widget.dart';
import 'screens/auth_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(
          value: Auth(),
        ),
        ChangeNotifierProvider.value(
          value: TasksProvider(),
        ),
        ChangeNotifierProvider.value(
          value: LocationProvider(),
        ),
        ChangeNotifierProvider.value(
          value: TaskProvider(),
        ),
      ],
      child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
                title: 'NO Name',
                theme: ThemeData(
                    primarySwatch: Colors.blue,
                    visualDensity: VisualDensity.adaptivePlatformDensity,
                    accentColor: Colors.green,
                    focusColor: Colors.yellow),
                home: AuthScreen(),
                routes: <String, WidgetBuilder>{
                  AuthScreen.routeName: (BuildContext context) =>
                      AuthScreen(),
                  SignupScreen.routeName: (BuildContext context) =>
                      SignupScreen(),
                  MapScreen.routeName: (BuildContext context) => MapScreen(),
                  TaskListScreen.routeName: (BuildContext context) =>
                      TaskListScreen(),
                  SettingScreen.routeName: (BuildContext context) =>
                      SettingScreen(),
                  TaskListCard.routeName: (BuildContext context) =>
                      TaskListCard(),
                },
              )),
    );
  }
}
/*
class MyHomePage extends StatefulWidget {
  MyHomePage({Key key, this.title}) : super(key: key);
  final String title;
  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  Widget bodyWidget() {
    return Container(
      alignment: Alignment.center,
      child: Column(
        children: [
          Container(
            height: 120.0,
            width: 120.0,
            decoration: BoxDecoration(
              image: DecorationImage(
                image: AssetImage('lib/assets/images/blue_map.jpg'),
                fit: BoxFit.fill,
              ),
              shape: BoxShape.circle,
            ),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, LoginScreen.routeName);
                },
                child: Text('Login'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, SignupScreen.routeName);
                },
                child: Text('Signup'),
              ),
              RaisedButton(
                onPressed: () {
                  Navigator.pushNamed(context, TaskListCard.routeName);
                },
                child: Text('card'),
              ),
            ],
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.title),
      ),
      body: MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: TaskProvider(),
          ),
          ChangeNotifierProvider.value(
            value: TaskProvider(),
          ),
        ],
        child: bodyWidget(),
      ),
    );
  }
}
*/