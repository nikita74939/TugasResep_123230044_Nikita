import 'package:hive/hive.dart';
import '../../domain/entities/favorite_meal.dart';
part 'favorite_meal_model.g.dart';

@HiveType(typeId: 0) 
class FavoriteMealModel extends HiveObject {
  @HiveField(0)
  final String id;

  @HiveField(1)
  final String name;

  @HiveField(2)
  final String thumbnailUrl;

  FavoriteMealModel({
    required this.id,
    required this.name,
    required this.thumbnailUrl,
  });

  /// Buat dari Entity (saat menyimpan ke Hive)
  factory FavoriteMealModel.fromEntity(FavoriteMeal meal) {
    return FavoriteMealModel(
      id: meal.id,
      name: meal.name,
      thumbnailUrl: meal.thumbnailUrl,
    );
  }

  /// Konversi ke Entity (saat membaca dari Hive)
  FavoriteMeal toEntity() {
    return FavoriteMeal(
      id: id,
      name: name,
      thumbnailUrl: thumbnailUrl,
    );
  }
}