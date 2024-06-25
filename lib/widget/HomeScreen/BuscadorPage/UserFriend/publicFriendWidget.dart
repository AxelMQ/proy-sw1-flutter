// ignore_for_file: camel_case_types, file_names
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:proy_sw1/screen/pages/UserFriend/ListFriendScreen.dart';
import '../../../../data/user.dart';
import '../../../../service/storage_service.dart';

class publicFriendWidget extends StatefulWidget {
  const publicFriendWidget({
    super.key,
    this.user,
    required this.onStatusChanged,
  });

  final User? user;
  final Function() onStatusChanged;

  @override
  State<publicFriendWidget> createState() => PublicFriendWidgetState();
}

class PublicFriendWidgetState extends State<publicFriendWidget> {
  int? _friendsCount;

  @override
  void initState() {
    super.initState();
    _fetchFriendsCount();
  }

  Future<void> _fetchFriendsCount() async {
    try {
      int? count = await fetchFriendsCount(widget.user!.id);
      if (mounted) {
      setState(() {
        _friendsCount = count;
      });
    }
    } catch (e) {
      print('Error fetching friends count: $e');
    }
  }

  Future<void> _updateFriendsCount() async {
    try {
      int? count = await fetchFriendsCount(widget.user!.id);
      if (mounted) {
      setState(() {
        _friendsCount = count;
      });
      widget.onStatusChanged();
    }
    } catch (e) {
      print('Error updating friends count: $e');
    }
  }

  Future<int?> fetchFriendsCount(int userId) async {
    try {
      String? token = await StorageService.getToken();
      final apiLaravel = dotenv.env['API_LARAVEL'];
      final response = await Dio().get(
        '$apiLaravel/user/$userId/friendsCount',
        options: Options(
          headers: {
            'Authorization': 'Bearer $token',
          },
          validateStatus: (status) {
            return status! < 500;
          },
        ),
      );

      if (response.statusCode == 200) {
        print('...DATA ${response.data}');
        return response.data['friendsCount'];
      } else {
        print('Error fetching friends count: ${response.statusMessage}');
        return null;
      }
    } catch (e) {
      print('Exception: $e');
      return null;
    }
  }

  void refreshFriendsCount(){
    _fetchFriendsCount();
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<int?>(
      future: fetchFriendsCount(widget.user!.id),
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Text('Error: ${snapshot.error}');
        } else if (snapshot.hasData) {
          _friendsCount = snapshot.data;
          return Row(
            children: [
              Column(
                children: [
                  Text(
                    widget.user!.id.toString(),
                    style: GoogleFonts.titilliumWeb(
                        fontWeight: FontWeight.w800, fontSize: 18),
                  ),
                  Text(
                    'publicaciones',
                    style: GoogleFonts.titilliumWeb(
                        fontWeight: FontWeight.w500, fontSize: 18),
                  ),
                ],
              ),
              const SizedBox(width: 15),
              InkWell(
                onTap: () async {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ListFriendScreen(user: widget.user),
                    ),
                  );
                  await _updateFriendsCount();
                  widget.onStatusChanged();
                },
                child: Column(
                  children: [
                    Text(
                      _friendsCount?.toString() ?? 'N/A',
                      style: GoogleFonts.titilliumWeb(
                          fontWeight: FontWeight.w800, fontSize: 18),
                    ),
                    Text(
                      'amigos',
                      style: GoogleFonts.titilliumWeb(
                          fontWeight: FontWeight.w500, fontSize: 18),
                    ),
                  ],
                ),
              ),
            ],
          );
        } else {
          return const Text('No data available');
        }
      },
    );
  }
}
