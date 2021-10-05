import 'package:flutter/material.dart';
import 'poke_detail.dart';
import 'dart:convert';
import 'package:audioplayers/audioplayers.dart';

class CardStyle extends StatelessWidget {
  final String name, url;
  final int color;
  final double height;
  final double weight;
  final int hp;
  final int attack;
  final int defence;
  final int maxCP;
  int amount = 1;
  final int min = 3900;

  void increaseAmount() {
    amount++;
  }

  CardStyle(
      {required this.name,
      required this.url,
      required this.color,
      required this.height,
      required this.weight,
      required this.hp,
      required this.attack,
      required this.defence,
      required this.maxCP,});

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
        final player = AudioCache();
        player.play('tap.wav');
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => PokeDetail(
                      name: name,
                      height: height,
                      weight: weight,
                      hp: hp,
                      attack: attack,
                      defence: defence,
                      maxCP: maxCP,
                      url: url,
                      amount: amount,
                    )));
      },
      child: Hero(
        tag: url,
        child: Card(
          elevation: 7,
          color: min > maxCP? Colors.white: Colors.purpleAccent[100],
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: [
              Container(
                height: 125,
                width: 125,
                decoration: BoxDecoration(
                  image: DecorationImage(
                    image: AssetImage(url),
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              Text(
                name,
                style: TextStyle(
                  color: Color(color),
                  fontWeight: FontWeight.bold,
                  fontSize: 20,
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
  factory CardStyle.fromJson(Map<String, dynamic> jsonData) {
    return CardStyle(
      name: jsonData['name'],
      height: jsonData['height'],
      weight: jsonData['weight'],
      hp: jsonData['hp'],
      attack: jsonData['attack'],
      defence: jsonData['defence'],
      maxCP: jsonData['maxCP'],
      url: jsonData['url'],
      color: jsonData['color'],
    );
  }

  static Map<String, dynamic> toMap(CardStyle card) => {
    'name': card.name,
    'height': card.height,
    'weight': card.weight,
    'hp': card.hp,
    'attack': card.attack,
    'defence': card.defence,
    'maxCP': card.maxCP,
    'url': card.url,
    'color': card.color,
  };
  static String encode(List<CardStyle> musics) => json.encode(
    musics
        .map<Map<String, dynamic>>((music) => CardStyle.toMap(music))
        .toList(),
  );

  static List<CardStyle> decode(String musics) =>
      (json.decode(musics) as List<dynamic>)
          .map<CardStyle>((item) => CardStyle.fromJson(item))
          .toList();
}
