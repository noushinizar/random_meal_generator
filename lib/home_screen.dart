import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_meal_generator/Provider/Meal_provide.dart';
import 'package:random_meal_generator/recipe_Screen.dart';
import 'package:random_meal_generator/utils.dart';
class HomeScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context,WidgetRef ref ) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          image: DecorationImage(image: AssetImage('images/background.jpg'),fit: BoxFit.cover)
        ),
        child: Center(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 30),
            height: MediaQuery.of(context).size.height * 0.45,
            decoration: BoxDecoration(
              color: Colors.white.withOpacity(0.5),
            ),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Feeling hungry?",
                style:textStyle(30,Colors.black,FontWeight.w700),
                ),
                SizedBox(height: 25,),
                TextButton(
                    style: TextButton.styleFrom(
                      backgroundColor: Colors.deepOrangeAccent
                    ),
                    onPressed: (){
                     ref.refresh(mealProvider);
                      Navigator.push(context, MaterialPageRoute(builder: (context)=>RecipeScreen()));
                    },
                    child: Text("Show a recipe", style:textStyle(22,Colors.black,FontWeight.w600),))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
