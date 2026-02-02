import 'package:equatable/equatable.dart';

class Ingredient extends Equatable {
  final String name;
  final String amount;

  const Ingredient({
    required this.name,
    required this.amount,
  });

  @override
  List<Object?> get props => [name, amount];
}

class Recipe extends Equatable {
  final String id;
  final String title;
  final String description;
  final List<Ingredient> ingredients;
  final List<String> steps;
  final String? imagePath;
  final String category;
  final bool isFavorite;

  const Recipe({
    required this.id,
    required this.title,
    required this.description,
    required this.ingredients,
    required this.steps,
    this.imagePath,
    required this.category,
    this.isFavorite = false,
  });

  Recipe copyWith({
    String? id,
    String? title,
    String? description,
    List<Ingredient>? ingredients,
    List<String>? steps,
    String? imagePath,
    String? category,
    bool? isFavorite,
  }) {
    return Recipe(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      ingredients: ingredients ?? this.ingredients,
      steps: steps ?? this.steps,
      imagePath: imagePath ?? this.imagePath,
      category: category ?? this.category,
      isFavorite: isFavorite ?? this.isFavorite,
    );
  }

  @override
  List<Object?> get props => [
    id,
    title,
    description,
    ingredients,
    steps,
    imagePath,
    category,
    isFavorite,
  ];
}