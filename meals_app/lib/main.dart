import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:meals_app/screen/filters_screen.dart';
import 'package:meals_app/screen/meal_detail_screen.dart';
import 'package:meals_app/screen/tabs_screen.dart';
import '../screen/categories_screen.dart';
import '../screen/category_meals_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Delimeals',
      theme: ThemeData(
        primarySwatch: Colors.blue,
        accentColor: Colors.indigo,
        canvasColor: Color.fromRGBO(255, 254, 229, 1),
        fontFamily: 'Raleway',
        textTheme: ThemeData.light().textTheme.copyWith(
              body1: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              body2: TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              title: TextStyle(
                fontFamily: 'RobotoCondensed',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
      ),
      // home: CategoriesScreen(),
      routes: {
        '/': (ctx) => TabsScreen(),
        CategoryMealScreen.routeName: (ctx) => CategoryMealScreen(),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(),
        FiltersScreen.routeName: (ctx) => FiltersScreen(),
      },
      // use onGenerateRoute if the app can't find any named route (could come in handy when you build dynamic link applications)
      onGenerateRoute: (settings) {
        print(settings.arguments);
      },
      // use onUnknownRoute as the last resource if the app can't find any named route and onGenerateRoute doesn't exist
      onUnknownRoute: (settings) {
        return MaterialPageRoute(builder: (ctx) => CategoriesScreen());
      },
    );
  }
}
