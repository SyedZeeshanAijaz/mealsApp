import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/models/meal.dart';
import 'package:meals_app/providers/favourites_provider.dart';

class MealDetailsScreen extends ConsumerWidget {
  const MealDetailsScreen({super.key, required this.meal});
  final Meal meal;
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final favouriteList = ref.watch(favouriteMealsProvider);
    final isFavourite = favouriteList.contains(meal);
    double deviceHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(meal.title),
        actions: [
          IconButton(
            onPressed: () {
              final isFavourite = ref
                  .read(favouriteMealsProvider.notifier)
                  .toggleFavouriteMeal(meal);
              final snackBarMsg = isFavourite
                  ? "Meal added in Favourite"
                  : "Meal removed from Favourite";
              ScaffoldMessenger.of(context).clearSnackBars();
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(snackBarMsg),
                  duration: const Duration(seconds: 1),
                ),
              );
            },
            icon: Icon(isFavourite ? Icons.favorite : Icons.favorite_border),
          ),
        ],
      ),
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Image.network(
            meal.imageUrl,
            height: deviceHeight / 3,
            width: double.infinity,
            fit: BoxFit.cover,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'Ingredients',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
          ),
          const SizedBox(
            height: 10,
          ),
          ...meal.ingredients.map(
            (ingredient) => Text(
              ingredient,
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium!
                  .copyWith(color: Theme.of(context).colorScheme.onBackground),
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'Steps',
            style: Theme.of(context)
                .textTheme
                .titleLarge!
                .copyWith(color: Theme.of(context).colorScheme.primary),
            textAlign: TextAlign.center,
          ),
          const SizedBox(
            height: 10,
          ),
          Expanded(
            child: Container(
              padding: const EdgeInsets.symmetric(horizontal: 10),
              child: SingleChildScrollView(
                child: Column(
                  children: meal.steps
                      .map(
                        (step) => Padding(
                          padding: const EdgeInsets.only(bottom: 6),
                          child: Text(
                            step,
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium!
                                .copyWith(
                                    color: Theme.of(context)
                                        .colorScheme
                                        .onBackground),
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )
                      .toList(),
                ),
              ),
            ),
          )
        ],
      ),
    );
  }
}
