import 'package:flutter/material.dart';

import '../models/meal.dart';
import '../widgets/meal_item.dart';

class CategoryMealsScreen extends StatefulWidget {
  static const routeName = '/category-meals';

  final List<Meal> _availableMeals;

  CategoryMealsScreen(List<Meal> availableMeal)
      : _availableMeals = availableMeal;

  @override
  _CategoryMealsScreenState createState() => _CategoryMealsScreenState();
}

class _CategoryMealsScreenState extends State<CategoryMealsScreen> {
  String _categoryTitle;
  String _categoryId;
  List<Meal> _displayMeals;

  var _loadedInitData = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_loadedInitData) {
      final routeArgs =
          ModalRoute.of(context).settings.arguments as Map<String, String>;
      _categoryTitle = routeArgs['title'];
      _categoryId = routeArgs['id'];

      _displayMeals = widget._availableMeals.where((element) {
        return element.categories.contains(_categoryId);
      }).toList();
    }
  }

  void _removeMeal(mealId) {
    setState(() {
      _displayMeals.removeWhere((element) => element.id == mealId);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(title: Text(_categoryTitle)),
        body: ListView.builder(
          itemBuilder: (ctx, index) {
            Meal meal = _displayMeals[index];
            return MealItem(
              id: meal.id,
              title: meal.title,
              imageUrl: meal.imageUrl,
              duration: meal.duration,
              complexity: meal.complexity,
              affordability: meal.affordability
            );
          },
          itemCount: _displayMeals.length,
        ));
  }
}
