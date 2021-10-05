import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'first_screen.dart';
import 'models/task.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {

  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => TaskData(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'ToDO-App',
        home: TasksScreen(),
      ),
    );
  }
}
