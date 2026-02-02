import 'package:get_it/get_it.dart';
import 'package:hive/hive.dart';
import 'features/recipes/data/datasources/recipe_local_datasource.dart';
import 'features/recipes/data/models/recipe_model.dart';
import 'features/recipes/data/repositories/recipe_repository_impl.dart';
import 'features/recipes/domain/repositories/recipe_repository.dart';
import 'features/recipes/domain/usecases/get_recipes.dart';
import 'features/recipes/domain/usecases/save_recipe.dart';
import 'features/recipes/presentation/bloc/recipes_bloc.dart';

final sl = GetIt.instance;

Future<void> init() async {
  sl.registerFactory(
        () => RecipesBloc(
      getRecipes: sl(),
      saveRecipe: sl(),
    ),
  );

  sl.registerLazySingleton(() => GetRecipes(sl()));
  sl.registerLazySingleton(() => SaveRecipe(sl()));

  sl.registerLazySingleton<RecipeRepository>(
        () => RecipeRepositoryImpl(localDataSource: sl()),
  );

  sl.registerLazySingleton<RecipeLocalDataSource>(
        () => RecipeLocalDataSourceImpl(sl()),
  );

  final recipeBox = await Hive.openBox<RecipeModel>('recipes_box');
  sl.registerLazySingleton(() => recipeBox);
}