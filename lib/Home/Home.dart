import 'package:flutter/cupertino.dart';
import 'package:foodre/AppState/AppState.dart';
import 'package:flutter/material.dart';
import 'package:foodre/Model/PopularFoodModel.dart';
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

  Future<List<PopularFoodModel>>? popularListFromService;
  Future<List<RecommendModel>>? recommendListFromService;

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
          children: <Widget>[
            letsCookWidget(),
            recommendedHeaderWidget(),
            recommendedListWidget(),
            popularHeaderWidget(),
            popularListWidget(),
          ],
        ),
      ),
    );
  }

  Widget letsCookWidget(){
    return Container(
      height: 70,
      margin: const EdgeInsets.only(top: 40, left: 23),
      child: Text(
        "Lets cOOk",
        style: TextStyle(
            fontWeight: FontWeight.w900,
            fontSize: 27,
            letterSpacing: 2.5),
      ),
    );
  }
  Widget recommendedHeaderWidget() {
    return Container(
        margin: EdgeInsets.only(left: 23),
        child: Text(
          "Recommended Food",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              wordSpacing: 5,
              letterSpacing: 3,
              fontSize: 17,
              color: Colors.black),
        ));
  }

  Widget recommendedListWidget() {
    return Container(
      height: SizeConfig.blockSizeVertical! * 32,
      width: SizeConfig.blockSizeHorizontal! * 90,
      child: FutureBuilder<List<RecommendModel>>(
        future: recommendListFromService,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<RecommendModel> recommendModelSnapshot = snapshot.data!;
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
    );
  }

  Widget popularHeaderWidget() {
    return Container(
        margin: EdgeInsets.only(left: 23, top: 100),
        child: Text(
          "Popular Food",
          style: TextStyle(
              fontWeight: FontWeight.w800,
              wordSpacing: 5,
              letterSpacing: 3,
              fontSize: 17,
              color: Colors.black),
        ));
  }

  //FutureBuilder  for popular list is called here
  Widget popularListWidget() {
    return FutureBuilder<List<PopularFoodModel>>(
        future: popularListFromService,
        builder: (BuildContext context, snapshot) {
          if (snapshot.hasData) {
            List<PopularFoodModel> foodInfoSnapshot = snapshot.data!;

            return Container(
              height: SizeConfig.blockSizeVertical! * 2000,
              child: ListView.builder(
                  scrollDirection: Axis.vertical,
                  physics: NeverScrollableScrollPhysics(),
                  itemCount: foodInfoSnapshot.length,
                  itemBuilder: (BuildContext context, int index) {
                    return PopularCard(foodInfoSnapshot[index]);
                  }),
            );
          } else {
            return Center(child: CircularProgressIndicator());
          }
        });
  }
}

class RecommendCard extends StatelessWidget {
  final RecommendModel? recommendModel;

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
          recommendedImagesWidget(),
          cardOfRecommendedListWidget(),
          favButtonOfRecommendedWidget(),
        ],
      ),
    );
  }

  Widget cardOfRecommendedListWidget() {
    return Positioned(
      left: 10,
      bottom: -30.0,
      child: Container(
        height: SizeConfig.blockSizeVertical! * 22,
        width: 230,
        child: Padding(
          padding: const EdgeInsets.all(28.0),
          child: Card(
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
            elevation: 4,
            child: Column(
              children: <Widget>[
                recommendedTitlesWidget(),
                SizedBox(
                  height: 10.0,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 10, right: 10),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: <Widget>[
                      recommendedMinitsWidget(),
                      dividerWidget(),
                      recommendedServingWidget(),
                    ],
                  ),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget recommendedImagesWidget() {
    return Container(
        margin: EdgeInsets.all(20),
        height: SizeConfig.blockSizeVertical! * 24,
        width: SizeConfig.blockSizeHorizontal! * 53,
        child: Hero(
          tag: recommendModel!.image!,
          child: ClipRRect(
              borderRadius: BorderRadius.circular(30),
              child: CachedNetworkImage(
                imageUrl: recommendModel!.image!,
                fit: BoxFit.cover,
              )),
        ));
  }

  Widget recommendedTitlesWidget() {
    return Padding(
      padding: const EdgeInsets.all(10.0),
      child: Text(recommendModel!.title!,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
    );
  }

  Widget recommendedMinitsWidget() {
    return Text(
      recommendModel!.readyInMinutes.toString() + " " + "mins",
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }

  Widget dividerWidget() {
    return Container(
        height: 23,
        child: VerticalDivider(
          color: Colors.grey,
          thickness: 1.0,
        ));
  }

  Widget recommendedServingWidget() {
    return Text(recommendModel!.servings.toString() + " " + "servings",
        style: TextStyle(fontWeight: FontWeight.w600));
  }

  Widget favButtonOfRecommendedWidget() {
    return Positioned(
        left: 155,
        top: 115,
        child: IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.redAccent,
            size: 30,
          ),
          onPressed: () {},
        ));
  }
}

class PopularCard extends StatelessWidget {
  final PopularFoodModel foodInformation;

  PopularCard(this.foodInformation);

  @override
  Widget build(BuildContext context) {
    final appState = Provider.of<AppState>(context);

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
          popularImagesWidget(),
          Positioned(
            left: 160,
            bottom: 40.0,
            child: Container(
              height: SizeConfig.blockSizeVertical! * 21,
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
                      popularTitlesWidget(),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: <Widget>[
                          popularMinitsWidget(),
                          dividerWidget(),
                          popularServingWidget(),
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
                  appState.getDataFromHive(foodId: foodInformation.id)
                      ? Icons.favorite
                      : Icons.favorite_border,
                  color: Colors.redAccent,
                  size: 30,
                ),
                onPressed: () {
                  appState.saveDataIntoHive(foodInformation.id.toString());
                },
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget popularImagesWidget() {
    return Container(
        margin: EdgeInsets.all(20),
        height: SizeConfig.blockSizeVertical! * 25,
        width: SizeConfig.blockSizeHorizontal! * 45,
        child: Hero(
          tag: foodInformation.image!,
          child: Padding(
            padding: const EdgeInsets.only(top: 20, bottom: 20, right: 20),
            child: ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: CachedNetworkImage(
                  imageUrl: foodInformation.image!,
                  fit: BoxFit.cover,
                )),
          ),
        ));
  }

  Widget popularTitlesWidget() {
    return Padding(
      padding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      child: Text(foodInformation.title!,
          overflow: TextOverflow.ellipsis,
          style: TextStyle(fontWeight: FontWeight.w800, fontSize: 17)),
    );
  }

  Widget popularMinitsWidget() {
    return Text(
      foodInformation.readyInMinutes.toString() + " " + "mins",
      style: TextStyle(fontWeight: FontWeight.w600),
    );
  }

  Widget popularServingWidget() {
    return Text(foodInformation.servings.toString() + " " + "servings",
        style: TextStyle(fontWeight: FontWeight.w600));
  }

  Widget dividerWidget() {
    return Container(
        height: 23,
        child: VerticalDivider(
          color: Colors.grey,
          thickness: 1.0,
        ));
  }

 // Widget favButtonOfpopularWidget() {}


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
