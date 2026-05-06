import '../entities/favorite_meal.dart';

abstract class FavoriteRepository {
  List<FavoriteMeal> getAllFavorites();
  Future<void> addFavorite(FavoriteMeal meal);
  Future<void> removeFavorite(String id);
  bool isFavorite(String id);
}