
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemoapp/model/firebase_model.dart';
import 'package:flutterdemoapp/model/firebase_todo_model.dart';
import 'package:provider/provider.dart';

import 'Authenctication/Authenticate.dart';
import 'bloc/login_bloc.dart';
import 'bloc/register_bloc.dart';
import 'model/todo_model.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final Future<FirebaseApp> _initialization = Firebase.initializeApp();
  @override
  Widget build(BuildContext context) {
   return FutureBuilder(
     future: _initialization,
     builder: (context, snapshot) {
       // CHeck for Errors
       if (snapshot.hasError) {
         print("Something went Wrong");
       }
       // once Completed, show your application
       if (snapshot.connectionState == ConnectionState.done) {
         return MultiProvider(
           providers: [
             Provider<LoginBloc>(create: (context) => LoginBloc()),
             Provider<RegisterBloc>(create: (context) => RegisterBloc()),
             Provider<FirebaseModel>(create: (context) => FirebaseModel()),
             ChangeNotifierProvider<TodoModel>(create: (BuildContext context) {return TodoModel();}),
             ChangeNotifierProvider<FirebaseTodoModel>(create: (BuildContext context) {return FirebaseTodoModel();}),
           ],
           child: MaterialApp(
             title: 'Complete Authentication',
             theme: ThemeData(
               visualDensity: VisualDensity.adaptivePlatformDensity,
             ),
             debugShowCheckedModeBanner: false,
             home: Authenticate(),
           ),
         );
       }
       return CircularProgressIndicator();
     },
   );

    return MultiProvider(
      providers: [
        Provider<LoginBloc>(create: (context) => LoginBloc()),
        Provider<RegisterBloc>(create: (context) => RegisterBloc()),
        ChangeNotifierProvider<TodoModel>(
          create: (BuildContext context) {
            return TodoModel();
          },
        ),
      ],
      child: MaterialApp(
        title: 'Complete Authentication',
        theme: ThemeData(
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        debugShowCheckedModeBanner: false,
        home: Authenticate(),
      ),
    );
  }
}
