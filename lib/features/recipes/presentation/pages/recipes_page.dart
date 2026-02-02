import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../injection_container.dart';
import '../bloc/recipes_bloc.dart';
import '../delegates/recipe_search_delegate.dart';
import '../widgets/recipe_card.dart';
import 'add_recipe_page.dart';
import 'favorites_page.dart';
import 'recipe_detail_page.dart';

class RecipesPage extends StatelessWidget {
  const RecipesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => sl<RecipesBloc>()..add(LoadRecipesEvent()),
      child: Builder(
          builder: (context) {
            return Scaffold(
              appBar: AppBar(
                leading: IconButton(
                  icon: const Icon(Icons.search),
                  tooltip: 'Поиск рецепта',
                  onPressed: () async {
                    final bloc = context.read<RecipesBloc>();
                    await showSearch(
                      context: context,
                      delegate: RecipeSearchDelegate(recipeBloc: bloc),
                    );
                    bloc.add(LoadRecipesEvent());
                  },
                ),

                title: const Text('Традиции вкуса'),

                actions: [
                  IconButton(
                    icon: const Icon(Icons.favorite, color: Color(0xFFE63946)),
                    tooltip: 'Избранное',
                    onPressed: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (_) => BlocProvider.value(
                            value: context.read<RecipesBloc>(),
                            child: const FavoritesPage(),
                          ),
                        ),
                      );
                    },
                  ),

                  /*
                  IconButton(
                    icon: const Icon(Icons.add),
                    onPressed: () => _navigateToAddRecipe(context),
                  ),
                  */
                ],
              ),
              body: BlocBuilder<RecipesBloc, RecipesState>(
                builder: (context, state) {
                  if (state is RecipesLoading) {
                    return const Center(child: CircularProgressIndicator());
                  } else if (state is RecipesError) {
                    return Center(child: Text(state.message));
                  } else if (state is RecipesLoaded) {
                    if (state.recipes.isEmpty) {
                      return const Center(
                        child: Text(
                            'Книга рецептов пока пуста.\nСкоро здесь появятся вкусные блюда!',
                            textAlign: TextAlign.center),
                      );
                    }
                    return ListView.builder(
                      padding: const EdgeInsets.symmetric(vertical: 8),
                      itemCount: state.recipes.length,
                      itemBuilder: (context, index) {
                        return RecipeCard(
                          recipe: state.recipes[index],
                          onTap: () {
                            Navigator.of(context).push(
                              MaterialPageRoute(
                                builder: (_) => BlocProvider.value(
                                  value: context.read<RecipesBloc>(),
                                  child: RecipeDetailPage(recipe: state.recipes[index]),
                                ),
                              ),
                            );
                          },
                        );
                      },
                    );
                  }
                  return const SizedBox.shrink();
                },
              ),
            );
          }
      ),
    );
  }

  void _navigateToAddRecipe(BuildContext context) {
    Navigator.of(context).push(
      MaterialPageRoute(
        builder: (_) => BlocProvider.value(
          value: context.read<RecipesBloc>(),
          child: const AddRecipePage(),
        ),
      ),
    );
  }
}