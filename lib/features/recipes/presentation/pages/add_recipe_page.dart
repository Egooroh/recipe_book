import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:uuid/uuid.dart';
import '../../../../core/utils/image_helper.dart';
import '../../domain/entities/recipe.dart';
import '../bloc/recipes_bloc.dart';

class AddRecipePage extends StatefulWidget {
  const AddRecipePage({super.key});

  @override
  State<AddRecipePage> createState() => _AddRecipePageState();
}

class _AddRecipePageState extends State<AddRecipePage> {
  final _formKey = GlobalKey<FormState>();
  final _titleController = TextEditingController();
  final _descController = TextEditingController();
  final _categoryController = TextEditingController();

  final _ingredientsController = TextEditingController();

  String? _imagePath;

  void _saveRecipe() {
    if (_formKey.currentState!.validate()) {
      final ingredientsList = _ingredientsController.text
          .split('\n')
          .where((s) => s.isNotEmpty)
          .map((e) => Ingredient(name: e, amount: 'По вкусу'))
          .toList();

      final newRecipe = Recipe(
        id: const Uuid().v4(),
        title: _titleController.text,
        description: _descController.text,
        ingredients: ingredientsList,
        steps: const [],
        imagePath: _imagePath,
        category: _categoryController.text.isEmpty ? 'Разное' : _categoryController.text,
        isFavorite: false,
      );

      context.read<RecipesBloc>().add(AddRecipeEvent(newRecipe));

      Navigator.pop(context);
    }
  }

  Future<void> _pickImage() async {
    final path = await ImageHelper.pickAndSaveImage();
    if (path != null) {
      setState(() {
        _imagePath = path;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Новый рецепт')),
      body: Form(
        key: _formKey,
        child: ListView(
          padding: const EdgeInsets.all(16),
          children: [
            GestureDetector(
              onTap: _pickImage,
              child: Container(
                height: 200,
                decoration: BoxDecoration(
                  color: Colors.grey[200],
                  borderRadius: BorderRadius.circular(12),
                  image: _imagePath != null
                      ? DecorationImage(
                      image: FileImage(File(_imagePath!)), fit: BoxFit.cover)
                      : null,
                ),
                child: _imagePath == null
                    ? const Icon(Icons.add_a_photo, size: 50, color: Colors.grey)
                    : null,
              ),
            ),
            const SizedBox(height: 16),

            TextFormField(
              controller: _titleController,
              decoration: const InputDecoration(labelText: 'Название блюда'),
              validator: (v) => v!.isEmpty ? 'Введите название' : null,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _categoryController,
              decoration: const InputDecoration(labelText: 'Категория (напр. Супы)'),
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _descController,
              decoration: const InputDecoration(labelText: 'Описание / История'),
              maxLines: 3,
            ),
            const SizedBox(height: 12),
            TextFormField(
              controller: _ingredientsController,
              decoration: const InputDecoration(
                labelText: 'Ингредиенты (каждый с новой строки)',
                alignLabelWithHint: true,
              ),
              maxLines: 5,
            ),
            const SizedBox(height: 24),

            ElevatedButton(
              onPressed: _saveRecipe,
              style: ElevatedButton.styleFrom(
                backgroundColor: Theme.of(context).primaryColor,
                padding: const EdgeInsets.symmetric(vertical: 16),
              ),
              child: const Text('Сохранить в книгу',
                  style: TextStyle(fontSize: 16, color: Colors.white)),
            ),
          ],
        ),
      ),
    );
  }
}