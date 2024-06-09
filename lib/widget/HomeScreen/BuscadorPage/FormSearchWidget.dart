// ignore_for_file: file_names, prefer_typing_uninitialized_variables, override_on_non_overriding_member
import 'dart:async';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../data/user.dart';
import '../../../service/storage_service.dart';
import 'TextFieldSearchWidget.dart';
import 'UserResultWidget.dart';

class FormSearchWidget extends StatefulWidget {
  const FormSearchWidget({
    super.key,
  });

  @override
  State<FormSearchWidget> createState() => _FormSearchWidgetState();
}

class _FormSearchWidgetState extends State<FormSearchWidget> {
  final TextEditingController _searchController = TextEditingController();
  final Dio _dio = Dio();
  List _searchResults = [];
  Timer? _debounce;

   @override
  void initState() {
    super.initState();
    _searchController.addListener(_onSearchChanged);
  }

  @override
  void disponse() {
    _searchController.removeListener(_onSearchChanged);
    _searchController.dispose();
    _debounce?.cancel();
    super.dispose();
  }

    _onSearchChanged() {
    if (_debounce?.isActive ?? false) _debounce!.cancel();
    _debounce = Timer(const Duration(milliseconds: 150), () {
      if (_searchController.text.isNotEmpty) {
        searchUsers(_searchController.text);
      } else {
        setState(() {
          _searchResults = [];
        });
      }
    });
  }

  Future<void> searchUsers(String query) async {
    try {
      String? token = await StorageService.getToken();
      // print('--> Token: $token');
      final response = await _dio.get(
        'http://192.168.100.2:8000/api/search-users',
        queryParameters: {'query': query},
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
        // final users = response.data['users'];
        final List<User> users = (response.data['users'] as List)
            .map((userJson) => User.fromJson(userJson))
            .toList();

        setState(() {
          _searchResults = users;
        });
      } else {
        print('Error al buscar usuarios');
      }
    } catch (e) {
      print('Error: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 8),
      child: Column(
        children: [
          // const Text('Pagina de Buscador'),
          TextFieldSearchWidget(
            searchController: _searchController,
            onTap: () {
              // searchUsers(_searchController.text);
              print(_searchController.text);
              // print('---> BUSCAR USERNAME');
               _searchController.clear();
                  setState(() {
                    _searchResults = [];
                  });
            },
          ),
          const SizedBox(height: 10),
          Expanded(
            child: ListView.builder(
              itemCount: _searchResults.length,
              itemBuilder: (context, index) {
                final user = _searchResults[index];
                final userData = user.userData;

                return UserResultWidget(userData: userData, user: user);
              },
            ),
          ),
        ],
      ),
    );
  }
}
