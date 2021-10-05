import 'package:flutter/cupertino.dart';
import 'package:flutter/foundation.dart';
import 'package:one_calendar/third_screen/card_style.dart';
import 'dart:collection';
import 'task_data.dart';
import 'dart:math';
import 'package:one_calendar/third_screen/characters.dart';
import 'package:flutter/material.dart';
import 'package:one_calendar/third_screen/poke_detail.dart';
import 'package:shared_preferences/shared_preferences.dart';

class TaskData extends ChangeNotifier {

  //TODO for time
  int time = DateTime.now().millisecondsSinceEpoch;
  int check = 0;
  late var firstTime = DateTime.now();
  int amountOfDoneTasks = 0;
  List<int> pointsOfGraph = [0 , 0, 0, 0, 0 , 0, 0];
  bool checkFirstTime = true;
  int weeks = 0;

  //TODO Amount of done tasks for graph counting

  List<int> gettingPointsOfGraph() {
    int temp = differenceTime();
    int weekCheck = 0;

    while (temp > 6) {
      temp -= 6;
      weekCheck++;
    }
    if (weeks  != weekCheck) {
      weeks = weekCheck;
      for (int i = 0; i < 7; i++) {
        pointsOfGraph[i] = 0;
      }
    }
    return pointsOfGraph;
  }
  void increaseGraph() {
    gettingPointsOfGraph();
    int temp = differenceTime();
    while (temp > 6) {
      temp -= 6;
    }
    pointsOfGraph[temp]++;
    notifyListeners();
  }

  int differenceTime() {
    var timeNow = DateTime.now();
    Duration dur = timeNow.difference(firstTime);
    return dur.inDays;
  }

  List<Task> _tasks = [];
  List<CardStyle> usersChar = [];

  int count = 10000;
  int amountOfPower = 0;

  int doneTasks() {
    return amountOfDoneTasks;
  }

  void increaseDoneTasks() {
    amountOfDoneTasks++;
  }

  //TODO: saving data

  setData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //TODO Saving done task for every day
    List<String> str = [];
    for (int i = 0; i < pointsOfGraph.length; i++) {
      str.add(pointsOfGraph[i].toString());
    }
    prefs.setStringList('pointsOfGraph', str);

    //TODO: Time
    if (check == 0) {
      prefs.setInt('time', time);
      check = 1;
    }

    prefs.setInt('weeks', weeks);

    prefs.setInt('check', check);
    prefs.setInt('doneTasks', amountOfDoneTasks);

    //TODO tasks
    final String encodedData = Task.encode(_tasks);
    await prefs.setString('tasks_toStore', encodedData);
    //TODO poc
    final String encodedData1 = CardStyle.encode(usersChar);
    await prefs.setString('char_toStore', encodedData1);
    //TODO ordinary vars
    prefs.setInt('coins', count);
    notifyListeners();
  }

  getData() async{
    SharedPreferences prefs = await SharedPreferences.getInstance();

    //TODO points of each day
    List<String> str = prefs.getStringList('pointsOfGraph')!;
    for (int i = 0; i < str.length; i++) {
      pointsOfGraph[i] += int.parse(str[i]);
    }

    //TODO: time
    var temp1 = prefs.getInt('check')!;
    check = temp1;
    var temp = prefs.getInt('time')!;
    firstTime = DateTime.fromMillisecondsSinceEpoch(temp);
    var temp2 = prefs.getInt('doneTasks');
    amountOfDoneTasks = temp2!;

    var temp3 = prefs.getInt('weeks')!;
    weeks = temp3;

    //TODO: tasks
    final String taskString = prefs.getString('tasks_toStore')!;
    final List<Task> tasks = Task.decode(taskString);
    _tasks = tasks;
    //TODO Char
    final String charString = prefs.getString('char_toStore')!;
    final List<CardStyle> chars = CardStyle.decode(charString);
    usersChar = chars;

    //TODO ordinary vars
    count = prefs.getInt('coins')!;

    notifyListeners();
  }

  //TODO: random
  Random random = new Random();
  AllCharacters characters = AllCharacters();

  UnmodifiableListView<Task> get tasks {
    return UnmodifiableListView(_tasks);
  }

  int get taskCount {
    return _tasks.length;
  }

  void addTask(String newTaskTitle) {
    final task = Task(name: newTaskTitle);
    _tasks.add(task);
    notifyListeners();
  }

  void gotCoin(Task task) {
    task.getCoin();
    notifyListeners();
  }

  void updateTask(Task task) {
    task.toggleDone();
    notifyListeners();
  }

  void deleteTask(Task task) {
    _tasks.remove(task);
    notifyListeners();
  }

  int getAmount() {
    return count;
  }

  void taskDone(Task task) {
    if (task.checkCoins == true) {
      count++;
    }
    notifyListeners();
  }

  int getPower() {
    int all = 0;
    usersChar.forEach((element) {
      all+= element.maxCP;
    });
    amountOfPower = all;
    return all;
  }

  //TODO: this part for creating cards of poke

  void sortCp(){
    usersChar.sort((a, b) => b.maxCP.compareTo(a.maxCP));
  }

  List<CardStyle> getChar() {
    return usersChar;
  }

  void loadScreen(CardStyle cardStyle,context){
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => PokeDetail(
              name: cardStyle.name,
              height: cardStyle.height,
              weight: cardStyle.weight,
              hp: cardStyle.hp,
              attack: cardStyle.attack,
              defence: cardStyle.defence,
              maxCP: cardStyle.maxCP,
              url: cardStyle.url,
              amount: cardStyle.amount,
            )));
  }

  void getOrdinary(context){
    count -= 8;
    int num = random.nextInt(1000) + 1;
      if (num >= 1 && num < 895) {
        int temp = random.nextInt(34);
        if (!usersChar.contains(characters.allChar[temp])) {
          usersChar.add(characters.allChar[temp]);
          loadScreen(characters.allChar[temp], context);
        }else {
          int index = usersChar.indexOf(characters.allChar[temp]);
          usersChar[index].increaseAmount();
          loadScreen(characters.allChar[temp], context);
        }
        amountOfPower += characters.allChar[temp].maxCP;
      } else if (num >= 892 && num < 995) {
        int temp = random.nextInt(21)+ 34;
        if (!usersChar.contains(characters.allChar[temp])) {
          usersChar.add(characters.allChar[temp]);
          loadScreen(characters.allChar[temp], context);
        }else {
          int index = usersChar.indexOf(characters.allChar[temp]);
          usersChar[index]..increaseAmount();
          loadScreen(characters.allChar[temp], context);
        }
        amountOfPower += characters.allChar[temp].maxCP;
      } else {
        int temp = random.nextInt(8)+ 55;
        if (!usersChar.contains(characters.allChar[temp])) {
          usersChar.add(characters.allChar[temp]);
          loadScreen(characters.allChar[temp], context);
        }else {
          int index = usersChar.indexOf(characters.allChar[temp]);
          usersChar[index].increaseAmount();
          loadScreen(characters.allChar[temp], context);
        }
        amountOfPower += characters.allChar[temp].maxCP;
    }
      sortCp();
    notifyListeners();
  }

  void getRare(context){
    count -= 16;
    int num = random.nextInt(1000) + 1;
      if (num >= 1 && num < 500) {
        int temp = random.nextInt(34);
        if (!usersChar.contains(characters.allChar[temp])) {
          usersChar.add(characters.allChar[temp]);
          loadScreen(characters.allChar[temp], context);
        }else {
          int index = usersChar.indexOf(characters.allChar[temp]);
          usersChar[index]..increaseAmount();
          loadScreen(characters.allChar[temp], context);
        }
        amountOfPower += characters.allChar[temp].maxCP;
      } else if (num >= 500 && num < 980) {
        int temp = random.nextInt(21)+ 34;
        if (!usersChar.contains(characters.allChar[temp])) {
          usersChar.add(characters.allChar[temp]);
          loadScreen(characters.allChar[temp], context);
        }else {
          int index = usersChar.indexOf(characters.allChar[temp]);
          usersChar[index]..increaseAmount();
          loadScreen(characters.allChar[temp], context);
        }
        amountOfPower += characters.allChar[temp].maxCP;
      } else {
        int temp = random.nextInt(8)+ 55;
        if (!usersChar.contains(characters.allChar[temp])) {
          usersChar.add(characters.allChar[temp]);
          loadScreen(characters.allChar[temp], context);
        }else {
          int index = usersChar.indexOf(characters.allChar[temp]);
          usersChar[index]..increaseAmount();
          loadScreen(characters.allChar[temp], context);
        }
        amountOfPower += characters.allChar[temp].maxCP;
    }
    sortCp();
    notifyListeners();
  }

  void getLegendary(context){
    count -= 32;
    int num = random.nextInt(1000) + 1;
      if (num >= 1 && num < 100) {
        int temp = random.nextInt(34);
        if (!usersChar.contains(characters.allChar[temp])) {
          usersChar.add(characters.allChar[temp]);
          loadScreen(characters.allChar[temp], context);
        }else {
          int index = usersChar.indexOf(characters.allChar[temp]);
          usersChar[index]..increaseAmount();
          loadScreen(characters.allChar[temp], context);
        }
        amountOfPower += characters.allChar[temp].maxCP;
      } else if (num >= 100 && num < 900) {
        int temp = random.nextInt(21)+ 34;
        if (!usersChar.contains(characters.allChar[temp])) {
          usersChar.add(characters.allChar[temp]);
          loadScreen(characters.allChar[temp], context);
        }else {
          int index = usersChar.indexOf(characters.allChar[temp]);
          usersChar[index]..increaseAmount();
          loadScreen(characters.allChar[temp], context);
        }
        amountOfPower += characters.allChar[temp].maxCP;
      } else {
        int temp = random.nextInt(8)+ 55;
        if (!usersChar.contains(characters.allChar[temp])) {
          usersChar.add(characters.allChar[temp]);
          loadScreen(characters.allChar[temp], context);
        }else {
          int index = usersChar.indexOf(characters.allChar[temp]);
          usersChar[index].increaseAmount();
          loadScreen(characters.allChar[temp], context);
        }
        amountOfPower += characters.allChar[temp].maxCP;
    }
    sortCp();
    notifyListeners();
  }
}
