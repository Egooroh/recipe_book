import 'package:uuid/uuid.dart';
import '../../features/recipes/data/models/recipe_model.dart';

final List<RecipeModel> kDefaultRecipes = [
  RecipeModel(
    id: const Uuid().v4(),
    title: 'Губадия (татарский свадебный пирог)',
    description: 'Многослойный пирог с тремя начинками: картофель, мясо и творог с изюмом.',
    traditionDescription: 'Символ трёх миров в татарской космологии: нижний слой (картофель) — подземный мир, средний (мясо) — земной, верхний (творог) — небесный. Обязательный атрибут свадебного стола.',
    ingredients: const [
      IngredientModel(name: 'Мука пшеничная', amount: '500 г'),
      IngredientModel(name: 'Мясо баранины', amount: '300 г'),
      IngredientModel(name: 'Картофель отварной', amount: '200 г'),
      IngredientModel(name: 'Творог', amount: '200 г'),
      IngredientModel(name: 'Изюм', amount: '50 г'),
      IngredientModel(name: 'Лук репчатый', amount: '2 шт'),
      IngredientModel(name: 'Яйца', amount: '2 шт'),
      IngredientModel(name: 'Сливочное масло', amount: '100 г'),
    ],
    steps: const [
      'Приготовить три начинки отдельно: обжарить мясо с луком, размять картофель с маслом, смешать творог с изюмом.',
      'Замесить пресное тесто, разделить на 3 пласта разного размера.',
      'Выложить слои в смазанную форму: самый большой пласт — дно, на него картофель, затем мясо, сверху творог.',
      'Накрыть средним пластом теста, защипать края. Сверху — маленький пласт как «крышечка».',
      'Смазать яйцом, выпекать 45 минут при 180°С до золотистого цвета.'
    ],
    imagePath: null,
    category: 'Татарская кухня',
    isFavorite: true,
  ),
  RecipeModel(
    id: const Uuid().v4(),
    title: 'Буузы (бурятские позы)',
    description: 'Крупные пельмени на пару с рубленым мясом и отверстием сверху.',
    traditionDescription: 'Символ открытого неба для духа предков. Готовятся на Урс-Алдар (бурятский Новый год) и при встрече почётных гостей. Мясо рубится ножом, не прокручивается — так сохраняется текстура.',
    ingredients: const [
      IngredientModel(name: 'Говядина (кострец)', amount: '400 г'),
      IngredientModel(name: 'Сало говяжье', amount: '100 г'),
      IngredientModel(name: 'Лук репчатый', amount: '3 шт'),
      IngredientModel(name: 'Мука', amount: '400 г'),
      IngredientModel(name: 'Вода', amount: '150 мл'),
      IngredientModel(name: 'Соль, перец', amount: 'по вкусу'),
      IngredientModel(name: 'Зира', amount: '1 ч. л.'),
    ],
    steps: const [
      'Мясо и сало нарезать мелкими кубиками (не прокручивать!).',
      'Лук мелко порубить, смешать с мясом, добавить специи.',
      'Замесить крутое тесто, дать отдохнуть 30 минут.',
      'Раскатать лепёшки диаметром 12 см, выложить начинку горкой.',
      'Сформовать бууз так, чтобы сверху осталось отверстие диаметром 1 см.',
      'Готовить на пару 25 минут в мантоварке или пароварке.'
    ],
    imagePath: null,
    category: 'Бурятская кухня',
    isFavorite: false,
  ),
  RecipeModel(
    id: const Uuid().v4(),
    title: 'Калитки (карельские пирожки)',
    description: 'Маленькие открытые пирожки из ржаного теста с гречневой кашей.',
    traditionDescription: 'Традиционное блюдо карелов. Открытая форма символизирует связь мира живых и ушедших. Часто подавались на поминальных обедах.',
    ingredients: const [
      IngredientModel(name: 'Мука ржаная', amount: '300 г'),
      IngredientModel(name: 'Мука пшеничная', amount: '100 г'),
      IngredientModel(name: 'Гречневая каша', amount: '250 г'),
      IngredientModel(name: 'Лук репчатый', amount: '1 шт'),
      IngredientModel(name: 'Молоко', amount: '150 мл'),
      IngredientModel(name: 'Дрожжи сухие', amount: '5 г'),
      IngredientModel(name: 'Сливочное масло', amount: '50 г'),
      IngredientModel(name: 'Соль', amount: 'щепотка'),
    ],
    steps: const [
      'Замесить опарное тесто на тёплом молоке с дрожжами, дать подойти 1 час.',
      'Гречневую кашу смешать с обжаренным луком и маслом.',
      'Тесто разделить на шарики, раскатать в лепёшки диаметром 8 см.',
      'Выложить начинку в центр, края не защипывать — оставить открытыми.',
      'Выпекать 20 минут при 200°С до тёмно-коричневого цвета.'
    ],
    imagePath: null,
    category: 'Карельская кухня',
    isFavorite: false,
  ),
];