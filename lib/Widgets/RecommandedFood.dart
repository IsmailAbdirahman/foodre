//import 'package:flutter/cupertino.dart';
//import 'package:flutter/material.dart';
//import 'package:foodre/Home/Home.dart';
//import 'package:foodre/Model/FoodInfo.dart';
//import 'package:foodre/Service/Service.dart';
//
//class RecommendedFoodWidget extends StatefulWidget {
//  @override
//  _RecommendedFoodWidgetState createState() => _RecommendedFoodWidgetState();
//}
//
//class _RecommendedFoodWidgetState extends State<RecommendedFoodWidget> {
//  @override
//  Widget build(BuildContext context) {
//    return Container(
//        height: 275,
//        width: double.infinity,
//        child: Expanded(
//          child: RecommendedFood(),
//        ));
//  }
//}
//
//class RecommendedFood extends StatefulWidget {
//  @override
//  _RecommendedFoodState createState() => _RecommendedFoodState();
//}
//
//class _RecommendedFoodState extends State<RecommendedFood> {
//  Future<List<FoodInformation>> fooddd;
//
//  @override
//  void initState() {
//    super.initState();
//    fooddd = getRecipesId();
//
//  }
//  @override
//  Widget build(BuildContext context) {
//    return FutureBuilder<List<FoodInformation>>(
//        future: fooddd,
//        builder: (BuildContext context, snapshot) {
//          if (snapshot.hasData) {
//            print("SNASHOT ${snapshot.data.length}");
//            List<FoodInformation> foodInforamtion = snapshot.data;
//
//            return ListView.builder(
//                scrollDirection: Axis.horizontal,
//                itemCount: foodInforamtion.length,
//                itemBuilder: (BuildContext context, int index) {
//                  return SlideCard(foodInforamtion[index]);
//                });
//          } else {
//            return CircularProgressIndicator();
//          }
//        });
//  }
//}
