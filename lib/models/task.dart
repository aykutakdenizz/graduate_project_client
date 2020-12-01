class Task {
  int id;
  String name;
  String description;
  double price;
  double startLatitude;
  double startLongitude;
  String date;
  String type;
  double finishLatitude;
  double finishLongitude;
  Task(
      {this.id,
      this.name,
      this.description,
      this.price,
      this.startLatitude,
      this.startLongitude,
      this.date,
      this.type,
      this.finishLatitude,
      this.finishLongitude,
      t});

  Task.fromMap(Map<String, dynamic> map) {
    id = map[id];
    name = map[name];
    description = map[description];
    price = map[price];
    startLatitude = map[startLatitude];
    startLongitude = map[startLongitude];
    date = map[date];
    type = map[type];
    finishLatitude = map[finishLatitude];
    finishLongitude = map[finishLongitude];
  }

  Task.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        name = json['name'],
        description = json['description'],
        price = json['price'],
        startLatitude = json['startLatitude'],
        startLongitude = json['startLongitude'],
        date = json['date'],
        type = json['type'],
        finishLatitude = json['finishLatitude'],
        finishLongitude = json['finishLongitude'];
}
