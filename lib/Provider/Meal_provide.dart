import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_meal_generator/Models/Meal_model.dart';
import 'package:random_meal_generator/Repository/Meal_repository.dart';

final mealProvider = FutureProvider<MealModel>((ref){
  print("Calling provider");
  return MealRepository().getMeal();
});
