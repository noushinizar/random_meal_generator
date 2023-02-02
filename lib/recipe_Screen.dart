import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:random_meal_generator/Models/Meal_model.dart';
import 'package:random_meal_generator/Provider/Meal_provide.dart';
import 'package:random_meal_generator/utils.dart';
import 'package:url_launcher/url_launcher.dart';


class RecipeScreen extends ConsumerWidget {

  @override
  Widget build(BuildContext context,WidgetRef ref ) {
    final meal = ref.watch(mealProvider);
    return Scaffold(
      body:meal.when(
          error: (err,stack)=>Center(child: Text(err.toString()),)
          , loading: ()=>Center(child: CircularProgressIndicator(),
          ),
      data: (recipe){
            recipe.ingredients.removeWhere((element) => element.name == null || element.name == '');
            return SingleChildScrollView(
        child: Column(
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height * 0.45,
              decoration: BoxDecoration(
                image: DecorationImage(
                  image: NetworkImage(recipe.image),
                  fit: BoxFit.cover,
                ),
              ),
            ),
            Container(
              width:MediaQuery.of(context).size.width,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,

                  children: [
                    Text(recipe.name,
                      style: textStyle(35,Colors.black,FontWeight.w700),),
                    SizedBox(height: 2,),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Row(
                          children: [
                            Chip(
                              backgroundColor : Colors.yellowAccent,
                              label: Container(
                                  height: 25,
                                  child: Center(
                                    child: Text(recipe.Category,
                                      style: textStyle(20,Colors.black,FontWeight.w600),),)
                              ),
                            ),
                            SizedBox(width: 10,),
                            Chip(
                              backgroundColor : Colors.deepOrangeAccent,
                              label: Container(
                                  height: 25,
                                  child: Center(
                                    child: Text(recipe.area,
                                      style: textStyle(20,Colors.black,FontWeight.w600),),)
                              ),
                            ),
                          ],
                        ),

                        Container(
                          width: 155,
                          height: 35,
                          child: TextButton(
                              style: TextButton.styleFrom(
                                backgroundColor: Colors.redAccent,
                                shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(5)
                                ),
                              ),
                              onPressed: () async{
                              if(recipe.youtubeUrl != null &&
                              recipe.youtubeUrl != ''){
                                if(await canLaunch(recipe.youtubeUrl)){
                                  final bool nativeAppSuccedd =
                                      await launch(
                                        recipe.youtubeUrl,
                                        forceSafariVC: false,
                                        universalLinksOnly: true,
                                      );
                                  if(!nativeAppSuccedd){
                                    await launch(
                                      recipe.youtubeUrl,
                                      forceSafariVC: true,

                                    );
                                  }
                                }
                              }
                              },
                              child: Text("Youtube",
                                style: textStyle(18,Colors.white,FontWeight.w700),
                              )),
                        ),
                      ],
                    ),
                    SizedBox(height: 15,),
                    Text("Ingredients", style: textStyle(25,Colors.black,FontWeight.w600),
                    ),
                    SizedBox(height: 15,),
                    SingleChildScrollView(
                      scrollDirection: Axis.horizontal,
                      child: Row(
                        children: recipe.ingredients.map((Ingredient){
                          return  Padding(
                            padding: const EdgeInsets.only(right: 10.0,),
                            child: Column(
                              children: [
                                Image(
                                  width:100,
                                  height: 100,
                                  image: NetworkImage('http://www.themealdb.com/images/ingredients/${Ingredient.name}.png'),
                                  fit: BoxFit.cover,
                                ),
                                SizedBox(height: 10,),
                                Text(Ingredient.name,
                                  style: textStyle(20,Colors.black,FontWeight.w700),),
                                SizedBox(height: 7,),
                                Text(Ingredient.measure,
                                  style: textStyle(16,Colors.grey,FontWeight.w700),),
                              ],
                            ),
                          );
                        }).toList(),

                      ),
                    ),
                    SizedBox(height: 10,),
                    Text("Instruction",
                      style: textStyle(25,Colors.black,FontWeight.w600),),
                    SizedBox(height: 15,),
                    Text(recipe.instructions,
                      style: textStyle(18,Colors.black,FontWeight.w400),),

                  ],
                ),
              ),
            )
          ],
        ),
      );}
      ),


    );
  }
}
