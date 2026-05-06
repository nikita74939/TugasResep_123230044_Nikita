import '../../domain/entities/meail_detail.dart';
import '../../domain/repositories/detail_repository.dart';
import '../datasources/detail_remote_datasource.dart';

class DetailRepositoryImpl implements DetailRepository {
  final DetailRemoteDatasource remoteDatasource;

  DetailRepositoryImpl({required this.remoteDatasource});

  @override
  Future<MealDetail> getMealDetail(String id) async {
    final model = await remoteDatasource.getMealDetail(id);
    return model.toEntity();
  }
}
