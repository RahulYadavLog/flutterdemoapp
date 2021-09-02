import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemoapp/Authenctication/Method.dart';
import 'package:flutterdemoapp/screens/vocabulary_list.dart';
import 'package:flutterdemoapp/screens/vocabulary_screen.dart';
import 'package:shared_preferences/shared_preferences.dart';

class MyDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final FirebaseAuth _auth = FirebaseAuth.instance;

    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          UserAccountsDrawerHeader(
            accountName: Text("Name"),
            accountEmail: Text(_auth.currentUser!.displayName.toString()),
            currentAccountPicture: CircleAvatar(
              backgroundImage: NetworkImage(
                  "https://images.unsplash.com/photo-1570295999919-56ceb5ecca61?ixlib=rb-1.2.1&ixid=eyJhcHBfaWQiOjEyMDd9&auto=format&fit=crop&w=800&q=60"),
            ),
          ),
          ListTile(
            leading: Icon(Icons.person),
            title: Text("Account"),
            subtitle: Text(
              'Account',
            ),
            trailing: Icon(Icons.edit),
          ),
          ListTile(
            leading: Icon(Icons.email),
            title: Text("Email"),
            subtitle: Text(_auth.currentUser!.email.toString()
            ),
            trailing: Icon(Icons.edit),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => AddStudentPage()));
            },
            leading: Icon(Icons.message),
            title: Text("Insert Data"),
            subtitle: Text("Word Meaning"),
            trailing: Icon(Icons.edit),
          ),
          ListTile(
            onTap: () {
              Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => ListStudentPage()));
            },
            leading: Icon(Icons.message),
            title: Text("Vocabulary"),
            subtitle: Text("Word Meaning"),
            trailing: Icon(Icons.edit),
          ),
          ListTile(
            onTap: () {
              logOut(context);
            },
            leading: Icon(Icons.logout),
            title: Text("Logout"),
          )
        ],
      ),
    );
  }
}
