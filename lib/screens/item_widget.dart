import 'package:flutter/material.dart';
import 'package:flutterdemoapp/model/user_model.dart';

class ItemWidget extends StatelessWidget {
  final Item item;

  const ItemWidget({required this.item});
        

  @override
  Widget build(BuildContext context) {
    return Card(
      child: ListTile(
        onTap: () {
          print("${item.id} pressed");
        },
        leading: Image.network(item.url),
        title: Text((item.id).toString()),
        subtitle: Text(item.title),
    
      ),
    );
  }
}
