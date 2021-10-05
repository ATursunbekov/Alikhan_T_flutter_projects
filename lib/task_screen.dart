import 'package:flutter/material.dart';
import 'package:one_calendar/models/task.dart';
import 'task_tile.dart';
import 'package:provider/provider.dart';
import 'models/task.dart';
import 'package:audioplayers/audioplayers.dart';

class TaskList extends StatefulWidget {
  const TaskList({Key? key}) : super(key: key);

  @override
  _TaskListState createState() => _TaskListState();
}

class _TaskListState extends State<TaskList> {
  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      itemBuilder: (context, index) {
        return TaskTile(
            Provider.of<TaskData>(context).tasks[index].isDone,
            (value) {
              final player = AudioCache();
              player.play('tap.wav');
              Provider.of<TaskData>(context, listen: false).updateTask(
                  Provider.of<TaskData>(context, listen: false).tasks[index]);
              Provider.of<TaskData>(context, listen: false).taskDone(
                  Provider.of<TaskData>(context, listen: false).tasks[index]);
              Provider.of<TaskData>(context, listen: false).gotCoin(
                  Provider.of<TaskData>(context, listen: false).tasks[index]);
              Provider.of<TaskData>(context, listen: false).increaseDoneTasks();
              Provider.of<TaskData>(context, listen: false).increaseGraph();
              Provider.of<TaskData>(context, listen: false).setData();
            },
            Provider.of<TaskData>(context).tasks[index].name,
            () {
              final player = AudioCache();
              player.play('tap.wav');
              Provider.of<TaskData>(context, listen: false).deleteTask(
                  Provider.of<TaskData>(context, listen: false).tasks[index]);
              Provider.of<TaskData>(context, listen: false).setData();
            });
      },
      itemCount: Provider.of<TaskData>(context).taskCount,
    );
  }
}
