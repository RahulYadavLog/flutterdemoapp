import 'package:flutter/cupertino.dart';
import 'package:flutterdemoapp/model/user_model.dart';

import 'add_list.dart';

class TodoModel extends ChangeNotifier{
  List<Item> _items = [];
   late UserModel _userModel;
     late AddDataModel _catalog;
  int _counter = 0;
  int get counter => _counter;
  List<Item> get items => _items;
  List<UserModel> taskList = [];

  List<AddDataModel> addList = [];

  UserModel get userModel=>_userModel;
  AddDataModel get catalog => _catalog;

   add(Item item) {
     _items.add(item);
     _counter = _items.length;
     notifyListeners();
   }

  List<Item>? get item_s => _items.map((var id) => _userModel.getById(id)).toList();


  addTaskInList(int id ,String title,String url){
    AddDataModel taskModel = AddDataModel(id,title,url);
         

    addList.add(taskModel);

    notifyListeners();
    //code to do
  }
    // List<AddDataModel> get items_ => addList.map((id) => _catalog.getById(0)).toList();


  set userModel(UserModel newUser)
  {
    _userModel=newUser;
    notifyListeners();
  }

  // List<Item> get items=>taskList.map((id) => _userModel.getById(id)).toList();
  // int get totalPrice=> items.fold(0, (total, current) => total+current.price);

  // void add(Item item)
  // {
  //   taskList.add(item.id);
  //   notifyListeners();

  // }

  void remove(Item item)
  {
    taskList.remove(item.id);

    notifyListeners();
  }

}