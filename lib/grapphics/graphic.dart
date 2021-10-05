import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:one_calendar/models/task.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';
import 'package:provider/provider.dart';

class Graph extends StatefulWidget {
  const Graph({Key? key}) : super(key: key);

  @override
  _GraphState createState() => _GraphState();
}

class _GraphState extends State<Graph> {

  Color getColor(int num) {
    if (num < 4) {
      return Colors.lightGreen;
    } else if (num < 8) {
      return Colors.greenAccent;
    } else if (num < 12) {
      return Colors.cyan;
    } else {
      return Colors.yellow;
    }
  }

  String evaluating(int num) {
    if (num < 4) {
      return 'do your best';
    } else if (num < 8) {
      return 'not bad';
    } else if (num < 12) {
      return 'good job';
    } else {
      return 'amazing';
    }
  }

  Column chartOfActivity(String str, int num) {
    return Column(
      children: [
        Text(
          '$str',
          style: TextStyle(color: Colors.cyan, fontSize: 20, fontWeight: FontWeight.bold),
        ),
        SizedBox(
          height: 30,
        ),
        CircularStepProgressIndicator(
          totalSteps: 16,
          currentStep: num,
          stepSize: 10,
          selectedColor: getColor(num),
          unselectedColor: Colors.grey[200],
          padding: 0,
          width: 150,
          height: 150,
          selectedStepSize: 15,
          child: Center(
              child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                evaluating(num),
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 15,
                ),
              ),
              Text(
                '$num',
                style: TextStyle(
                  color: Colors.grey,
                  fontSize: 30,
                ),
              ),
            ],
          )),
          roundedCap: (_, __) => true,
        ),
      ],
    );
  }

  int getPercentages() {
    List <int> arr = Provider.of<TaskData>(context).gettingPointsOfGraph();
    int sum = 0;
    for (int i = 0; i < 7; i++) {
      sum += arr[i];
    }
    int res = sum * 100 ~/ 112;
    return res;
  }
  int getRes() {
    List <int> arr = Provider.of<TaskData>(context).gettingPointsOfGraph();
    int sum = 0;
    for (int i =0 ;i< 7; i++) {
      sum += arr[i];
    }
    int res = sum ~/ 7;
    return res;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        title: Text('Activity', style: TextStyle(
          fontWeight: FontWeight.bold,
          fontSize: 30
        ),),
        backgroundColor: Colors.cyan,
        centerTitle: true,
      ),
      body: Column(
        children: [
          Center(
            child: Container(
              padding: EdgeInsets.all(10),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
              ),
              child: Card(
                elevation: 5,
                child: Container(
                  height: 270,
                  padding: EdgeInsets.all(25),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: [
                      chartOfActivity('Monday', Provider.of<TaskData>(context).gettingPointsOfGraph()[0]),
                      SizedBox(
                        width: 20,
                      ),
                      chartOfActivity('Tuesday ',  Provider.of<TaskData>(context).gettingPointsOfGraph()[1]),
                      SizedBox(
                        width: 20,
                      ),
                      chartOfActivity('Wednesday',  Provider.of<TaskData>(context).gettingPointsOfGraph()[2]),
                      SizedBox(
                        width: 20,
                      ),
                      chartOfActivity('Thursday',  Provider.of<TaskData>(context).gettingPointsOfGraph()[3]),
                      SizedBox(
                        width: 20,
                      ),
                      chartOfActivity('Friday',  Provider.of<TaskData>(context).gettingPointsOfGraph()[4]),
                      SizedBox(
                        width: 20,
                      ),
                      chartOfActivity('Saturday',  Provider.of<TaskData>(context).gettingPointsOfGraph()[5]),
                      SizedBox(
                        width: 20,
                      ),
                      chartOfActivity('Sunday',  Provider.of<TaskData>(context).gettingPointsOfGraph()[6]),
                    ],
                  ),
                ),
              ),
            ),
          ),
          SizedBox(
            height: 20,
          ),
          Container(
            padding: EdgeInsets.all(20),
            decoration: BoxDecoration(
                borderRadius: BorderRadius.all(Radius.circular(30)),
                color: Colors.cyan),
            child: CircularStepProgressIndicator(
              selectedColor: Colors.yellow,
              unselectedColor: Colors.white,
              totalSteps: 16,
              currentStep: getRes(),
              width: 150,
              height: 150,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Week',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                    ),
                  ),
                  Text('${getPercentages()}%', style: TextStyle(
                    color: Colors.white,
                    fontSize: 30,
                  ),)
                ],
              ),
              roundedCap: (_, isSelected) => isSelected,
            ),
          ),
        ],
      ),
    );
  }
  @override
  void deactivate() {
    // TODO: implement deactivate
    super.deactivate();
    Provider.of<TaskData>(context, listen: false).setData();
    List<int> arr = Provider.of<TaskData>(context).gettingPointsOfGraph();
    for (int i = 0; i< 7; i++) {
      print (arr[i]);
    }
  }
}
