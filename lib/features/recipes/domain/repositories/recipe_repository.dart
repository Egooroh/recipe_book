import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../entities/recipe.dart';

abstract class RecipeRepository {
  Future<Either<Failure, List<Recipe>>> getRecipes();

  Future<Either<Failure, void>> addRecipe(Recipe recipe);

  Future<Either<Failure, void>> deleteRecipe(String id);

  Future<Either<Failure, void>> updateRecipe(Recipe recipe);

  Future<Either<Failure, List<Recipe>>> searchRecipes(String query);
}