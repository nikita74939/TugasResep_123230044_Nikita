import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_contants.dart';
import '../models/meal_model.dart';

class MealRemoteDatasource {
  final http.Client client;

  MealRemoteDatasource({http.Client? client})
      : client = client ?? http.Client();

  Future<List<MealModel>> getMealsByCategory(String category) async {
    final url = Uri.parse(ApiConstants.filterByCategory(category));
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      // API mengembalikan null di key 'meals' jika tidak ada hasil
      if (body['meals'] == null) return [];

      final List<dynamic> mealsJson = body['meals'];
      return mealsJson
          .map((json) => MealModel.fromJson(json))
          .toList();
    } else {
      throw Exception(
        'Gagal memuat resep. Status: ${response.statusCode}',
      );
    }
  }
}