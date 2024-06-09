// ignore_for_file: use_build_context_synchronously
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:proy_sw1/service/storage_service.dart';
import '../../../data/friendship.dart';
import '../../../widget/HomeScreen/BuscadorPage/UserFriend/ListSolicitudAmistadWidget.dart';

class SolicitudesScreen extends StatefulWidget {
  const SolicitudesScreen({super.key});

  @override
  State<SolicitudesScreen> createState() => _SolicitudesScreenState();
}

class _SolicitudesScreenState extends State<SolicitudesScreen> {
  final Dio _dio = Dio();
  List<Friendship> _solicitudes = [];

  Future<void> getSolicitudes() async {
    try {
      String? token = await StorageService.getToken();
      final response = await _dio.get(
        'http://192.168.100.2:8000/api/solicitudes',
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
        final List solicitudes = response.data['solicitudes'];
        setState(() {
          _solicitudes =
              solicitudes.map((json) => Friendship.fromJson(json)).toList();
        });
      } else {
        print('Error al obtener las solicitudes de amistad');
      }
    } catch (e) {
      print('--- Error: $e');
    }
  }

  @override
  void initState() {
    super.initState();
    getSolicitudes();

  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Solicitudes de Amistad'),
      ),
      body: ListSolicitudAmistadWidget(solicitudes: _solicitudes),
    );
  }
}

