import '../entities/meail_detail.dart';

abstract class DetailRepository {
  Future<MealDetail> getMealDetail(String id);
}