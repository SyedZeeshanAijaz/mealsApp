import 'package:flutter/material.dart';
import 'package:meals_app/models/category.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/screens/meals_screen.dart';
import '../widgets/categories_grid_item.dart';
import '../data/dummy_data.dart';
import 'filters_screen.dart';

class CategoriesScreen extends StatelessWidget {
  const CategoriesScreen(
      {super.key, required this.onFavouriteToggle, required this.filter});
  final void Function(Meal meal) onFavouriteToggle;
  final Map<Filters, bool> filter;
  void _onSelectCategory(
      {required BuildContext context, required Category category}) {
    List<Meal> meals = dummyMeals
        .where((meal) => meal.categories.contains(category.id)
            // meal.isGlutenFree == filter[Filters.glutenFree] &&
            // meal.isLactoseFree == filter[Filters.lactoseFree] &&
            // meal.isVegan == filter[Filters.vegan] &&
            // meal.isVegetarian == filter[Filters.vegetarian])
            )
        .where((meal) {
      if (filter[Filters.glutenFree]! && !meal.isGlutenFree) {
        return false;
      }
      if (filter[Filters.lactoseFree]! && !meal.isLactoseFree) {
        return false;
      }
      if (filter[Filters.vegetarian]! && !meal.isVegetarian) {
        return false;
      }
      if (filter[Filters.vegan]! && !meal.isVegan) {
        return false;
      }
      return true;
    }).toList();
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) {
          return MealsScreen(
            title: category.title,
            meals: meals,
            onFavouriteToggle: onFavouriteToggle,
          );
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GridView(
      padding: const EdgeInsets.all(24),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 3 / 2,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      children: [
        for (final category in availableCategories)
          CategoryGridItem(
            category: category,
            onSelectCategory: () {
              _onSelectCategory(context: context, category: category);
            },
          ),
      ],
    );
  }
}
