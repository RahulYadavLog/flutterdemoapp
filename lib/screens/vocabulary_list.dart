import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemoapp/model/firebase_model.dart';
import 'package:flutterdemoapp/screens/firebase_user_list.dart';
import 'package:flutterdemoapp/screens/update_firebase_data.dart';

class ListStudentPage extends StatefulWidget {
  ListStudentPage({Key? key}) : super(key: key);

  @override
  _ListStudentPageState createState() => _ListStudentPageState();
}

class _ListStudentPageState extends State<ListStudentPage> {
  final Stream<QuerySnapshot> studentsStream =
      FirebaseFirestore.instance.collection('students').snapshots();

  // For Deleting User
  CollectionReference students =
      FirebaseFirestore.instance.collection('students');
  Future<void> deleteUser(id) {
    // print("User Deleted $id");
    return students
        .doc(id)
        .delete()
        .then((value) => print('User Deleted'))
        .catchError((error) => print('Failed to Delete user: $error'));
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: studentsStream,
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (snapshot.hasError) {
            print('Something went Wrong');
          }
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
              child: CircularProgressIndicator(),
            );
          }

          final List storedocs = [];
          snapshot.data!.docs.map((DocumentSnapshot document) {
            Map a = document.data() as Map<String, dynamic>;
            storedocs.add(a);
            a['id'] = document.id;
          }).toList();
          FirebaseModel.item = storedocs.cast<FirebaseItem>();

          String name = storedocs[0]['name'];

          // return ListView.builder(itemCount: storedocs.length,itemBuilder: (context,index)=>
          //     FirebaseUserList(
          //       item:storedocs[index],
          //     ));
          return Scaffold(
            appBar: AppBar(title: Text("User List")),
            body: ListView(
              children: [
                for (var i = 0; i < storedocs.length; i++)
                  Card(
                    margin: EdgeInsets.all(10),
                    child: ListTile(
                      onTap: () {
                        dailogBox(storedocs,i);
                      },
                      title: Text(
                        storedocs[i]["name"],
                      ),
                      subtitle: Text(
                        storedocs[i]["email"],
                      ),
                    ),
                  )
              ],
            ),
          );
          // return Container(
          //   margin: EdgeInsets.symmetric(horizontal: 10.0, vertical: 20.0),
          //   child: SingleChildScrollView(
          //     scrollDirection: Axis.vertical,
          //     child: Table(
          //       border: TableBorder.all(),
          //       columnWidths: const <int, TableColumnWidth>{
          //         1: FixedColumnWidth(140),
          //       },
          //       defaultVerticalAlignment: TableCellVerticalAlignment.middle,
          //       children: [
          //         TableRow(
          //           children: [
          //             TableCell(
          //               child: Container(
          //                 color: Colors.greenAccent,
          //                 child: Center(
          //                   child: Text(
          //                     'Name',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             TableCell(
          //               child: Container(
          //                 color: Colors.greenAccent,
          //                 child: Center(
          //                   child: Text(
          //                     'Email',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //             TableCell(
          //               child: Container(
          //                 color: Colors.greenAccent,
          //                 child: Center(
          //                   child: Text(
          //                     'Action',
          //                     style: TextStyle(
          //                       fontSize: 20.0,
          //                       fontWeight: FontWeight.bold,
          //                     ),
          //                   ),
          //                 ),
          //               ),
          //             ),
          //           ],
          //         ),
          //         for (var i = 0; i < storedocs.length; i++) ...[
          //           TableRow(
          //             children: [
          //               TableCell(
          //                 child: Center(
          //                     child: Text(storedocs[i]['name'],
          //                         style: TextStyle(fontSize: 18.0))),
          //               ),
          //               TableCell(
          //                 child: Center(
          //                     child: Text(storedocs[i]['email'],
          //                         style: TextStyle(fontSize: 18.0))),
          //               ),
          //               TableCell(
          //                 child: Row(
          //                   mainAxisAlignment: MainAxisAlignment.center,
          //                   children: [
          //                     IconButton(
          //                       onPressed: () => {
          //                         // Navigator.push(
          //                         //   context,
          //                         //   MaterialPageRoute(
          //                         //     builder: (context) => UpdateStudentPage(
          //                         //         id: storedocs[i]['id']),
          //                         //   ),
          //                         // )
          //                       },
          //                       icon: Icon(
          //                         Icons.edit,
          //                         color: Colors.orange,
          //                       ),
          //                     ),
          //                     IconButton(
          //                       onPressed: () =>
          //                       {deleteUser(storedocs[i]['id'])},
          //                       icon: Icon(
          //                         Icons.delete,
          //                         color: Colors.red,
          //                       ),
          //                     ),
          //                   ],
          //                 ),
          //               ),
          //             ],
          //           ),
          //         ],
          //       ],
          //     ),
          //   ),
          // );
        });
  }

  void dailogBox(List storedocs,int index) {
    showDialog(
        context: context,
        builder: (BuildContext context) {
          return Dialog(
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(10.0)), //this right here
            child: Container(
              height: 200,
              child: Padding(
                padding: const EdgeInsets.all(12.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(width: 329.0,
                    child:
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => UpdateStudentPage(
                                id: storedocs[index]['id']),
                          ),
                        );
                        // Navigator.pop(context);

                      },
                      child: Text(
                        "Update",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),
                    ),
                SizedBox(width: 329.0,
                  child:
                    ElevatedButton(
                      onPressed: () {
                        deleteUser(storedocs[index]['id']);
                        Navigator.pop(context);
                      },
                      child: Text(
                        "Delete",
                        style: TextStyle(fontSize: 20),
                      ),
                    ),)

                  ],
                ),
              ),
            ),
          );
        });
  }
}
