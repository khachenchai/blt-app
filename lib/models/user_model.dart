class UserModel {
  late String? id;
  late String? password;
  late String? name;
  late String? email;

  UserModel({this.id, this.password, this.name, this.email});

  Map<String, dynamic> toJson() => {
    'id' : id,
    'name' : name,
    'email' : email,
    'password' : password
  };
}