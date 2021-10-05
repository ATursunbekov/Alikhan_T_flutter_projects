import 'package:flutter/material.dart';

class PokeDetail extends StatelessWidget {
  final String name;
  final double height;
  final double weight;
  final int hp;
  final int attack;
  final int defence;
  final int maxCP;
  final String url;
  int amount;
  final int min = 3900;

  PokeDetail(
      {required this.name,
      required this.height,
      required this.weight,
      required this.hp,
      required this.attack,
      required this.defence,
      required this.maxCP,
      required this.url,
      required this.amount});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: min > maxCP? Colors.cyan: Colors.purpleAccent[100],
      appBar: AppBar(
        title: Text(
          name,
          style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold),
        ),
        centerTitle: true,
        elevation: 0,
        backgroundColor: min > maxCP? Colors.cyan: Colors.purpleAccent[100],
      ),
      body: Stack(
        children: [
          Positioned(
            height: MediaQuery.of(context).size.height / 1.3,
            width: MediaQuery.of(context).size.width - 20,
            left: 10,
            top: MediaQuery.of(context).size.height * 0.1,
            child: Card(
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  SizedBox(
                    height: 125,
                  ),
                  Text(
                    '$name x$amount',
                    style: TextStyle(fontSize: 25, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Characteristic:',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Height: $height',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Text(
                    'Weight: $weight',
                    style: TextStyle(fontWeight: FontWeight.bold),
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'HP:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FilterChip(
                        label: Text(
                          '$hp',
                          style: TextStyle(color: Colors.white),
                        ),
                        onSelected: (temp) {},
                        backgroundColor: Colors.lightGreen,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Attack:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FilterChip(
                        label: Text(
                          '$attack',
                          style: TextStyle(color: Colors.white),
                        ),
                        onSelected: (temp) {},
                        backgroundColor: Colors.redAccent,
                      ),
                    ],
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Text(
                        'Defense:',
                        style: TextStyle(fontWeight: FontWeight.bold),
                      ),
                      FilterChip(
                        label: Text(
                          '$defence',
                          style: TextStyle(color: Colors.white),
                        ),
                        onSelected: (temp) {},
                        backgroundColor: Colors.cyan,
                      ),
                    ],
                  ),
                  Text(
                    'MAX CP:',
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 20),
                  ),
                  FilterChip(
                    label: Text('$maxCP'),
                    onSelected: (temp) {},
                    backgroundColor: Colors.orangeAccent,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.topCenter,
            child: Hero(
              tag: url,
              child: Container(
                height: 200,
                width: 200,
                decoration: BoxDecoration(
                    image: DecorationImage(
                        image: AssetImage(url), fit: BoxFit.cover)),
              ),
            ),
          )
        ],
      ),
    );
  }
}
