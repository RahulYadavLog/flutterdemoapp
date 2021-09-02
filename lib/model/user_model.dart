import 'dart:convert';

import 'package:flutter/cupertino.dart';

class UserModel extends ChangeNotifier{
  static List<Item>? item;

  // Get Item by ID
  Item getById(var id) =>
      item!.firstWhere((element) => element.id == id, orElse: null);

  // Get Item by position
  Item getByPosition(int pos) => item![pos];

}

class Item {

 int id;
 String title;
 String url;
  Item({
    required this.id,
    required this.title,
    required this.url,
  });
  


  Item copyWith({
    int? id,
    String? title,
    String? url,
  }) {
    return Item(
      id: id ?? this.id,
      title: title ?? this.title,
      url: url ?? this.url,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'title': title,
      'url': url,
    };
  }

  factory Item.fromMap(Map<String, dynamic> map) {
    return Item(
      id: map['id'],
      title: map['title'],
      url: map['url'],
    );
  }

  String toJson() => json.encode(toMap());

  factory Item.fromJson(String source) => Item.fromMap(json.decode(source));

  @override
  String toString() => 'Item(id: $id, title: $title, url: $url)';

  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;
  
    return other is Item &&
      other.id == id &&
      other.title == title &&
      other.url == url;
  }

  @override
  int get hashCode => id.hashCode ^ title.hashCode ^ url.hashCode;
}
