// ignore_for_file: file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import '../../../data/user.dart';
import '../../../service/storage_service.dart';
import '../../../widget/HomeScreen/BuscadorPage/UserResultWidget.dart';

class ListFriendScreen extends StatefulWidget {
  const ListFriendScreen({super.key, this.user});

  final User? user;

  @override
  State<ListFriendScreen> createState() => _ListFriendScreenState();
}

class _ListFriendScreenState extends State<ListFriendScreen> {
  List friends = [];
  bool isLoading = true;
  final Dio _dio = Dio();

  @override
  void initState() {
    super.initState();
    fetchFriends();
  }

  Future<void> fetchFriends() async {
    try {
      String? token = await StorageService.getToken();
      final response = await _dio.get(
        'http://192.168.100.2:8000/api/list-friends/${widget.user!.id}',
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
        if (responseData != null && responseData['list'] != null) {
          final List<User> friendsList = (responseData['list'] as List)
              .map((friendJson) => User.fromJson(friendJson))
              .toList();

          setState(() {
            friends = friendsList;
            isLoading = false;
          });
        } else {
          setState(() {
            friends = [];
            isLoading = false;
          });
        }
      }
    } catch (e) {
      // Handle request errors
      setState(() {
        isLoading = false;
      });
      print('Error: $e');
    }
  }

  void _handleStatusChanged() {
    fetchFriends();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Amigos'),
      ),
      body: isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : friends.isEmpty
              ? const Center(
                  child: Text('No friends found'),
                )
              : ListView.builder(
                  itemCount: friends.length,
                  itemBuilder: (context, index) {
                    final user = (friends[index]);
                    final userData = user.userData;

                    return UserResultWidget(
                      userData: userData,
                      user: user,
                      onStatusChanged: _handleStatusChanged,
                    );
                  },
                ),
    );
  }
}
