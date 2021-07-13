import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todolist_finally_provider/item_view.dart';
import 'package:todolist_finally_provider/screen_test.dart';
import 'package:todolist_finally_provider/todo_list_provider.dart';
import 'package:todolist_finally_provider/todo_model.dart';

void main() {
  runApp(ChangeNotifierProvider(
    create: (context) => TodoListProvider(),
    child: MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
          brightness: Brightness.dark,
          primaryColor: Colors.teal,
          visualDensity: VisualDensity.adaptivePlatformDensity),
      home: new Home(),
    );
  }
}

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Todo App'),
        centerTitle: true,
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () {
          goToNewItemView(context);
        },
      ),
      body: Consumer<TodoListProvider>(
        builder: (context, provider, child) {
          return provider.items.isNotEmpty
              ? ListView.builder(
                  itemCount: provider.items.length,
                  itemBuilder: (context, index) {
                    return TodoItem(
                      isSelect: provider.listSelect.contains(provider.items[index]),
                      item: provider.items[index],
                      onTap: () {
                        // provider.changeCompleteness()
                        // goToNewItemView(context);
                        provider.selectItem(provider.items[index]);
                      },
                      onLongPress: () {
                        goToNewItemView(context);
                      },
                      // onDismissed: (){
                      //   provider.removeItem(provider.items[index])
                      // } ,
                    );
                  })
              : SizedBox();
        },
      ),
    );
  }
}

class TodoItem extends StatelessWidget {
  final Todo item;
  final bool isSelect;
  final VoidCallback onTap;
  final VoidCallback onLongPress;
  // final ConfirmDismissCallback onDismissed;

  // TodoItem(this.item, this.onTap, this.onLongPress, this.onDismissed);
  TodoItem(
      {required this.item,
      required this.isSelect,
      required this.onTap,
      // required this.onDismissed,
      required this.onLongPress});

  @override
  Widget build(BuildContext context) {
    return Dismissible(
        key: Key(item.hashCode.toString()),
        direction: DismissDirection.startToEnd,
        // onDismissed: (direction) => onDismissed,
        child: ListTile(
          title: Text(
            item.description,
            style: TextStyle(
                decoration: isSelect ? TextDecoration.lineThrough : null),
          ),
          trailing: Icon(
              isSelect ? Icons.check_box : Icons.check_box_outline_blank),
          onTap: onTap,
          onLongPress: onLongPress,
        ));
  }
}

goToNewItemView(BuildContext context) {
  Navigator.of(context).push(MaterialPageRoute(builder: (context) {
    return ScreenTest();
  }));
}
