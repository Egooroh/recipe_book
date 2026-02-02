import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../bloc/recipes_bloc.dart';
import '../pages/recipe_detail_page.dart';
import '../widgets/recipe_card.dart';

class RecipeSearchDelegate extends SearchDelegate {
  final RecipesBloc recipeBloc;

  RecipeSearchDelegate({required this.recipeBloc});

  @override
  String get searchFieldLabel => 'Поиск рецепта...';

  @override
  TextStyle? get searchFieldStyle => const TextStyle(fontSize: 18);

  @override
  List<Widget>? buildActions(BuildContext context) {
    return [
      if (query.isNotEmpty)
        IconButton(
          icon: const Icon(Icons.clear),
          onPressed: () {
            query = '';
            recipeBloc.add(const SearchRecipesEvent(''));
          },
        ),
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () {
        close(context, null);
      },
    );
  }

  @override
  Widget buildResults(BuildContext context) {
    recipeBloc.add(SearchRecipesEvent(query));

    return _buildSearchResults();
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    if (query.isEmpty) {
      return const Center(child: Text('Начните вводить название...'));
    }

    // "Живой" поиск по мере ввода
    recipeBloc.add(SearchRecipesEvent(query));

    return _buildSearchResults();
  }

  Widget _buildSearchResults() {
    return BlocBuilder<RecipesBloc, RecipesState>(
      bloc: recipeBloc,
      builder: (context, state) {
        if (state is RecipesLoading) {
          return const Center(child: CircularProgressIndicator());
        } else if (state is RecipesLoaded) {
          if (state.recipes.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.search_off, size: 64, color: Colors.grey),
                  const SizedBox(height: 16),
                  Text('Ничего не найдено по запросу "$query"',
                      style: const TextStyle(color: Colors.grey)),
                ],
              ),
            );
          }

          return ListView.builder(
            itemCount: state.recipes.length,
            itemBuilder: (context, index) {
              final recipe = state.recipes[index];
              return RecipeCard(
                recipe: recipe,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => BlocProvider.value(
                        value: recipeBloc,
                        child: RecipeDetailPage(recipe: recipe),
                      ),
                    ),
                  );
                },
              );
            },
          );
        } else if (state is RecipesError) {
          return Center(child: Text(state.message));
        }
        return const SizedBox.shrink();
      },
    );
  }
}