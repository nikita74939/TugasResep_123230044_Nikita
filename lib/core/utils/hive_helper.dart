import 'package:hive_flutter/hive_flutter.dart';
import '../../features/favorite/data/models/favorite_meal_model.dart';

class HiveHelper {
  static const String favoriteBox = 'favorites';

  static Future<void> init() async {
    await Hive.initFlutter();
    Hive.registerAdapter(FavoriteMealModelAdapter());
    await Hive.openBox<FavoriteMealModel>(favoriteBox);
  }

  static Box<dynamic> getFavoriteBox() => Hive.box<dynamic>(favoriteBox);

  // ── OPERASI FAVORIT ──────────────────────────────────────────────

  // Tambah resep ke favorit
  // Key menggunakan ID resep supaya mudah dicek & dihapus
  static Future<void> addFavorite(String mealId, dynamic meal) async {
    final box = getFavoriteBox();
    await box.put(mealId, meal);
  }

  // Hapus resep dari favorit berdasarkan ID
  static Future<void> removeFavorite(String mealId) async {
    final box = getFavoriteBox();
    await box.delete(mealId);
  }

  // Cek apakah resep sudah ada di favorit
  static bool isFavorite(String mealId) {
    final box = getFavoriteBox();
    return box.containsKey(mealId);
  }

  // Ambil semua resep favorit sebagai List
  static List<dynamic> getAllFavorites() {
    final box = getFavoriteBox();
    return box.values.toList();
  }

  // Hapus semua favorit
  static Future<void> clearFavorites() async {
    final box = getFavoriteBox();
    await box.clear();
  }
}
