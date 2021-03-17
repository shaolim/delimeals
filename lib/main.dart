import 'package:flutter/material.dart';

import './dummy_data.dart';
import './models/meal.dart';
import './screens/category_meals_screen.dart';
import './screens/filter_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/tabs_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false
  };

  List<Meal> _avaliableMeals = DUMMY_MEALS;
  List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filterData) {
    setState(() {
      _filters = filterData;

      _avaliableMeals = DUMMY_MEALS.where((element) {
        if (!element.isGlutenFree && _filters['gluten']) {
          return false;
        }

        if (!element.isLactoseFree && _filters['lactose']) {
          return false;
        }

        if (!element.isVegan && _filters['vegan']) {
          return false;
        }

        if (!element.isVegetarian && _filters['vegetarian']) {
          return false;
        }

        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((element) => element.id == mealId);
    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        final meal = DUMMY_MEALS.firstWhere((element) => element.id == mealId);
        _favoriteMeals.add(meal);
      });
    }
  }

  bool _isFavorite(String mealId) {
    return _favoriteMeals.any((element) => element.id == mealId);
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'DeliMeals',
        theme: ThemeData(
            primarySwatch: Colors.pink,
            accentColor: Colors.amber,
            canvasColor: Color.fromRGBO(255, 254, 229, 1),
            fontFamily: 'Raleway',
            textTheme: ThemeData.light().textTheme.copyWith(
                bodyText1: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                bodyText2: TextStyle(color: Color.fromRGBO(20, 51, 51, 1)),
                headline6: TextStyle(
                    fontSize: 20,
                    fontFamily: 'RobotoCondensed',
                    fontWeight: FontWeight.bold))),
        initialRoute: '/',
        routes: {
          '/': (ctx) => TabsScreen(_favoriteMeals),
          CategoryMealsScreen.routeName: (ctx) =>
              CategoryMealsScreen(_avaliableMeals),
          MealDetailScreen.routeName: (ctx) => MealDetailScreen(_toggleFavorite, _isFavorite),
          FilterScreen.routeName: (ctx) => FilterScreen(_setFilters, _filters)
        });
  }
}
