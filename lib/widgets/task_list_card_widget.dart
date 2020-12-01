import 'package:business_travel/models/task.dart';
import 'package:business_travel/screens/map_screen.dart';
import 'package:flutter/material.dart';

class TaskListCard extends StatefulWidget {
  static String routeName = "/card";

  String name;
  String description;
  DateTime date;
  int id;

  TaskListCard() {
    this.id = 1;
    this.date = DateTime.now();
    this.description = "aciklafdgfdgfdgfdgdsdf\n" +
        "fgdgdfgdfgdfgfdgfdgfdgdgf\n" +
        "fdgfdgfdgdfgdfgfdgfdgma";
    this.name = "Gorev 1";
  }

  @override
  _TaskListCardState createState() => _TaskListCardState();
}

class _TaskListCardState extends State<TaskListCard> {
  bool isDetailed = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('deneme')),
      body: Container(
        height: isDetailed ? 150 : 60,
        padding: EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
        width: double.infinity,
        child: Card(
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: <Widget>[
              Container(
                width: MediaQuery.of(context).size.width * 0.50,
                child: Column(
                  children: [
                    Text(widget.name),
                    Text(widget.date.toString()),
                    if (isDetailed) Text(widget.description),
                  ],
                ),
              ),
              GestureDetector(
                child: Container(
                  width: MediaQuery.of(context).size.width * 0.3,
                  margin:
                      EdgeInsets.all(MediaQuery.of(context).size.width * 0.01),
                  decoration: isDetailed
                      ? BoxDecoration(
                          image: DecorationImage(
                            image: AssetImage('lib/assets/images/blue_map.jpg'),
                            fit: BoxFit.fill,
                          ),
                        )
                      : null,
                ),
                onTap: (){
                  Navigator.pushNamed(context, MapScreen.routeName);
                },
              ),
              Container(
                width: MediaQuery.of(context).size.width * 0.1,
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: Icon(isDetailed == false
                      ? Icons.arrow_drop_down
                      : Icons.arrow_drop_up),
                  onPressed: () {
                    setState(() {
                      isDetailed = !isDetailed;
                    });
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
