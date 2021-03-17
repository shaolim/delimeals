import 'package:flutter/material.dart';

import '../screens/filter_screen.dart';

class MainDrawer extends StatelessWidget {
  Widget _buildListTile(String title, IconData icon, Function callback) {
    return ListTile(
      leading: Icon(
        icon,
        size: 24,
      ),
      title: Text(
        title,
        style: TextStyle(
            fontFamily: 'RobotoCondensed',
            fontSize: 20,
            fontWeight: FontWeight.bold),
      ),
      onTap: callback,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(children: [
        Container(
            height: 120,
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.centerLeft,
            color: Theme.of(context).accentColor,
            child: Text(
              'Cooking Up!',
              style: TextStyle(
                  fontWeight: FontWeight.w900,
                  fontSize: 20,
                  color: Theme.of(context).primaryColor),
            )),
        SizedBox(
          height: 20,
        ),
        _buildListTile('Meal', Icons.restaurant,
            () => Navigator.of(context).pushReplacementNamed('/')),
        _buildListTile(
            'Filters',
            Icons.settings,
            () => Navigator.of(context)
                .pushReplacementNamed(FilterScreen.routeName)),
      ]),
    );
  }
}
