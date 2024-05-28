import 'package:flutter/material.dart';
import 'package:proy_sw1/service/api_service.dart';
import 'package:proy_sw1/service/storage_service.dart';

import '../data/user.dart';
import '../data/user_data.dart';
import 'pages/BuscadorPageScreen.dart';
import 'pages/HomePageScreen.dart';
import 'pages/PerfilPageScreen.dart';

class HomeScreen extends StatefulWidget {
  final String? token;
  final String? username;

  const HomeScreen({super.key, this.token, this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  String? savedToken;
  User? _user;
  UserData? _userData;

  late List<Widget> _widgetOptions;

  @override
  void initState() {
    super.initState();
    _loadToken();
    _widgetOptions = <Widget>[
      HomePageScreen(token: widget.token, username: widget.username),
      BuscadorPageScreen(token: widget.token, username: widget.username),
      PerfilPageScreen(
        user: _user,
        userData: _userData,
      )
    ];
    _fetchUserData();
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  Future<void> _loadToken() async {
    String? token = await StorageService.getToken();
    setState(() {
      savedToken = token;
    });
    if (token != null) {
      print('TOKEN GUARDADO: $token');
    } else {
      print('NO SE ENCONTRO NINGUN TOKEN');
    }
  }

  Future<void> _fetchUserData() async {
    try {
      final apiService = ApiService();
      final response = await apiService.getUserData();
      print('RESPONSE DATA: $response');
      setState(() {
        if (response['user'] != null && response['userData'] != null) {
          _user = User.fromJson(response['user']);
          _userData = UserData.fromJson(response['userData']);

          _widgetOptions = <Widget>[
            HomePageScreen(token: widget.token, username: widget.username),
            BuscadorPageScreen(token: widget.token, username: widget.username),
            PerfilPageScreen(
              user: _user,
              userData: _userData,
            )
          ];
        } else {
          print('Response does not contain expected user data.');
        }
      });
    } catch (e) {
      print('Error fetching user data: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          automaticallyImplyLeading: false,
          title: const Text(
            'Proyecto App',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          elevation: 5,
          backgroundColor: Colors.amber[800]),
      body: Center(
        child: _widgetOptions.elementAt(_selectedIndex),
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.search),
            label: 'Buscar',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.amber[800],
        onTap: _onItemTapped,
      ),
    );
  }
}
