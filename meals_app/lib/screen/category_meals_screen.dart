import 'package:flutter/material.dart';
import 'package:meals_app/model/meal.dart';
import 'package:meals_app/widget/meals_item.dart';
import '../dummy_data.dart';

class CategoryMealScreen extends StatefulWidget {
  static const String routeName = '/category-meals';

  @override
  _categoryMealScreenState createState() => _categoryMealScreenState();
}

class _categoryMealScreenState extends State<CategoryMealScreen> {
  String? categoryTitle;
  List<Meal>? displayedMeal;
  var _isInitial = false;

  @override
  // initialize everything using initstate
  // initstate runs too early, thus cannot create route data
  void initState() {
    super.initState();
  }

  @override
  // run whenever the dependencies change, it will be triggered whenever the reference of the state changed not like initstate
  void didChangeDependencies() {
    if (!_isInitial) {
      final routeArgs =
          ModalRoute.of(context)!.settings.arguments as Map<String, String>;
      categoryTitle = routeArgs['title'];
      final categoryId = routeArgs['id'];
      // use this to create filtered list based on the categories
      displayedMeal = DUMMY_MEALS.where((meal) {
        return meal.categories.contains(categoryId);
      }).toList();
      _isInitial = true;
    }
    super.didChangeDependencies();
  }

  void _removeMeal(String mealId) {
    setState(() {
      displayedMeal!.removeWhere((meal) => meal.id == mealId);
      print('Meal ID: $mealId');
      print('true');
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle!),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealsItem(
            id: displayedMeal![index].id,
            title: displayedMeal![index].title,
            imageUrl: displayedMeal![index].imageUrl,
            duration: displayedMeal![index].duration,
            complexity: displayedMeal![index].complexity,
            affordability: displayedMeal![index].affordability,
            removeItem: _removeMeal,
          );
        },
        itemCount: displayedMeal!.length,
      ),
    );
  }
}
