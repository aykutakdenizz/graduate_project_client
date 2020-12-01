import 'package:business_travel/screens/login_screen.dart';
import 'package:flutter/material.dart';

class SettingScreen extends StatefulWidget {
  static String routeName = "/setting_screen";
  static String hiveBoxName = "/preferences";
  @override
  _SettingScreenState createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  var _showOnlyFavorites = false;

  @override
  void initState() {
    super.initState();
  }

  Future<void> initHive() async {}

  Widget preferencesRow({String name, String description, bool switchState}) {
    return Row(
      children: [
        Text(name),
        Switch(
          value: true,
          onChanged: (value) async {
            setState(() {
              switchState = value;
            });
          },
          activeTrackColor: Colors.lightGreenAccent,
          activeColor: Colors.green,
          inactiveThumbColor: Colors.red,
        ),
      ],
    );
  }

  Widget bodyWidget() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          children: [
            preferencesRow(name: 'Background location tracking'),
          ],
        ),
        Container(
          padding: EdgeInsets.only(right: 10),
          height: MediaQuery.of(context).size.height * 0.1,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              RaisedButton.icon(
                onPressed: () {
                  Navigator.of(context).popUntil(ModalRoute.withName(LoginScreen.routeName));
                },
                icon: Icon(Icons.logout),
                label: Text(
                  'Logout',
                  style: TextStyle(
                    fontSize: 20,
                    color: Colors.white,
                  ),
                ),
                color: Colors.red[600],
              ),
            ],
          ),
        ),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Settings'),
      ),
      body: bodyWidget(),
    );
  }
}
