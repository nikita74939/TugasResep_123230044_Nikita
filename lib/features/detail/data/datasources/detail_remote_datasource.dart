import 'dart:convert';
import 'package:http/http.dart' as http;
import '../../../../core/constants/api_contants.dart';
import '../models/meal_detail_model.dart';

class DetailRemoteDatasource {
  final http.Client client;

  DetailRemoteDatasource({http.Client? client})
      : client = client ?? http.Client();

  Future<MealDetailModel> getMealDetail(String id) async {
    final url = Uri.parse(ApiConstants.mealDetail(id));
    final response = await client.get(url);

    if (response.statusCode == 200) {
      final Map<String, dynamic> body = json.decode(response.body);

      if (body['meals'] == null) {
        throw Exception('Resep dengan id $id tidak ditemukan.');
      }

      return MealDetailModel.fromJson(body['meals'][0]);
    } else {
      throw Exception(
        'Gagal memuat detail resep. Status: ${response.statusCode}',
      );
    }
  }
}