part of 'recipes_bloc.dart';

abstract class RecipesEvent extends Equatable {
  const RecipesEvent();

  @override
  List<Object> get props => [];
}

class LoadRecipesEvent extends RecipesEvent {}

class SearchRecipesEvent extends RecipesEvent {
  final String query;

  const SearchRecipesEvent(this.query);

  @override
  List<Object> get props => [query];
}

class AddRecipeEvent extends RecipesEvent {
  final Recipe recipe;

  const AddRecipeEvent(this.recipe);

  @override
  List<Object> get props => [recipe];
}

class UpdateRecipeEvent extends RecipesEvent {
  final Recipe recipe;
  const UpdateRecipeEvent(this.recipe);
  @override
  List<Object> get props => [recipe];
}