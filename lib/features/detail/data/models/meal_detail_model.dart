import '../../domain/entities/meail_detail.dart';

class MealDetailModel {
  final String id;
  final String name;
  final String category;
  final String area;
  final String instructions;
  final String thumbnailUrl;
  final List<IngredientModel> ingredients;

  const MealDetailModel({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnailUrl,
    required this.ingredients,
  });

  factory MealDetailModel.fromJson(Map<String, dynamic> json) {
    final List<IngredientModel> ingredients = [];
    for (int i = 1; i <= 20; i++) {
      final name = json['strIngredient$i'] ?? '';
      final measure = json['strMeasure$i'] ?? '';
      if (name.trim().isNotEmpty) {
        ingredients.add(IngredientModel(name: name, measure: measure));
      }
    }

    return MealDetailModel(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      category: json['strCategory'] ?? '',
      area: json['strArea'] ?? '',
      instructions: json['strInstructions'] ?? '',
      thumbnailUrl: json['strMealThumb'] ?? '',
      ingredients: ingredients,
    );
  }

  MealDetail toEntity() {
    return MealDetail(
      id: id,
      name: name,
      category: category,
      area: area,
      instructions: instructions,
      thumbnailUrl: thumbnailUrl,
      ingredients: ingredients
          .map((i) => Ingredient(name: i.name, measure: i.measure))
          .toList(),
    );
  }
}

class IngredientModel {
  final String name;
  final String measure;

  const IngredientModel({required this.name, required this.measure});
}