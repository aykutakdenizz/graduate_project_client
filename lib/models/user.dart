class User {
  int id;
  int companyId;
  int photoId;
  String role;
  String name;
  String email;
  String password;
  DateTime createdAt;
  DateTime updatedAt;

  User({
    this.id,
    this.companyId,
    this.photoId,
    this.role,
    this.name,
    this.email,
    this.password,
    this.createdAt,
    this.updatedAt,
  });

  User.fromMap(Map<String, dynamic> map) {
    id = map[id];
    companyId = map[companyId];
    photoId = map[photoId];
    role = map[role];
    name = map[name];
    email = map[email];
    password = map[password];
    createdAt = map[createdAt];
    updatedAt = map[updatedAt];
  }

  User.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        companyId = json['companyId'],
        photoId = json['photoId'],
        role = json['role'],
        name = json['name'],
        email = json['email'],
        password = json['password'],
        createdAt = json['createdAt'],
        updatedAt = json['updatedAt'];
}
