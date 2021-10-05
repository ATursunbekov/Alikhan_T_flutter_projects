import 'package:flutter/material.dart';
import 'package:one_calendar/models/task.dart';
import 'package:provider/provider.dart';

class StorageScreen extends StatelessWidget {
  const StorageScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GridView.count(crossAxisCount: 2,
    children: Provider.of<TaskData>(context, listen: false).getChar());
  }
}
