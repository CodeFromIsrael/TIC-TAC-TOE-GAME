import 'dart:convert';

class User {
  final int? id;
  final String? name;
  final String? phone;
  final String? email;
  final String? password;

  User({this.id, this.name, this.phone, this.email, this.password});

  factory User.fromjson(Map<String, dynamic> json) {
    return User(
        id: json["id"],
        name: json["nome"],
        phone: json["telefone"],
        email: json["email"],
        password: json["senha"]);
  }
}
