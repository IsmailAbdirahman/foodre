import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodre/Model/FoodInfo.dart';

class DetailsFood extends StatefulWidget {
  final String foodInfo;

  DetailsFood({this.foodInfo});

  @override
  _DetailsFoodState createState() => _DetailsFoodState();
}

class _DetailsFoodState extends State<DetailsFood> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("foodRe"),
      ),
      body: Column(
        children: <Widget>[
          Expanded(
            child: Stack(
              children: <Widget>[
                Container(
                  height: MediaQuery.of(context).size.width,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(30.0),
                    boxShadow: [
                      BoxShadow(
                        color: Colors.black26,
                        offset: Offset(0.0, 2.0),
                        blurRadius: 6.0,
                      ),
                    ],
                  ),
                  child: Hero(
                    tag: widget.foodInfo.toString(),
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(30.0),
                      child: CachedNetworkImage(
                        imageUrl: widget.foodInfo,

                      ),
                    ),
                  ),
                ),
                Positioned(
                  bottom: 0,
                  left: 1,
                  right: 1,
                  child: Container(
                  //  margin: EdgeInsets.all(10),
                      height: 490,
                    //  width: 40,

                      child: Card(
                        color: Colors.grey[300],
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
                        ),
                        child: Padding(
                          padding: const EdgeInsets.all(18.0),
                          child: Text(
                            "HELLO ",
                            style: TextStyle(color: Colors.black),
                          ),
                        ),
                      )),
                )
              ],
            ),
          ),


        ],
      ),
    );
  }
}
