import 'package:dio/dio.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proy_sw1/service/storage_service.dart';

class ApiService {
  final Dio _dio = Dio();

  Future<Map<String, dynamic>> getUserData() async {
    String? token = await StorageService.getToken();
    final apiLaravel = dotenv.env['API_LARAVEL'];
    final response = await _dio.get(
      '$apiLaravel/user',
      options: Options(
        headers: {
          'Authorization': 'Bearer $token',
        },
      ),
    );

    if (response.statusCode == 200) {
      return response.data;
    } else {
      throw Exception('Failed to load user data');
    }
  }
}
