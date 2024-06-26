// ignore_for_file: use_build_context_synchronously, file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:proy_sw1/service/storage_service.dart';
import '../../../data/user.dart';
import '../../../widget/HomeScreen/BuscadorPage/UserResultWidget.dart';

class SolicitudesScreen extends StatefulWidget {
  const SolicitudesScreen({super.key});

  @override
  State<SolicitudesScreen> createState() => _SolicitudesScreenState();
}

class _SolicitudesScreenState extends State<SolicitudesScreen> {
  final Dio _dio = Dio();
  List _solicitudes = [];
  bool isLoading = true;

  Future<void> getSolicitudes() async {
    try {
      String? token = await StorageService.getToken();
      final apiLaravel = dotenv.env['API_LARAVEL'];
      final response = await _dio.get(
        '$apiLaravel/solicitudes',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      print('Status code: ${response.statusCode}');
      print('Status message: ${response.statusMessage}');
      print('Response data: ${response.data}');

      if (response.statusCode == 200) {
        final responseData = response.data;
        final List<User> solicitudes = (responseData['solicitudes'] as List)
            .map((userJson) => User.fromJson(userJson))
            .toList();
        setState(() {
          _solicitudes = solicitudes;
          isLoading = false;
        });
      } else {
        print('Error al obtener las solicitudes de amistad');
      }
    } catch (e) {
      print('--- Error: $e');
      setState(() {
        isLoading = false;
      });
    }
  }

  @override
  void initState() {
    super.initState();
    getSolicitudes();
  }

  void _handleStatusChanged() {
    getSolicitudes();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes de Amistad'),
      ),
      // body: ListSolicitudAmistadWidget(solicitudes: _solicitudes),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : _solicitudes.isEmpty
              ? const Center(
                  child: Text('No se encontraron solicitudes de amistad.'),
                )
              : Padding(
                  padding:
                      const EdgeInsets.symmetric(vertical: 10, horizontal: 1),
                  child: Column(
                    children: [
                      Expanded(
                        child: ListView.builder(
                          itemCount: _solicitudes.length,
                          itemBuilder: (context, index) {
                            final user = _solicitudes[index];
                            final userData = user.userData;

                            return UserResultWidget(
                              userData: userData,
                              user: user,
                              onStatusChanged: _handleStatusChanged,
                            );
                          },
                        ),
                      ),
                    ],
                  ),
                ),
    );
  }
}
