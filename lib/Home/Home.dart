import 'package:flutter/cupertino.dart';
import 'package:foodre/AppState/AppState.dart';
import 'package:foodre/Model/FoodInfo.dart';
import 'package:flutter/material.dart';
import 'package:foodre/Model/RecommendedModel.dart';
import 'package:foodre/Service/Service.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../CoonfigScreen.dart';
import 'DetailsFood.dart';

class Home extends StatefulWidget {
  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int _selectedIndex = 0;
  List<String> _meals = ['Breakfast', 'Lunch', 'Dinner'];

  Future<List<PopularFoodModel>> popularListFromService;
  Future<List<RecommendModel>> recommendListFromService;

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
    popularListFromService = getRecipesId();
    recommendListFromService = getRecommendedRecipesInfo();
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
              width: SizeConfig.blockSizeHorizontal * 90,
              child: FutureBuilder<List<RecommendModel>>(
                future: recommendListFromService,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    List<RecommendModel> recommendModelSnapshot = snapshot.data;
                    return ListView.builder(
                        scrollDirection: Axis.horizontal,
                        shrinkWrap: true,
                        itemCount: recommendModelSnapshot.length,
                        itemBuilder: (BuildContext context, int index) {
                          return RecommendCard(
                            recommendModel: recommendModelSnapshot[index],
                          );
                        });
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Container(
                margin: EdgeInsets.only(left: 23, top: 100),
                child: Text(
                  "Popular Food",
                  style: TextStyle(
                      fontWeight: FontWeight.w800,
                      wordSpacing: 5,
                      letterSpacing: 3,
                      fontSize: 17,
                      color: Colors.black),
                )),
            FutureBuilder<List<PopularFoodModel>>(
                future: popularListFromService,
                builder: (BuildContext context, snapshot) {
                  if (snapshot.hasData) {
                    List<PopularFoodModel> foodInfoSnapshot = snapshot.data;

                    return Container(
                      height: SizeConfig.blockSizeVertical * 2000,
                      child: ListView.builder(
                          scrollDirection: Axis.vertical,
                          shrinkWrap: true,
                          itemCount: foodInfoSnapshot.length,
                          itemBuilder: (BuildContext context, int index) {
                            return PopularCard(foodInfoSnapshot[index]);
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

class RecommendCard extends StatelessWidget {
  final RecommendModel recommendModel;

  RecommendCard({this.recommendModel});

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
                tag: recommendModel.foodImageUrl,
                child: ClipRRect(
                    borderRadius: BorderRadius.circular(30),
                    child: CachedNetworkImage(
                      imageUrl: recommendModel.foodImageUrl,
                      fit: BoxFit.cover,
                    )),
              )),
          Positioned(
            left: 10,
            bottom: -30.0,
            child: Container(
              height: SizeConfig.blockSizeVertical * 22,
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
                        padding: const EdgeInsets.all(10.0),
                        child: Text(recommendModel.foodTitle,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 17)),
                      ),
                      SizedBox(
                        height: 10.0,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 10, right: 10),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Text(
                              recommendModel.mints.toString() + " " + "mins",
                              style: TextStyle(fontWeight: FontWeight.w600),
                            ),
                            Container(
                                height: 23,
                                child: VerticalDivider(
                                  color: Colors.grey,
                                  thickness: 1.0,
                                )),
                            Text(
                                recommendModel.servings.toString() +
                                    " " +
                                    "servings",
                                style: TextStyle(fontWeight: FontWeight.w600))
                          ],
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
              left: 155,
              top: 115,
              child: IconButton(
                icon: Icon(
                  Icons.favorite_border,
                  color: Colors.redAccent,
                  size: 30,
                ),
                onPressed: () {},
              )),
        ],
      ),
    );
  }
}

class PopularCard extends StatefulWidget {
  final PopularFoodModel foodInformation;

  PopularCard(this.foodInformation);

  @override
  _PopularCardState createState() => _PopularCardState();
}
class _PopularCardState extends State<PopularCard> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);




    return GestureDetector(
      onTap: () async {
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    DetailScreen(foodInformation: widget.foodInformation)));
      },
      child: Stack(
        children: <Widget>[
          Container(
              margin: EdgeInsets.all(20),
              height: SizeConfig.blockSizeVertical * 25,
              width: SizeConfig.blockSizeHorizontal * 45,
              child: Hero(
                tag: widget.foodInformation.foodImageUrl,
                child: Padding(
                  padding:
                      const EdgeInsets.only(top: 20, bottom: 20, right: 20),
                  child: ClipRRect(
                      borderRadius: BorderRadius.circular(30),
                      child: CachedNetworkImage(
                        imageUrl: widget.foodInformation.foodImageUrl,
                        fit: BoxFit.cover,
                      )),
                ),
              )),
          Positioned(
            left: 160,
            bottom: 40.0,
            child: Container(
              height: SizeConfig.blockSizeVertical * 21,
              width: 230,
              child: Padding(
                padding: const EdgeInsets.only(left: 10, right: 10),
                child: Card(
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20)),
                  elevation: 14,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: <Widget>[
                      Padding(
                        padding:
                            const EdgeInsets.only(top: 5, left: 10, right: 10),
                        child: Text(widget.foodInformation.foodTitle,
                            overflow: TextOverflow.ellipsis,
                            style: TextStyle(
                                fontWeight: FontWeight.w800, fontSize: 17)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          Text(
                            widget.foodInformation.mints.toString() +
                                " " +
                                "mins",
                            style: TextStyle(fontWeight: FontWeight.w600),
                          ),
                          Container(
                              height: 23,
                              child: VerticalDivider(
                                color: Colors.grey,
                                thickness: 1.0,
                              )),
                          Text(
                              widget.foodInformation.servings.toString() +
                                  " " +
                                  "servings",
                              style: TextStyle(fontWeight: FontWeight.w600))
                        ],
                      ),
                    ],
                  ),
                ),
              ),
            ),
          ),
          Positioned(
            left: 323,
            top: 160,
            child: Container(
              decoration: BoxDecoration(
                  color: Colors.white, borderRadius: BorderRadius.circular(50)),
              child: IconButton(
                icon: Icon(

                  appState.getDataFromHive(foodId: widget.foodInformation.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.redAccent,
                  size: 30,
                ),
                onPressed: () {
                  setState(() {
                    appState.saveDataIntoHive(widget.foodInformation.id.toString());
                  });

                },
              ),
            ),
          ),
        ],
      ),
    );
  }


//  check(String id) async {
//    await _sharedPrefs.getTheID();
//    if (_sharedPrefs.gotIds == null) {
//      _savedConverted.add(id);
//      _sharedPrefs.saveTheId(_savedConverted);
//    }
//    final isAlreadySaved = _sharedPrefs.gotIds.contains(id);
//    setState(() {
//      if (!isAlreadySaved) {
//        print("Its $isAlreadySaved so i added");
//        _savedConverted.add(id);
//        _sharedPrefs.saveTheId(_savedConverted);
//      } else {
//        print("Its $isAlreadySaved so i removed");
//        _savedConverted = _sharedPrefs.gotIds;
//        _savedConverted.remove(id);
//        _sharedPrefs.saveTheId(_savedConverted);
//      }
//    });
//  }
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
