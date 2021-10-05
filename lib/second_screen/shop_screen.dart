import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import 'package:one_calendar/models/task.dart';
import 'package:audioplayers/audioplayers.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ShopScreen extends StatefulWidget {
  const ShopScreen({Key? key}) : super(key: key);

  @override
  _ShopScreenState createState() => _ShopScreenState();
}

class _ShopScreenState extends State<ShopScreen> {

  void showToast() => Fluttertoast.showToast(msg: 'You need more coins', fontSize: 18);

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Expanded(
            child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Regular Pokeball',
                          style: TextStyle(
                              color: Colors.redAccent, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.monetization_on,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          '8',
                          style: TextStyle(
                              color: Colors.redAccent, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextButton(
                      child: Image.asset('images/pokeball.png'),
                      onPressed: () {
                        int temp = Provider.of<TaskData>(context, listen: false).getAmount();
                        if (temp >= 8) {
                          Provider.of<TaskData>(context, listen: false).getOrdinary(context);
                          Provider.of<TaskData>(context, listen: false).setData();
                          //TODO sound
                          final player = AudioCache();
                          player.play('tap1.mp3');
                        } else {
                          showToast();
                        }
                      },
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.yellow,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Rare Pokeball',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.monetization_on,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          '16',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextButton(
                      child: Image.asset('images/pokeball2.png'),
                      onPressed: () {
                        int temp = Provider.of<TaskData>(context, listen: false).getAmount();
                        if (temp >= 16) {
                          Provider.of<TaskData>(context, listen: false).getRare(context);
                          Provider.of<TaskData>(context, listen: false).setData();
                          final player = AudioCache();
                          player.play('tap1.mp3');
                        }else {
                          showToast();
                        }
                      },
                    ),
                  ],
                )),
          ),
          Expanded(
            child: Container(
                margin: EdgeInsets.all(10),
                decoration: BoxDecoration(
                  color: Colors.red,
                  borderRadius: BorderRadius.all(Radius.circular(30)),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Legendary Pokeball',
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                        SizedBox(
                          width: 10,
                        ),
                        Icon(
                          Icons.monetization_on,
                          color: Colors.white,
                          size: 20,
                        ),
                        Text(
                          '32',
                          style: TextStyle(
                              color: Colors.amber, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                    TextButton(
                      child: Image.asset('images/pokeball3.png'),
                      onPressed: () {
                        int temp = Provider.of<TaskData>(context, listen: false).getAmount();
                        if (temp >= 32) {
                          Provider.of<TaskData>(context, listen: false).getLegendary(context);
                          Provider.of<TaskData>(context, listen: false).setData();
                          final player = AudioCache();
                          player.play('tap1.mp3');
                        }else {
                          showToast();
                        }
                      },
                    ),
                  ],
                )),
          ),
        ],
      ),
    );
  }
}
