

class ExtendedIngredients{

  final String image;
  final String name;
  final double amount;
  final String unit;

  ExtendedIngredients({this.image,this.name,this.amount,this.unit});



  factory ExtendedIngredients.fromJson(Map<String, dynamic> parsedJson) {



    return ExtendedIngredients(
      image: parsedJson['image'],
      name: parsedJson['name'],
      amount: parsedJson['amount'],
      unit: parsedJson['unit'],
    );
  }
}



