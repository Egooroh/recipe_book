import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'features/recipes/data/models/recipe_model.dart';
import 'features/recipes/presentation/pages/recipes_page.dart';
import 'core/theme/app_theme.dart';
import 'injection_container.dart' as di;

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Hive.initFlutter();

  Hive.registerAdapter(RecipeModelAdapter());
  Hive.registerAdapter(IngredientModelAdapter());

  await di.init();

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Традиции вкуса',
      debugShowCheckedModeBanner: false,

      theme: AppTheme.lightTheme,

      home: const RecipesPage(),
    );
  }
}