import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:meals_app/providers/filters_providers.dart';

class FiltersScreen extends ConsumerWidget {
  const FiltersScreen({super.key});
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final filters = ref.watch(filtersProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your Filters'),
      ),
      body: Column(
        children: [
          SwitchListTile(
            value: filters[Filter.glutenFree]!,
            onChanged: (status) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.glutenFree, status);
            },
            title: Text(
              'Gluten-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            subtitle: const Text('Only include Gluten-free meals.'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          ),
          SwitchListTile(
            value: filters[Filter.lactoseFree]!,
            onChanged: (status) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.lactoseFree, status);
            },
            title: Text(
              'Lactose-free',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            subtitle: const Text('Only include Lactose-free meals.'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          ),
          SwitchListTile(
            value: filters[Filter.vegetarian]!,
            onChanged: (status) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegetarian, status);
            },
            title: Text(
              'Vegetarian',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            subtitle: const Text('Only include Vegetarian meals.'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          ),
          SwitchListTile(
            value: filters[Filter.vegan]!,
            onChanged: (status) {
              ref
                  .read(filtersProvider.notifier)
                  .setFilter(Filter.vegan, status);
            },
            title: Text(
              'Vegan',
              style: Theme.of(context).textTheme.titleLarge!.copyWith(
                  color: Theme.of(context).colorScheme.onPrimaryContainer),
            ),
            subtitle: const Text('Only include Vegan meals.'),
            contentPadding: const EdgeInsets.symmetric(horizontal: 30),
          ),
        ],
      ),
    );
  }
}
