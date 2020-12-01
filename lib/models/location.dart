class DbLocation{
  int id;
  double latitude;
  double longitude;
  String date;

  DbLocation({
    this.id,
    this.latitude,
    this.longitude,
    this.date,
  });

  DbLocation.fromMap(Map<String, dynamic> map) {
    id = map[id];
    latitude = map[latitude];
    longitude = map[longitude];
    date = map[date];
  }

  DbLocation.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        latitude = json['latitude'],
        longitude = json['longitude'],
        date = json['date'];

}