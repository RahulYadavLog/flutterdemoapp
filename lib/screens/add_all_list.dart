import 'package:flutter/material.dart';
import 'package:flutterdemoapp/model/todo_model.dart';
import 'package:provider/provider.dart';
class AllAddesdData extends StatelessWidget {
  const AllAddesdData({ Key? key }) : super(key: key);

  @override
  Widget build(BuildContext context) {
   
    return Scaffold(
      appBar: AppBar(
        title: Text("Catalog App"),
      ),
      body: Container(

              decoration: BoxDecoration(borderRadius: BorderRadius.only(topRight: Radius.circular(50), topLeft: Radius.circular(60)), color: Colors.white),
              child: Consumer<TodoModel>(
                builder: (context, todo, child){
                  return Container(
                    margin: EdgeInsets.all(10),
                    child: ItemWidget2(),
                  );
                    
                  // return ListView.builder(
                  //     itemCount: todo.addList.length,
                  //     itemBuilder: (context, index){
                  //       return Container(
                  //         child: ListTile(
                  //           leading: Image.network(todo.addList[index].url),
                  //           contentPadding: EdgeInsets.only(left: 32, right: 32, top: 8, bottom: 8),
                  //           title: Text(todo.addList[index].id.toString(), style : TextStyle(color: Colors.black87,
                  //               fontWeight: FontWeight.bold),),
                  //           subtitle: Text(todo.addList[index].title, style: TextStyle(color: Colors.black45,
                  //               fontWeight: FontWeight.bold),),
                  //
                  //           trailing: Icon(Icons.check_circle, color: Colors.greenAccent,),
                  //         ),
                  //         margin: EdgeInsets.only(bottom: 8, left: 16, right: 16),
                  //       );
                  //     }
                  // );
                },
              )


            )
      
    );
  }
}


class ItemWidget2 extends StatefulWidget {


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
    return ListView(
    children: [
    for (var i = 0; i < pn.items.length; i++)
    Card(
      margin: EdgeInsets.all(10),
      child: ListTile(

        leading: Image.network(pn.items[i].url!),
        title: Text(
          pn.items[i].id.toString()!,
        ),
        subtitle: Text(
          pn.items[i].title,
        ),
      ),
    )
    ],
    );
  }
}
