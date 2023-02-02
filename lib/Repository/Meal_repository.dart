import 'dart:convert';

import 'package:random_meal_generator/Models/Meal_model.dart';
import 'package:http/http.dart' as http;

class MealRepository{
  Future<MealModel> getMeal() async {
    String url = "https://www.themealdb.com/api/json/v1/1/random.php";
    Uri uri = Uri.parse(url);
    http.Response response = await http.get(uri);
    return MealModel.fromjson(jsonDecode(response.body));
  }
}