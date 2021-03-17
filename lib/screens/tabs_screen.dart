import 'package:flutter/material.dart';

import './categories_screen.dart';
import './favorites_screen.dart';
import '../models/meal.dart';
import '../widgets/main_drawer.dart';

class TabsScreen extends StatefulWidget {
  final List<Meal> _favoriteMeals;

  TabsScreen(this._favoriteMeals);

  @override
  _TabsScreenState createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  List<Map<String, Object>> _pages;
  var _loadedInitData = false;

  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    if (!_loadedInitData) {
      _pages = [
        {'page': CategoriesScreen(), 'title': 'Categories'},
        {
          'page': FavoritesScreen(widget._favoriteMeals),
          'title': 'Your Favorites'
        }
      ];
    }
  }

  @override
  Widget build(BuildContext context) {
    final _page = _pages[_selectedPageIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(_page['title']),
      ),
      drawer: MainDrawer(),
      body: _page['page'],
      bottomNavigationBar: BottomNavigationBar(
        onTap: _selectPage,
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).accentColor,
        currentIndex: _selectedPageIndex,
        items: [
          BottomNavigationBarItem(
              icon: Icon(Icons.category), label: 'Categories'),
          BottomNavigationBarItem(icon: Icon(Icons.star), label: 'Favorites'),
        ],
      ),
    );
  }
}
