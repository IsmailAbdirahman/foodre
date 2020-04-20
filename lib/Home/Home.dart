import 'package:flutter/cupertino.dart';
import 'package:foodre/Model/FoodInfo.dart';
import 'package:flutter/material.dart';
import 'dart:math' as math;


class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  Offset _offset = Offset(0.4, 0.7); // new

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.yellow[200],
      body: Container(
        margin: EdgeInsets.only(top: 245),
        child: ListView.builder(
            scrollDirection: Axis.horizontal,
            itemCount: listOfFood.length,
            itemBuilder: (BuildContext context, int index) {
              return Stack(
                children: <Widget>[
                  Container(
                    height: 300,
                    width: 300,
                    margin: EdgeInsets.all(20),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(10),
                        child: Image.asset(
                          listOfFood[index].foodImageUrl,
                          fit: BoxFit.cover,
                        )),
                  ),
                  Positioned(
                    left: 40,
                    bottom: 99,
                    child: Card(
                      child: Container(
                        height: 150,
                        width: 250,
                        child: Column(
                          children: <Widget>[
                            Text(listOfFood[index].foodName),
                            Text(listOfFood[index].level)
                          ],
                        ),
                      ),
                    ),
                  )
                ],
              );
            }),
      ),
    );
  }
}
