import '../../domain/entities/meal.dart';

class MealModel {
  final String id;
  final String name;
  final String thumbnailUrl;

  const MealModel({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['idMeal'] ?? '',
      name: json['strMeal'] ?? '',
      thumbnailUrl: json['strMealThumb'] ?? '',
    );
  }

  Meal toEntity() {
    return Meal(
      id: id,
      name: name,
      thumbnailUrl: thumbnailUrl,
    );
  }
}