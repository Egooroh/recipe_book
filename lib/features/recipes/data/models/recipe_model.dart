import 'package:hive/hive.dart';
import '../../domain/entities/recipe.dart';

part 'recipe_model.g.dart';

@HiveType(typeId: 0)
class RecipeModel extends Recipe {
  @HiveField(0)
  final String id;
  @HiveField(1)
  final String title;
  @HiveField(2)
  final String description;
  @HiveField(3)
  final List<IngredientModel> ingredients;
  @HiveField(4)
  final List<String> steps;
  @HiveField(5)
  final String? imagePath;
  @HiveField(6)
  final String category;
  @HiveField(7)
  final bool isFavorite;
  @HiveField(8)
  final String traditionDescription;

  const RecipeModel({
    required this.id,
    required this.title,
    required this.description,
    required this.traditionDescription,
    required this.ingredients,
    required this.steps,
    this.imagePath,
    required this.category,
    this.isFavorite = false,
  }) : super(
    id: id,
    title: title,
    description: description,
    traditionDescription: traditionDescription,
    ingredients: ingredients,
    steps: steps,
    imagePath: imagePath,
    category: category,
    isFavorite: isFavorite,
  );

  factory RecipeModel.fromEntity(Recipe recipe) {
    return RecipeModel(
      id: recipe.id,
      title: recipe.title,
      description: recipe.description,
      traditionDescription: recipe.traditionDescription,
      ingredients: recipe.ingredients
          .map((e) => IngredientModel(name: e.name, amount: e.amount))
          .toList(),
      steps: recipe.steps,
      imagePath: recipe.imagePath,
      category: recipe.category,
      isFavorite: recipe.isFavorite,
    );
  }
}

@HiveType(typeId: 1)
class IngredientModel extends Ingredient {
  @HiveField(0)
  final String name;
  @HiveField(1)
  final String amount;

  const IngredientModel({required this.name, required this.amount})
      : super(name: name, amount: amount);
}