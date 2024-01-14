import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/drawer.dart';

const Map<Filters, bool> kInitialFiters = {
  Filters.glutenFree: false,
  Filters.lactoseFree: false,
  Filters.vegan: false,
  Filters.vegetarian: false
};

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Meal> _favouriteMeals = [];
  Map<Filters, bool> filters = kInitialFiters;
  String appBarTitle = 'Pick your Categories';
  int _currentPageIndex = 0;
  void _onTabChange(int index) {
    setState(() {
      _currentPageIndex = index;
      appBarTitle =
          _currentPageIndex == 0 ? 'Pick your Categories' : 'Favourite';
    });
  }

  void _snackBar(bool isFavourite) {
    String snackBarMsg =
        isFavourite ? "Meal added in Favourite" : "Meal removed from Favourite";
    ScaffoldMessenger.of(context).clearSnackBars();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(snackBarMsg),
        duration: const Duration(seconds: 1),
      ),
    );
  }

  void onFavouriteToggle(Meal meal) {
    if (_favouriteMeals.contains(meal)) {
      _snackBar(false);
      setState(() {
        _favouriteMeals.remove(meal);
      });
    } else {
      _snackBar(true);
      setState(() {
        _favouriteMeals.add(meal);
      });
    }
  }

  void onDrawerListTap(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      final returnedFilters = await Navigator.push<Map<Filters, bool>>(
        context,
        MaterialPageRoute(
          builder: (context) => FiltersScreen(
            filters: filters,
          ),
        ),
      );
      setState(() {
        filters = returnedFilters ?? kInitialFiters;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Widget content;
    if (_currentPageIndex == 0) {
      content = CategoriesScreen(
        onFavouriteToggle: onFavouriteToggle,
        filter: filters,
      );
    } else {
      content = MealsScreen(
          meals: _favouriteMeals, onFavouriteToggle: onFavouriteToggle);
    }
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
      ),
      drawer: MainDrawer(onDrawerListTap: onDrawerListTap),
      body: content,
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) => _onTabChange(index),
        currentIndex: _currentPageIndex,
        items: const [
          BottomNavigationBarItem(
              icon: Icon(Icons.ac_unit_rounded), label: "Categories"),
          BottomNavigationBarItem(
              icon: Icon(Icons.favorite), label: "Favourite"),
        ],
      ),
    );
  }
}
