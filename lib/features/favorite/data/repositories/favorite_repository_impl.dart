import '../../domain/entities/favorite_meal.dart';
import '../../domain/repositories/favorite_repository.dart';
import '../datasources/favorite_local_datasource.dart';
import '../models/favorite_meal_model.dart';

class FavoriteRepositoryImpl implements FavoriteRepository {
  final FavoriteLocalDatasource localDatasource;

  FavoriteRepositoryImpl({required this.localDatasource});

  @override
  List<FavoriteMeal> getAllFavorites() {
    return localDatasource
        .getAllFavorites()
        .map((model) => model.toEntity())
        .toList();
  }

  @override
  Future<void> addFavorite(FavoriteMeal meal) async {
    final model = FavoriteMealModel.fromEntity(meal);
    await localDatasource.addFavorite(model);
  }

  @override
  Future<void> removeFavorite(String id) async {
    await localDatasource.removeFavorite(id);
  }

  @override
  bool isFavorite(String id) => localDatasource.isFavorite(id);
}
