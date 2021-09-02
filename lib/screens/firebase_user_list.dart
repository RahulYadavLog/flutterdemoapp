import 'package:flutter/material.dart';
import 'package:flutterdemoapp/model/firebase_model.dart';
import 'package:flutterdemoapp/model/firebase_todo_model.dart';
class FirebaseUserList extends StatefulWidget {
  final FirebaseItem item;


  const FirebaseUserList({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ItemWidget2State createState() => _ItemWidget2State();
}
class _ItemWidget2State extends State<FirebaseUserList> {
  @override
  Widget build(BuildContext context) {


    return  Scaffold(
      appBar: AppBar(title: Text("User List")),
      body: ListView(
        children: [
            Card(
              margin: EdgeInsets.all(10),
              child: ListTile(
                title: Text(
                  widget.item.name,
                ),
                subtitle: Text(
                  widget.item.email,
                ),
              ),
            )
        ],
      ),
    );
  }
}