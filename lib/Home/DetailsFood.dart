//import 'package:cached_network_image/cached_network_image.dart';
//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:foodre/Model/FoodInfo.dart';
//
//class DetailsFood extends StatefulWidget {
//  final FoodInformation foodInfo;
//
//  DetailsFood({this.foodInfo});
//
//  @override
//  _DetailsFoodState createState() => _DetailsFoodState();
//}
//
//class _DetailsFoodState extends State<DetailsFood> {
//  @override
//  Widget build(BuildContext context) {
//    return Scaffold(
//
//      body: Column(
//        children: <Widget>[
//          Expanded(
//            child: Stack(
//              children: <Widget>[
//                Container(
//                  height: MediaQuery.of(context).size.width,
//                  decoration: BoxDecoration(
//                    borderRadius: BorderRadius.circular(30.0),
//                    boxShadow: [
//                      BoxShadow(
//                        color: Colors.black26,
//                        offset: Offset(0.0, 2.0),
//                        blurRadius: 6.0,
//                      ),
//                    ],
//                  ),
//                  child: Hero(
//                    tag: widget.foodInfo.toString(),
//                    child: ClipRRect(
//                      borderRadius: BorderRadius.circular(30.0),
//                      child: CachedNetworkImage(
//                        imageUrl: widget.foodInfo.foodImageUrl,
//                        fit: BoxFit.cover,
//                      ),
//                    ),
//                  ),
//                ),
//                Positioned(
//                  bottom: 0,
//                  left: 1,
//                  right: 1,
//                  child: Container(
//                  //  margin: EdgeInsets.all(10),
//                      height: 490,
//                    //  width: 40,
//
//                      child: Card(
//                        color: Colors.grey[300],
//                        shape: RoundedRectangleBorder(
//                          borderRadius: BorderRadius.only(topRight: Radius.circular(30),topLeft: Radius.circular(30))
//                        ),
//                        child:widget.foodInfo.instructions!= null ?Text(widget.foodInfo.instructions):Text("Empty"),
//                      )),
//                )
//              ],
//            ),
//          ),
//
//
//        ],
//      ),
//    );
//  }
//}

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:foodre/Model/FoodInfo.dart';

class DetailScreen extends StatefulWidget {
  final PopularFoodModel foodInformation;

  // final bool inFavorites;

  DetailScreen({this.foodInformation});

  @override
  _DetailScreenState createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen>
    with SingleTickerProviderStateMixin {
  TabController _tabController;
  ScrollController _scrollController;
  bool _inFavorites;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
    _scrollController = ScrollController();
    // _inFavorites = widget.inFavorites;
  }

  @override
  void dispose() {
    // "Unmount" the controllers:
    _tabController.dispose();
    _scrollController.dispose();
    super.dispose();
  }

  void _toggleInFavorites() {
    setState(() {
      _inFavorites = !_inFavorites;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: NestedScrollView(
     //   controller: _scrollController,
        headerSliverBuilder: (BuildContext context, bool innerViewIsScrolled) {
          return <Widget>[
            SliverAppBar(
              backgroundColor: Colors.white,
              flexibleSpace: FlexibleSpaceBar(
              //  collapseMode: CollapseMode.parallax,
                background: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    CachedNetworkImage(
                      imageUrl: widget.foodInformation.foodImageUrl,
                      fit: BoxFit.cover,
                    )
                  ],
                ),
              ),
              expandedHeight: 290.0,
              pinned: false,
              floating: true,
              elevation: 0.0,
              forceElevated: innerViewIsScrolled,
              bottom: TabBar(
                tabs: <Widget>[
                  Text(
                    "Ingredient",
                    style: TextStyle(color: Colors.black),
                  ),
                  Text(
                    "Steps",
                    style: TextStyle(color: Colors.black),
                  )
                ],
                controller: _tabController,
              ),
            )
          ];
        },
        body: TabBarView(
          children: <Widget>[

                IngredientsView(widget.foodInformation),

            widget.foodInformation.steps != null? StepsView(widget.foodInformation.steps):Padding(
              padding: const EdgeInsets.all(12.0),
              child: Text("There is no stpes in this recipe."),
            )

          ],
          controller: _tabController,
        ),
      ),
//      floatingActionButton: FloatingActionButton(
//        onPressed: () {
//          updateFavorites(appState.user.uid, widget.foodInformation.id).then((result) {
//            // Toggle "in favorites" if the result was successful.
//            if (result) _toggleInFavorites();
//          });
//        },
//        child: Icon(
//          _inFavorites ? Icons.favorite : Icons.favorite_border,
//          color: Theme.of(context).iconTheme.color,
//        ),
//        elevation: 2.0,
//        backgroundColor: Colors.white,
//      ),
    );
  }
}

class IngredientsView extends StatelessWidget {
  final PopularFoodModel ingredients;

  IngredientsView(this.ingredients);

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
        itemCount: ingredients.extendedIngredients.length,
        itemBuilder: (BuildContext context, int index) {
          return Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: <Widget>[
              CachedNetworkImage(
                imageUrl:"https://spoonacular.com/cdn/ingredients_100x100/"+ingredients.extendedIngredients[index].image ,
              ),
              Text(ingredients.extendedIngredients[index].name,style: TextStyle(fontWeight: FontWeight.w500),),
              Text(
                  ingredients.extendedIngredients[index].amount.toString() +
                      " " +
                      ingredients.extendedIngredients[index].unit),
            ],
          );
        });
  }
}













class StepsView extends StatelessWidget {
  final String preparationSteps;

  StepsView(this.preparationSteps);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(17.0),
      child: Text(preparationSteps,style: TextStyle(fontSize: 16),),
    );
  }
}
