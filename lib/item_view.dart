
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:todolist_finally_provider/todo_list_provider.dart';
import 'package:todolist_finally_provider/todo_model.dart';
import 'package:provider/provider.dart';

class ItemView extends StatefulWidget {
  late final Todo item;

  ItemView({required this.item});


  @override
  _ItemViewState createState() => _ItemViewState();
}

class _ItemViewState extends State<ItemView> {
  TextEditingController _textEditingController = TextEditingController();


  @override
  void initState() {
    if(widget.item != null){
      _textEditingController.text = widget.item.description;
      super.initState();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('New Task'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            TextFormField(
              controller: _textEditingController,
              onFieldSubmitted: (value) =>submit(),
              textCapitalization: TextCapitalization.sentences,
              autofocus: true,
            ), SizedBox(height: 10,),
            RaisedButton(onPressed: submit, child: Text('Submit'),)
          ],
        ),
      ),
    );
  }

  submit() {
    String description = _textEditingController.text;
    if(description !=null && description.isNotEmpty){
      if(widget.item != null){
        context.read<TodoListProvider>().editTask(widget.item, description);
      } else {
        context.read<TodoListProvider>().addNewTask(description);
      }
      Navigator.pop(context,description);
    }
  }
}
