import 'package:flutter/material.dart';

enum Filters { glutenFree, lactoseFree, vegetarian, vegan }

class FiltersScreen extends StatefulWidget {
  const FiltersScreen({super.key, required this.filters});
  final Map<Filters, bool> filters;
  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  late bool _isGlutenFree;
  late bool _isLactoseFree;
  late bool _isVegetarian;
  late bool _isVegan;
  @override
  void initState() {
    _isGlutenFree = widget.filters.values.toList()[0];
    _isLactoseFree = widget.filters.values.toList()[1];
    _isVegetarian = widget.filters.values.toList()[2];
    _isVegan = widget.filters.values.toList()[3];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      onPopInvoked: (didPop) async {
        if (didPop) return;
        Navigator.pop(context, {
          Filters.glutenFree: _isGlutenFree,
          Filters.lactoseFree: _isLactoseFree,
          Filters.vegetarian: _isVegetarian,
          Filters.vegan: _isVegan,
        });
      },
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Your Filters'),
        ),
        body: Column(
          children: [
            SwitchListTile(
              value: _isGlutenFree,
              onChanged: (status) {
                setState(
                  () {
                    _isGlutenFree = status;
                  },
                );
              },
              title: Text('Gluten-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
              subtitle: const Text('Only include Gluten-free meals.'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            ),
            SwitchListTile(
              value: _isLactoseFree,
              onChanged: (status) {
                setState(
                  () {
                    _isLactoseFree = status;
                  },
                );
              },
              title: Text('Lactose-free',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
              subtitle: const Text('Only include Lactose-free meals.'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            ),
            SwitchListTile(
              value: _isVegetarian,
              onChanged: (status) {
                setState(
                  () {
                    _isVegetarian = status;
                  },
                );
              },
              title: Text('Vegetarian',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
              subtitle: const Text('Only include Vegetarian meals.'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            ),
            SwitchListTile(
              value: _isVegan,
              onChanged: (status) {
                setState(
                  () {
                    _isVegan = status;
                  },
                );
              },
              title: Text('Vegan',
                  style: Theme.of(context).textTheme.titleLarge!.copyWith(
                      color: Theme.of(context).colorScheme.onPrimaryContainer)),
              subtitle: const Text('Only include Vegan meals.'),
              contentPadding: const EdgeInsets.symmetric(horizontal: 30),
            ),
          ],
        ),
      ),
    );
  }
}
