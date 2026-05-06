import '../../domain/entities/meal.dart';
import '../../domain/repositories/repository.dart';
import '../datasources/meal_remote_datasource.dart';

class MealRepositoryImpl implements MealRepository {
  final MealRemoteDatasource remoteDatasource;

  MealRepositoryImpl({required this.remoteDatasource});

  @override
  Future<List<Meal>> getMealsByCategory(String category) async {
    // Panggil datasource → dapat List<MealModel>
    final models = await remoteDatasource.getMealsByCategory(category);

    // Konversi tiap model ke entity sebelum dikirim ke presentation
    return models.map((model) => model.toEntity()).toList();
  }
}
