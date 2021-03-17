import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FilterScreen extends StatefulWidget {
  static const routeName = '/filter';

  final Function saveFilters;
  final Map<String, bool> filters;

  FilterScreen(this.saveFilters, this.filters);

  @override
  _FilterScreenState createState() => _FilterScreenState();
}

class _FilterScreenState extends State<FilterScreen> {
  var _isGlutenFree = false;
  var _isVegan = false;
  var _isVegetarian = false;
  var _isLactoseFree = false;

  @override
  void initState() {
    super.initState();
    _isGlutenFree = widget.filters['gluten'];
    _isVegan = widget.filters['vegan'];
    _isVegetarian = widget.filters['vegetarian'];
    _isLactoseFree = widget.filters['lactose'];
  }

  Widget _buildSwitchListTile(String title, String description,
      bool currentValue, Function updateValue) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(description),
      onChanged: updateValue,
    );
  }

  Map<String, bool> get filterSettings {
    return {
      'gluten': _isGlutenFree,
      'lactose': _isLactoseFree,
      'vegan': _isVegan,
      'vegetarian': _isVegetarian
    };
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Filter'),
        actions: [
          IconButton(
              icon: Icon(Icons.save),
              onPressed: () => widget.saveFilters(filterSettings))
        ],
      ),
      drawer: MainDrawer(),
      body: Column(children: [
        Container(
            padding: EdgeInsets.all(20),
            child: Text(
              'Adjust your meal selection',
              style: Theme.of(context).textTheme.headline6,
            )),
        Expanded(
            child: ListView(children: [
          _buildSwitchListTile(
              'Gluten-free',
              'Only include gluten-free meals',
              _isGlutenFree,
              (newValue) => setState(() {
                    _isGlutenFree = newValue;
                  })),
          _buildSwitchListTile(
              'Lactose-free',
              'Only include lactose-free meals',
              _isLactoseFree,
              (newValue) => setState(() {
                    _isLactoseFree = newValue;
                  })),
          _buildSwitchListTile(
              'Vegetarian',
              'Only include vegetarian meals',
              _isVegetarian,
              (newValue) => setState(() {
                    _isVegetarian = newValue;
                  })),
          _buildSwitchListTile(
              'Vegan',
              'Only include vegan meals',
              _isVegan,
              (newValue) => setState(() {
                    _isVegan = newValue;
                  })),
        ]))
      ]),
    );
  }
}
