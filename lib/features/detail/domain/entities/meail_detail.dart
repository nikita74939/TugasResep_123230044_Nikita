class MealDetail {
  final String id;
  final String name;
  final String category;
  final String area; 
  final String instructions; 
  final String thumbnailUrl;
  final List<Ingredient> ingredients; 

  const MealDetail({
    required this.id,
    required this.name,
    required this.category,
    required this.area,
    required this.instructions,
    required this.thumbnailUrl,
    required this.ingredients,
  });
}

class Ingredient {
  final String name;
  final String measure;

  const Ingredient({
    required this.name,
    required this.measure,
  });

  bool get isValid => name.trim().isNotEmpty;
}