import 'package:hive/hive.dart';

import '../../../../core/utils/hive_helper.dart';
import '../models/favorite_meal_model.dart';

class FavoriteLocalDatasource {
  Box<FavoriteMealModel> get _box =>
      Hive.box<FavoriteMealModel>(HiveHelper.favoriteBox);

  Future<void> addFavorite(FavoriteMealModel model) async {
    await _box.put(model.id, model);
  }

  Future<void> removeFavorite(String id) async {
    await _box.delete(id);
  }

  /// Cek keberadaan resep di Hive.
  bool isFavorite(String id) => _box.containsKey(id);

  List<FavoriteMealModel> getAllFavorites() => _box.values.toList();
}