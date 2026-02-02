import 'package:uuid/uuid.dart';
import '../../features/recipes/data/models/recipe_model.dart';

final List<RecipeModel> kDefaultRecipes = [
  RecipeModel(
    id: const Uuid().v4(),
    title: 'Домашний Борщ',
    description: 'Тот самый борщ, который варила бабушка. Наваристый, красный и с чесночными пампушками. Секрет в том, чтобы свеклу тушить отдельно с лимоном.',
    ingredients: const [
      IngredientModel(name: 'Говядина на кости', amount: '500 г'),
      IngredientModel(name: 'Свекла', amount: '2 шт'),
      IngredientModel(name: 'Капуста свежая', amount: '300 г'),
      IngredientModel(name: 'Картофель', amount: '4 шт'),
      IngredientModel(name: 'Морковь', amount: '1 шт'),
      IngredientModel(name: 'Лук репчатый', amount: '1 шт'),
      IngredientModel(name: 'Томатная паста', amount: '2 ст. л.'),
    ],
    steps: const [
      'Сварить бульон из говядины (около 2 часов).',
      'Нарезать картофель кубиками, закинуть в бульон.',
      'Нашинковать капусту, добавить следом.',
      'Сделать зажарку: лук и морковь обжарить, добавить тертую свеклу и томатную пасту. Тушить 15 минут.',
      'Добавить зажарку в суп, варить еще 10 минут.',
      'Добавить чеснок и зелень, выключить и дать настояться полчаса.'
    ],
    imagePath: null,
    category: 'Супы',
    isFavorite: true,
  ),
  RecipeModel(
    id: const Uuid().v4(),
    title: 'Тонкие блинчики',
    description: 'Идеальные блинчики для завтрака. Тонкие, ажурные, с дырочками. Отлично подходят для заворачивания начинки или просто со сметаной.',
    ingredients: const [
      IngredientModel(name: 'Молоко', amount: '500 мл'),
      IngredientModel(name: 'Яйца', amount: '3 шт'),
      IngredientModel(name: 'Мука', amount: '200 г'),
      IngredientModel(name: 'Масло растительное', amount: '2 ст. л.'),
      IngredientModel(name: 'Сахар', amount: '1 ст. л.'),
      IngredientModel(name: 'Соль', amount: 'щепотка'),
    ],
    steps: const [
      'Яйца взбить с сахаром и солью.',
      'Влить половину молока, перемешать.',
      'Всыпать муку, размешать до исчезновения комочков.',
      'Влить оставшееся молоко и масло.',
      'Жарить на раскаленной сковороде с двух сторон до золотистого цвета.'
    ],
    imagePath: null,
    category: 'Завтрак',
    isFavorite: false,
  ),
  RecipeModel(
    id: const Uuid().v4(),
    title: 'Шарлотка с яблоками',
    description: 'Самый простой и быстрый пирог к чаю. Бисквитное тесто и много кислых яблок.',
    ingredients: const [
      IngredientModel(name: 'Яйца', amount: '4 шт'),
      IngredientModel(name: 'Сахар', amount: '1 стакан'),
      IngredientModel(name: 'Мука', amount: '1 стакан'),
      IngredientModel(name: 'Яблоки (Антоновка)', amount: '3-4 шт'),
      IngredientModel(name: 'Корица', amount: 'по вкусу'),
    ],
    steps: const [
      'Яйца взбить с сахаром в пышную пену (минут 5-7).',
      'Аккуратно вмешать муку лопаткой.',
      'Яблоки нарезать кубиками или дольками.',
      'Форму смазать маслом, выложить яблоки, залить тестом.',
      'Выпекать при 180 градусах около 30-40 минут.'
    ],
    imagePath: null,
    category: 'Выпечка',
    isFavorite: false,
  ),
];