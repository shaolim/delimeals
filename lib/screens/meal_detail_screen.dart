import 'package:flutter/material.dart';

import '../dummy_data.dart';

class MealDetailScreen extends StatelessWidget {
  static final routeName = '/meal-detail';

  final Function _favoriteToggle;
  final Function _isFavorite;

  MealDetailScreen(this._favoriteToggle, this._isFavorite);

  Widget _buildSectionTitle(BuildContext context, String title) {
    return Container(
        margin: EdgeInsets.symmetric(vertical: 10),
        child: Text(title, style: Theme.of(context).textTheme.headline6));
  }

  Widget _buildListContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
          color: Colors.white,
          border: Border.all(color: Colors.grey),
          borderRadius: BorderRadius.circular(10)),
      height: 200,
      width: 300,
      child: child,
    );
  }

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context).settings.arguments as String;
    final meal = DUMMY_MEALS.firstWhere((element) => element.id == mealId);
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.title),
      ),
      body: SingleChildScrollView(
          child: Column(
        children: [
          Container(
              height: 300,
              width: double.infinity,
              child: Image.network(
                meal.imageUrl,
                fit: BoxFit.cover,
              )),
          _buildSectionTitle(context, 'Ingredients'),
          _buildListContainer(ListView.builder(
            itemCount: meal.ingredients.length,
            itemBuilder: (ctx, index) => Card(
              color: Theme.of(context).accentColor,
              child: Padding(
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
                child: Text(meal.ingredients[index]),
              ),
            ),
          )),
          _buildSectionTitle(context, 'Steps'),
          _buildListContainer(ListView.builder(
            itemCount: meal.steps.length,
            itemBuilder: (ctx, index) => Column(
              children: [
                ListTile(
                    leading: CircleAvatar(child: Text('# ${index + 1}')),
                    title: Text(meal.steps[index])),
                Divider()
              ],
            ),
          ))
        ],
      )),
      floatingActionButton: FloatingActionButton(
        onPressed: () => _favoriteToggle(mealId),
        child: Icon(_isFavorite(mealId) ? Icons.star : Icons.star_border),
      ),
    );
  }
}
