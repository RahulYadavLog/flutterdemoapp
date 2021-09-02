import 'package:flutter/cupertino.dart';
import 'package:flutterdemoapp/model/firebase_model.dart';

class FirebaseTodoModel extends ChangeNotifier{
  List<FirebaseItem> _firebaseList = [];
  late FirebaseModel _firebaseModel;
  int _counter = 0;
  List<FirebaseItem> get items => _firebaseList;

  FirebaseModel get firebaseModel=>_firebaseModel;
  set firebaseModel(FirebaseModel newUser)
  {
    _firebaseModel=newUser;
    notifyListeners();
  }


  add(FirebaseItem item) {
    _firebaseList.add(item);
    _counter = _firebaseList.length;
    notifyListeners();
  }
}