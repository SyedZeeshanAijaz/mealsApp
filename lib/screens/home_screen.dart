import 'package:flutter/material.dart';
import 'package:meals_app/screens/categories.dart';
import 'package:meals_app/screens/meals_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<StatefulWidget> createState() {
    return _HomeScreenState();
  }
}

class _HomeScreenState extends State<HomeScreen> {
  final List<Widget> _screens = [
    const CategoriesScreen(),
    const MealsScreen(
      meals: [],
    )
  ];
  String appBarTitle = 'Pick your Categories';
  int _currentPageIndex = 0;
  void _onTabChange(int index) {
    setState(() {
      _currentPageIndex = index;
      appBarTitle =
          _currentPageIndex == 0 ? 'Pick your Categories' : 'Favourite';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(appBarTitle),
      ),
      body: _screens[_currentPageIndex],
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
