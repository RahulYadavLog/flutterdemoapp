import 'dart:convert';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:flutterdemoapp/Authenctication/Method.dart';
import 'package:flutterdemoapp/drawer/drawer.dart';
import 'package:flutterdemoapp/model/todo_model.dart';
import 'package:flutterdemoapp/model/user_model.dart';
import 'package:flutterdemoapp/screens/login_screen.dart';
import "package:http/http.dart" as http;
import 'package:provider/provider.dart';
import 'add_all_list.dart';

class HomePage extends StatefulWidget {


  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  // late TextEditingController _nameController = TextEditingController();
  var myText = "Change me";
  var url = "https://jsonplaceholder.typicode.com/photos";
  var data;

  @override
  void initState() {

    getData();
    super.initState();
  }

  getData() async {
    await Future.delayed(Duration(seconds: 2));
    var res = await http.get(Uri.parse(url));
    print(res.body);
    data = jsonDecode(res.body);

    UserModel.item =
        List.from(data).map<Item>((item) => Item.fromMap(item)).toList();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    TodoModel pn = Provider.of<TodoModel>(context);

    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog App"),
        actions: [
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Badge(
                badgeContent: Text(pn.counter.toString()),
                child: Icon(Icons.shopping_cart),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => AllAddesdData(),
                  ),
                );
              },
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(8.0),
            child: IconButton(
              icon: Icon(Icons.logout),
              onPressed: () {
                logOut(context);
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => LoginScreen(),
                  ),
                );
              },
            ),
          )
        ],

      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: UserModel.item != null
            ?
        ListView.builder(
          itemCount: UserModel.item!.length,
          itemBuilder: (context, index) => ItemWidget2(
            item: UserModel.item![index],
          ),
        )
            : Center(
          child: CircularProgressIndicator(),
        ),
      ),
      drawer: MyDrawer(),
    );
  }
}


class ItemWidget1 extends StatefulWidget {
  final Item item;


  const ItemWidget1({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ItemWidget1State createState() => _ItemWidget1State();
}
late final TodoModel todoModel;
class _ItemWidget1State extends State<ItemWidget1> {
  @override
  Widget build(BuildContext context) {




    // setState(() {
    //   var isInCart = context.select<TodoModel, bool>(
    //     // Here, we are only interested whether [item] is inside the cart.
    //         (cart) => cart.taskList.contains(0),
    //   );

    // });


    final size = MediaQuery.of(context).size;
    return Card(
      child: Container(
        height: 100,
        width: size.width,
        child: Row(
          children: [
            Image.network(
              widget.item.url,
              width: size.width / 5,
              height: size.height / 1.1,
              fit: BoxFit.fill,
            ),
            Padding(
              padding: const EdgeInsets.all(8.0),
              child: Container(
                width: size.width / 2,
                child: Column(
                  children: [
                    Text(
                      widget.item.id.toString(),
                    ),
                    Text(
                      widget.item.title,
                    )
                  ],
                ),
              ),
            ),
            // context.read<AddDataModel>().id.toString().contains(context.read<AddDataModel>().id.toString()) ? Icon(Icons.done):
            GestureDetector(
              onTap: () {
                Icon(Icons.done);

                Navigator.of(context).push(MaterialPageRoute(builder: (_)=>AllAddesdData()));
                Provider.of<TodoModel>(context,listen: false).addTaskInList(widget.item.id,widget.item.title,widget.item.url);

              },
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Container(
                  child: Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Text(
                      "Add",
                      style: TextStyle(color: Colors.white),
                    ),
                  ),
                  decoration: BoxDecoration(
                    color: Colors.blue,
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}


class ItemWidget2 extends StatefulWidget {
  final Item item;


  const ItemWidget2({
    Key? key,
    required this.item,
  }) : super(key: key);

  @override
  _ItemWidget2State createState() => _ItemWidget2State();
}
late final TodoModel todoModel2;
class _ItemWidget2State extends State<ItemWidget2> {
  @override
  Widget build(BuildContext context) {

    TodoModel pn = Provider.of<TodoModel>(context);



    // setState(() {
    //   var isInCart = context.select<TodoModel, bool>(
    //     // Here, we are only interested whether [item] is inside the cart.
    //         (cart) => cart.taskList.contains(0),
    //   );

    // });


    final size = MediaQuery.of(context).size;
    bool isSelected=pn.items!.contains(widget.item);
    return Card(
      child:
      ListTile(
          leading: Image.network(widget.item.url),
          title: Text(
            widget.item.id.toString()
          ),
          subtitle: Text(
            'Price: ₹100' ,
          ),
          trailing:isSelected?
          Icon(Icons.done) : ElevatedButton(
            onPressed: () {

              pn.add(widget.item);
            },
            child: Text('Add'),
          )),

    );
  }
}
