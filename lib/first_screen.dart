import 'package:flutter/material.dart';
import 'task_screen.dart';
import 'button_sheet/button.dart';
import 'package:provider/provider.dart';
import 'models/task.dart';
import 'second_screen/shop_screen.dart';
import 'third_screen/storage_screen.dart';
import 'package:audioplayers/audioplayers.dart';
import 'grapphics/graphic.dart';

class TasksScreen extends StatefulWidget {
  const TasksScreen({Key? key}) : super(key: key);

  @override
  _TasksScreenState createState() => _TasksScreenState();
}

class _TasksScreenState extends State<TasksScreen> {
  int _selectedIndex = 0;

  List<Widget> _widgetOptions = <Widget>[
    TaskList(),
    ShopScreen(),
    StorageScreen(),
  ];

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
      final player = AudioCache();
      player.play('tap.wav');
    });
  }

   String getFixedPower() {
    int temp = Provider.of<TaskData>(context).getPower();
     if (temp >= 1000000000000) {
       return '1 billion';
     }else {
       return '$temp';
     }
   }

   @override
  void initState() {
    super.initState();
    Provider.of<TaskData>(context, listen: false).setData();
    Provider.of<TaskData>(context, listen: false).getData();
  }

  //TODO: create new class for this method

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
          backgroundColor: Colors.cyan,
          title: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(
                Icons.monetization_on,
                color: Color(0xfffdec3c),
                size: 30,
              ),
              Text(' ${Provider.of<TaskData>(context).getAmount()}', style: TextStyle(fontSize: 30),),
              SizedBox(
                width: 30,
              ),
              Image.asset('images/muscle1.png', width: 40, height: 40,),
              Text(' ${getFixedPower()}', style: TextStyle(fontSize: 30),),
            ],
          ),
          actions: [
            IconButton(onPressed: () {
              Navigator.push(context, MaterialPageRoute(
                  builder: (context) => Graph()
              ));
            }, icon: Icon(Icons.auto_graph_sharp), color: Colors.white,),
          ],
          centerTitle: true,
          ),
      body: Center(child: _widgetOptions[_selectedIndex]),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home_outlined),
            label: 'TODO',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.add_shopping_cart_outlined),
            label: 'SHOP',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.work_outline),
            label: 'STORAGE',
          ),
        ],
        backgroundColor: Colors.cyan,
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.white,
        onTap: _onItemTapped,
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          final player = AudioCache();
          player.play('tap.wav');
          showModalBottomSheet(
              context: context,
              builder: (context) => AddTaskScreen(),
              backgroundColor: Color(0xff757575),
              enableDrag: true);
          print(Provider.of<TaskData>(context, listen: false).differenceTime());
        },
        backgroundColor: Colors.cyan,
        child: Icon(Icons.add),
      ),
    );
  }
}
