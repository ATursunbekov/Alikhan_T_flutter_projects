import 'package:flutter/material.dart';

class TaskTile extends StatelessWidget {

  final bool check;
  final Function(bool?) fun;
  final String str;
  final Function() fun1;


  TaskTile(this.check, this.fun, this.str, this.fun1);
  @override
  Widget build(BuildContext context) {

    return Container(
      margin: EdgeInsets.all(10),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.all(Radius.circular(30)),
        color: Colors.cyan,
      ),
      child: ListTile(
        leading: Checkbox(
          activeColor: Colors.white60,
          value: check,
          onChanged: fun,
        ),
        title: Text(str, style: TextStyle(
          color: Colors.white,
          decorationColor: Colors.black,
          decoration: check? TextDecoration.lineThrough: null,
        ),),
        trailing: TextButton(child: Icon(Icons.highlight_remove, color: Colors.white,),
        onPressed: fun1,),
      ),
    );
  }
}