import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/favourites_provider.dart';
import 'package:meals_app/providers/filters_providers.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/filters_screen.dart';
import 'package:meals_app/screens/meals_screen.dart';
import 'package:meals_app/widgets/drawer.dart';

class HomeScreen extends ConsumerStatefulWidget {
  const HomeScreen({super.key});

  @override
  ConsumerState<HomeScreen> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends ConsumerState<HomeScreen> {
  String appBarTitle = 'Pick your Categories';
  int _currentPageIndex = 0;
  void _onTabChange(int index) {
    setState(() {
      _currentPageIndex = index;
      appBarTitle =
          _currentPageIndex == 0 ? 'Pick your Categories' : 'Favourite';
    });
  }

  void onDrawerListTap(String identifier) async {
    Navigator.of(context).pop();
    if (identifier == 'filters') {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => const FiltersScreen(),
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final availableMeals = ref.watch(filteredMealsProvider);
    final favouriteMeals = ref.watch(favouriteMealsProvider);
    Widget content;
    if (_currentPageIndex == 0) {
      content = CategoriesScreen(
        meals: availableMeals,
      );
    } else {
      content = MealsScreen(meals: favouriteMeals);
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
