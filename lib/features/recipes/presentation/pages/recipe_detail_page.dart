import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../domain/entities/recipe.dart';
import '../bloc/recipes_bloc.dart';

class RecipeDetailPage extends StatelessWidget {
  final Recipe recipe;

  const RecipeDetailPage({super.key, required this.recipe});

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);

    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            expandedHeight: 300,
            pinned: true,
            leading: IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white, shadows: [
                Shadow(offset: Offset(0, 1), blurRadius: 3.0, color: Colors.black45)
              ]),
              onPressed: () => Navigator.of(context).pop(),
            ),

            flexibleSpace: FlexibleSpaceBar(
              centerTitle: false,

              titlePadding: const EdgeInsetsDirectional.only(
                  start: 52.0,
                  end: 16.0,
                  bottom: 16.0
              ),

              title: Text(
                recipe.title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontFamily: 'PlaypenSans',
                  fontSize: 20,
                  shadows: [
                    Shadow(offset: Offset(0, 1), blurRadius: 3.0, color: Colors.black45)
                  ],
                ),
              ),
              background: recipe.imagePath != null
                  ? Hero(
                tag: recipe.id,
                child: Image.file(
                  File(recipe.imagePath!),
                  fit: BoxFit.cover,
                ),
              )
                  : Container(
                color: theme.primaryColor,
                child: const Center(
                  child: Icon(Icons.restaurant_menu, size: 64, color: Colors.white),
                ),
              ),
            ),
          ),

          SliverList(
            delegate: SliverChildListDelegate([
              Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                          decoration: BoxDecoration(
                            color: theme.colorScheme.secondary,
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: Text(
                            recipe.category,
                            style: TextStyle(
                              color: theme.colorScheme.onSecondaryContainer,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        BlocBuilder<RecipesBloc, RecipesState>(
                          builder: (context, state) {
                            Recipe currentRecipe = recipe;
                            if (state is RecipesLoaded) {
                              try {
                                currentRecipe = state.recipes.firstWhere(
                                        (r) => r.id == recipe.id
                                );
                              } catch (e) {}
                            }
                            return IconButton(
                              icon: Icon(
                                currentRecipe.isFavorite ? Icons.favorite : Icons.favorite_border,
                                color: const Color(0xFFE63946),
                                size: 32,
                              ),
                              onPressed: () {
                                final updatedRecipe = currentRecipe.copyWith(
                                    isFavorite: !currentRecipe.isFavorite
                                );
                                context.read<RecipesBloc>().add(UpdateRecipeEvent(updatedRecipe));
                              },
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(height: 24),

                    Text(
                      recipe.description,
                      style: theme.textTheme.bodyLarge?.copyWith(
                        height: 1.5,
                        fontStyle: FontStyle.italic,
                        color: theme.textTheme.bodyLarge?.color?.withOpacity(0.8),
                      ),
                    ),

                    const SizedBox(height: 24),
                    const Divider(),
                    const SizedBox(height: 24),

                    if (recipe.traditionDescription.isNotEmpty) ...[
                      Row(
                        children: [
                          Icon(Icons.history_edu, color: theme.primaryColor),
                          const SizedBox(width: 8),
                          Text("Традиции вкуса", style: theme.textTheme.headlineSmall),
                        ],
                      ),
                      const SizedBox(height: 12),
                      Container(
                        padding: const EdgeInsets.all(16),
                        decoration: BoxDecoration(
                          color: theme.colorScheme.secondary.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(12),
                          border: Border.all(color: theme.primaryColor.withOpacity(0.2)),
                        ),
                        child: Text(
                          recipe.traditionDescription,
                          style: theme.textTheme.bodyLarge?.copyWith(
                            height: 1.6,
                            fontFamily: 'PlaypenSans',
                          ),
                        ),
                      ),
                      const SizedBox(height: 32),
                    ],

                    Text("Ингредиенты", style: theme.textTheme.headlineSmall),
                    const SizedBox(height: 16),
                    Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: theme.colorScheme.surface,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(color: Colors.grey.withOpacity(0.2)),
                      ),
                      child: Column(
                        children: recipe.ingredients.map((ingredient) => Padding(
                          padding: const EdgeInsets.symmetric(vertical: 6),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Flexible(
                                child: Text("• ${ingredient.name}",
                                    style: theme.textTheme.bodyLarge),
                              ),
                              const SizedBox(width: 8),
                              Text(
                                ingredient.amount,
                                style: theme.textTheme.bodyLarge?.copyWith(
                                    fontWeight: FontWeight.bold,
                                    color: theme.primaryColor
                                ),
                              ),
                            ],
                          ),
                        )).toList(),
                      ),
                    ),

                    const SizedBox(height: 32),

                    if (recipe.steps.isNotEmpty) ...[
                      Text("Способ приготовления", style: theme.textTheme.headlineSmall),
                      const SizedBox(height: 16),
                      ...recipe.steps.asMap().entries.map((entry) {
                        int index = entry.key + 1;
                        String stepText = entry.value;
                        return _buildStepItem(context, index, stepText);
                      }),
                    ],

                    const SizedBox(height: 50),
                  ],
                ),
              ),
            ]),
          ),
        ],
      ),
    );
  }

  Widget _buildStepItem(BuildContext context, int index, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 20.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            width: 32,
            height: 32,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,
              shape: BoxShape.circle,
            ),
            child: Text(
              "$index",
              style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.bold,
                  fontSize: 16
              ),
            ),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Text(
              text,
              style: Theme.of(context).textTheme.bodyLarge?.copyWith(height: 1.5),
            ),
          ),
        ],
      ),
    );
  }
}