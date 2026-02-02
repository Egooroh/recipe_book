import 'package:hive/hive.dart';
import '../../../../core/constants/seed_data.dart';
import '../../../../core/error/exceptions.dart';
import '../models/recipe_model.dart';

abstract class RecipeLocalDataSource {
  Future<List<RecipeModel>> getRecipes();
  Future<void> cacheRecipe(RecipeModel recipe);
  Future<void> deleteRecipe(String id);
}

class RecipeLocalDataSourceImpl implements RecipeLocalDataSource {
  final Box<RecipeModel> recipeBox;

  RecipeLocalDataSourceImpl(this.recipeBox);

  @override
  Future<List<RecipeModel>> getRecipes() async {
    try {
      if (recipeBox.isEmpty) {
        for (var recipe in kDefaultRecipes) {
          await recipeBox.put(recipe.id, recipe);
        }
      }

      return recipeBox.values.toList();
    } catch (e) {
      throw CacheException();
    }
  }

  @override
  Future<void> cacheRecipe(RecipeModel recipe) async {
    await recipeBox.put(recipe.id, recipe);
  }

  @override
  Future<void> deleteRecipe(String id) async {
    await recipeBox.delete(id);
  }
}