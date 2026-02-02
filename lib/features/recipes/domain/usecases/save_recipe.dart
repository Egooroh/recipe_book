import 'package:fpdart/fpdart.dart';
import '../../../../core/error/failures.dart';
import '../../../../core/usecases/usecase.dart';
import '../entities/recipe.dart';
import '../repositories/recipe_repository.dart';

class SaveRecipe implements UseCase<void, Recipe> {
  final RecipeRepository repository;

  SaveRecipe(this.repository);

  @override
  Future<Either<Failure, void>> call(Recipe params) async {
    return await repository.addRecipe(params);
  }
}