import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:equatable/equatable.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../../domain/entities/recipe.dart';
import '../../domain/usecases/get_recipes.dart';
import '../../domain/usecases/save_recipe.dart';

part 'recipes_event.dart';
part 'recipes_state.dart';

class RecipesBloc extends Bloc<RecipesEvent, RecipesState> {
  final GetRecipes getRecipes;
  final SaveRecipe saveRecipe;

  RecipesBloc({
    required this.getRecipes,
    required this.saveRecipe,
  }) : super(RecipesInitial()) {

    on<LoadRecipesEvent>(_onLoadRecipes);
    on<SearchRecipesEvent>(_onSearchRecipes);
    on<AddRecipeEvent>(_onAddRecipe);

    on<UpdateRecipeEvent>(_onUpdateRecipe);
  }

  Future<void> _onLoadRecipes(
      LoadRecipesEvent event,
      Emitter<RecipesState> emit,
      ) async {
    emit(RecipesLoading());
    final result = await getRecipes(NoParams());
    result.fold(
          (failure) => emit(RecipesError(_mapFailureToMessage(failure))),
          (recipes) => emit(RecipesLoaded(recipes)),
    );
  }

  Future<void> _onSearchRecipes(
      SearchRecipesEvent event,
      Emitter<RecipesState> emit,
      ) async {
    emit(RecipesLoading());

    final result = await getRecipes(NoParams());

    result.fold(
          (failure) => emit(RecipesError(_mapFailureToMessage(failure))),
          (recipes) {
        final query = event.query.toLowerCase();

        final filtered = recipes.where((recipe) {
          final titleLower = recipe.title.toLowerCase();
          final categoryLower = recipe.category.toLowerCase();
          return titleLower.contains(query) || categoryLower.contains(query);
        }).toList();

        emit(RecipesLoaded(filtered));
      },
    );
  }

  Future<void> _onAddRecipe(
      AddRecipeEvent event,
      Emitter<RecipesState> emit,
      ) async {
    emit(RecipesLoading());
    final result = await saveRecipe(event.recipe);
    result.fold(
          (failure) => emit(RecipesError(_mapFailureToMessage(failure))),
          (_) => add(LoadRecipesEvent()),
    );
  }

  Future<void> _onUpdateRecipe(
      UpdateRecipeEvent event,
      Emitter<RecipesState> emit,
      ) async {
    await saveRecipe(event.recipe);
    add(LoadRecipesEvent());
  }

  String _mapFailureToMessage(Failure failure) {
    if (failure is CacheFailure) {
      return "Ошибка сохранения данных на устройстве.";
    }
    return "Произошла неожиданная ошибка.";
  }
}

