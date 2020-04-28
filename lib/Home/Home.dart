import 'package:flutter/cupertino.dart';
import 'package:foodre/Model/ExtendedIngredients.dart';
import 'package:foodre/Model/FoodInfo.dart';
import 'package:flutter/material.dart';
import 'package:foodre/Service/Service.dart';
import 'dart:math' as math;
import 'package:cached_network_image/cached_network_image.dart';

import '../CoonfigScreen.dart';
import 'DetailsFood.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<String> _meals = ['Breakfast', 'Lunch', 'Dinner'];

  Future<List<FoodInformation>> fooddd;
  List<FoodInformation> theList = List<FoodInformation>();

  Widget _buildMeals(int index) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedIndex = index;
        });
      },
      child: Container(
        height: 30,
        width: 90,
        margin: EdgeInsets.only(top: 100),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10.0),
        ),
        child: Text(
          _meals[index],
          style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 17,
            color: _selectedIndex == index ? Colors.blue : Colors.grey,
          ),
        ),
      ),
    );
  }

  @override
  void initState() {
    super.initState();
    fooddd  = getRecipesId();
    getaData();
  }

  getaData() async {
    // await getRecipesId();
    // theList = theFoodListInfo;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: SizedBox(
        height: MediaQuery.of(context).size.height * 2.55,
        child: FutureBuilder<List<FoodInformation>>(
            future:fooddd,
            builder: (BuildContext context, snapshot) {
              if (snapshot.hasData ) {
                print("SNASHOT ${snapshot.data.length}");
                List<FoodInformation> foodInforamtion = snapshot.data;

                return Scaffold(
                  backgroundColor: Color(0XFFFEFAE3),
                  body: Column(
                    children: <Widget>[
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: _meals
                            .asMap()
                            .entries
                            .map(
                              (singleMeal) => _buildMeals(singleMeal.key),
                            )
                            .toList(),
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 350),
                        child: Text(
                          'See all',
                          style: TextStyle(
                              color: Colors.blue, fontWeight: FontWeight.w800),
                        ),
                      ),
                      Container(
                        height: SizeConfig.blockSizeVertical * 70,
                        child: ListView.builder(
                            scrollDirection: Axis.horizontal,
                            itemCount: foodInforamtion.length,
                            itemBuilder: (BuildContext context, int index) {
                              return SlideCard(
                                name: foodInforamtion[index].foodTitle,
                                desc: foodInforamtion[index].foodTitle,
                                image: foodInforamtion[index].foodImageUrl,
                                min: foodInforamtion[index].mints,
                              );
                            }),
                      ),
                    ],
                  ),
                );
              } else {
                return Center(child: CircularProgressIndicator());
              }
            }),
      ),
    );
  }
}

class SlideCard extends StatelessWidget {
  final String name, image, desc;
  final int min;

  SlideCard({
    @required this.name,
    @required this.image,
    @required this.desc,
    @required this.min,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
       Navigator.push(context, MaterialPageRoute(builder:(context)=> DetailsFood(foodInfo: image,)));
      },
      child: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(20),
              height: SizeConfig.blockSizeVertical * 45,
              width: 300,
              child: Hero(
                tag: image,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      imageUrl: image,
                      fit: BoxFit.cover,
                    )),
              )),
          Positioned(
            left: 50,
            bottom: 1.0,
            child: Container(
              height: SizeConfig.blockSizeVertical * 20,
              width: 230,
              child: Card(
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20)),
                elevation: 4,
                child: Column(
                  children: <Widget>[
                    Text(name,
                        style: TextStyle(
                            fontWeight: FontWeight.w800, fontSize: 17)),
                    SizedBox(
                      height: 2.0,
                    ),
                    Text(desc,
                        style: TextStyle(
                            color: Colors.grey, fontWeight: FontWeight.w400)),
                    SizedBox(
                      height: 35.0,
                    ),
                    Row(
                      // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.only(left: 70),
                          child: Text(
                            min.toString(),
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ),
                        Container(
                            height: 23,
                            child: VerticalDivider(
                              color: Colors.grey,
                              thickness: 1.0,
                            )),
                      ],
                    )
                  ],
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class SeeAll extends StatefulWidget {
  final String name, image, desc, level, min;

  SeeAll({
    @required this.name,
    @required this.image,
    @required this.level,
    @required this.desc,
    @required this.min,
  });

  @override
  _SeeAllState createState() => _SeeAllState();
}

class _SeeAllState extends State<SeeAll> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        height: MediaQuery.of(context).size.height,
        child: Stack(
          children: <Widget>[
            Container(
                margin: EdgeInsets.all(20),
                height: 450,
                width: 300,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: Image.asset(
                      widget.image,
                      fit: BoxFit.cover,
                    ))),
            Positioned(
              left: 50,
              bottom: 7.0,
              child: Container(
                height: 130,
                width: 230,
                child: Card(
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      Text(widget.name,
                          style: TextStyle(
                              fontWeight: FontWeight.w800, fontSize: 17)),
                      SizedBox(
                        height: 2.0,
                      ),
                      Text(widget.desc,
                          style: TextStyle(
                              color: Colors.grey, fontWeight: FontWeight.w400)),
                      SizedBox(
                        height: 35.0,
                      ),
                      Row(
                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 70),
                            child: Text(
                              widget.min,
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ),
                          Container(
                              height: 23,
                              child: VerticalDivider(
                                color: Colors.grey,
                                thickness: 1.0,
                              )),
                          Text(
                            widget.level,
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
