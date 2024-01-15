import 'package:meals_app/models/meal.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class FavouriteMealsNotifier extends StateNotifier<List<Meal>> {
  FavouriteMealsNotifier() : super([]);
  bool toggleFavouriteMeal(Meal meal) {
    if (state.contains(meal)) {
      state = state.where((m) => m.id != meal.id).toList();
      return false;
    }
    state = [...state, meal];
    return true;
  }
}

final favouriteMealsProvider =
    StateNotifierProvider<FavouriteMealsNotifier, List<Meal>>(
        (ref) => FavouriteMealsNotifier());
