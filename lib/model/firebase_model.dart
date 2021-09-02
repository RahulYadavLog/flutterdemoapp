import 'dart:convert';
import 'package:flutter/cupertino.dart';

class FirebaseModel extends ChangeNotifier {
static List<FirebaseItem>? item;
}
class FirebaseItem {
  String name;
  String email;
  FirebaseItem({
    required this.name,
    required this.email,
  });


  FirebaseItem copyWith({
    String? name,
    String? email,
  }) {
    return FirebaseItem(
      name: name ?? this.name,
      email: email ?? this.email,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'name': name,
      'email': email,
    };
  }

  factory FirebaseItem.fromMap(Map<String, dynamic> map) {
    return FirebaseItem(
      name: map['name'],
      email: map['email'],
    );
  }

  String toJson() => json.encode(toMap());

  factory FirebaseItem.fromJson(String source) => FirebaseItem.fromMap(json.decode(source));

  @override
  String toString() => 'FirebaseItem(name: $name, email: $email)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is FirebaseItem &&
      other.name == name &&
      other.email == email;
  }

  @override
  int get hashCode => name.hashCode ^ email.hashCode;
}
