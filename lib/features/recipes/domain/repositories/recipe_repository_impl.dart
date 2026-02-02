import 'package:fpdart/fpdart.dart';
import '../../../../core/error/exceptions.dart';
import '../../../../core/error/failures.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/repositories/recipe_repository.dart';
import '../../data/datasources/recipe_local_datasource.dart';
import '../../data/models/recipe_model.dart';

class RecipeRepositoryImpl implements RecipeRepository {
  final RecipeLocalDataSource localDataSource;

  RecipeRepositoryImpl({required this.localDataSource});

  @override
  Future<Either<Failure, List<Recipe>>> getRecipes() async {
    try {
      final localRecipes = await localDataSource.getRecipes();
      return Right(localRecipes);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> addRecipe(Recipe recipe) async {
    try {
      final recipeModel = RecipeModel.fromEntity(recipe);
      await localDataSource.cacheRecipe(recipeModel);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> deleteRecipe(String id) async {
    try {
      await localDataSource.deleteRecipe(id);
      return const Right(null);
    } on CacheException {
      return Left(CacheFailure());
    }
  }

  @override
  Future<Either<Failure, void>> updateRecipe(Recipe recipe) async {
    return addRecipe(recipe);
  }

  @override
  Future<Either<Failure, List<Recipe>>> searchRecipes(String query) async {
    try {
      final allRecipes = await localDataSource.getRecipes();
      final filtered = allRecipes.where((recipe) {
        final titleLower = recipe.title.toLowerCase();
        final searchLower = query.toLowerCase();
        return titleLower.contains(searchLower);
      }).toList();
      return Right(filtered);
    } on CacheException {
      return Left(CacheFailure());
    }
  }
}