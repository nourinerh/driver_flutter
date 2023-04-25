import 'package:cloud_firestore/cloud_firestore.dart';

class DriversModel {
  final int? id;
  final String name;
  final String email;
  final String phone;
  final String password;

  DriversModel({
    this.id,
    required this.name,
    required this.email,
    required this.phone,
    required this.password,
  });
  toJson() {
    return {
      'name': name,
      'email': email,
      'phone': phone,
      'password': password,
    };
  }

  factory DriversModel.fromSnapchot(
      DocumentSnapshot<Map<String, dynamic>> document) {
    final data = document.data()!;
    return DriversModel(
        id: data["id"],
        name: data["name"],
        email: data["email"],
        phone: data["phone"],
        password: data["password"]);
  }

  static fromJson(Map<String, dynamic> data) {}
}
