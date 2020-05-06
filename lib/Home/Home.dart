import 'package:flutter/cupertino.dart';
import 'package:foodre/Model/FoodInfo.dart';
import 'package:flutter/material.dart';
import 'package:foodre/Model/RecommendedModel.dart';
import 'package:foodre/Service/Service.dart';
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
  List<RecommendModel> recc = new List<RecommendModel>();

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
    fooddd = getRecipesId();
    getaData();
  }

  getaData() async {
    await getRecommendedRecipesInfo();
    recc = theRecommendedList;
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return SafeArea(
      child: Scaffold(
        backgroundColor: Color(0XFFFEFAE3),
        body: ListView(
          physics: ScrollPhysics(),
          scrollDirection: Axis.vertical,
          children: <Widget>[
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: _meals
                  .asMap()
                  .entries
                  .map((singleMeal) => _buildMeals(singleMeal.key))
                  .toList(),
            ),
            Container(
                margin: EdgeInsets.only(left: 23),
                child: Text(
                  "Recommaneded Food",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      wordSpacing: 5,
                      letterSpacing: 3,
                      fontSize: 17,
                      color: Colors.black),
                )),
          Container(
            height: SizeConfig.blockSizeVertical * 32,
            width: SizeConfig.blockSizeHorizontal *90,
            child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: recc.length,
                itemBuilder: (BuildContext context, int index) {
                  return SlideCard(recoModel: recc[index],);
                }),
          ),



            Container(
                margin: EdgeInsets.only(left: 23,top: 100),
                child: Text(
                  "Popular Food",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      wordSpacing: 5,
                      letterSpacing: 3,
                      fontSize: 17,
                      color: Colors.black),
                )),
            FutureBuilder<List<FoodInformation>>(
                future: fooddd,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    List<FoodInformation> foodInforamtion = snapshot.data;

                    return Container(
                      height: SizeConfig.blockSizeVertical * 2000,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          physics: FixedExtentScrollPhysics(),
                          itemCount: foodInforamtion.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PopularFood(foodInforamtion[index]);
                          }),
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                }),

          ],
        ),
      ),
    );
  }
}

class SlideCard extends StatelessWidget {
  final RecommendModel recoModel;

  SlideCard({this.recoModel});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
//      onTap: () async {
//        Navigator.push(
//            context,
//            MaterialPageRoute(
//                builder: (context) =>
//                    DetailScreen(foodInformation: foodInformation)));
//      },
      child: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(20),
              height: SizeConfig.blockSizeVertical * 24,
              width: SizeConfig.blockSizeHorizontal * 53,
              child: Hero(
                tag: recoModel.foodImageUrl,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      imageUrl: recoModel.foodImageUrl,
                      fit: BoxFit.cover,
                    )),
              )),
          Positioned(
            left: 10,
            bottom: -30.0,
            child: Container(
              height: SizeConfig.blockSizeVertical * 20,
              width: 230,
              child: Padding(
                padding: const EdgeInsets.all(28.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(recoModel.foodTitle,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 17)),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            recoModel.mints.toString() + " " + "mins",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Container(
                              height: 23,
                              child: VerticalDivider(
                                color: Colors.grey,
                                thickness: 1.0,
                              )),
                          Text(
                              recoModel.servings.toString() +
                                  " " +
                                  "servings",
                              style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

class PopularFood extends StatelessWidget {
  final FoodInformation foodInformation;

  PopularFood(this.foodInformation);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(foodInformation: foodInformation)));
      },
      child: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(20),
              height: SizeConfig.blockSizeVertical * 25,
              width: SizeConfig.blockSizeHorizontal * 45,
              child: Hero(
                tag: foodInformation.foodImageUrl,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: foodInformation.foodImageUrl,
                        fit: BoxFit.cover,
                      )),
                ),
              )),
          Positioned(
            left: 160,
            bottom: 40.0,
            child: Container(
              height: SizeConfig.blockSizeVertical * 20,
              width: 230,
              child: Padding(
                padding: const EdgeInsets.all(18.0),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 4,
                  child: Column(
                    children: <Widget>[
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text(foodInformation.foodTitle,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 17)),
                      ),
                      SizedBox(
                        height: 35.0,
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        // mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: <Widget>[
                          Padding(
                            padding: const EdgeInsets.only(left: 40),
                            child: Text(
                              foodInformation.mints.toString() + " " + "mins",
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
                              foodInformation.servings.toString() +
                                  " " +
                                  "servings",
                              style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}

//class SeeAll extends StatefulWidget {
//  final String name, image, desc, level, min;
//
//  SeeAll({
//    @required this.name,
//    @required this.image,
//    @required this.level,
//    @required this.desc,
//    @required this.min,
//  });
//
//  @override
//  _SeeAllState createState() => _SeeAllState();
//}
//
//class _SeeAllState extends State<SeeAll> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//      body: SizedBox(
//        height: MediaQuery.of(context).size.height,
//        child: Stack(
//          children: <Widget>[
//            Container(
//                margin: EdgeInsets.all(20),
//                height: 450,
//                width: 300,
//                child: ClipRRect(
//                    borderRadius: BorderRadius.circular(30),
//                    child: Image.asset(
//                      widget.image,
//                      fit: BoxFit.cover,
//                    ))),
//            Positioned(
//              left: 50,
//              bottom: 7.0,
//              child: Container(
//                height: 130,
//                width: 230,
//                child: Card(
//                  elevation: 4,
//                  child: Column(
//                    children: <Widget>[
//                      Text(widget.name,
//                          style: TextStyle(
//                              fontWeight: FontWeight.w800, fontSize: 17)),
//                      SizedBox(
//                        height: 2.0,
//                      ),
//                      Text(widget.desc,
//                          style: TextStyle(
//                              color: Colors.grey, fontWeight: FontWeight.w400)),
//                      SizedBox(
//                        height: 35.0,
//                      ),
//                      Row(
//                        // mainAxisAlignment: MainAxisAlignment.spaceEvenly,
//                        children: <Widget>[
//                          Padding(
//                            padding: const EdgeInsets.only(left: 70),
//                            child: Text(
//                              widget.min+"mins",
//                              style: TextStyle(fontWeight: FontWeight.w600),
//                            ),
//                          ),
//                          Container(
//                              height: 23,
//                              child: VerticalDivider(
//                                color: Colors.grey,
//                                thickness: 1.0,
//                              )),
//
//                        ],
//                      )
//                    ],
//                  ),
//                ),
//              ),
//            )
//          ],
//        ),
//      ),
//    );
//  }
//}
