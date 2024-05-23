import 'package:flutter/material.dart';

import 'BuscadorPageScreen.dart';
import 'HomePageScreen.dart';
import 'PerfilPageScreen.dart';

class HomeScreen extends StatefulWidget {
  final String token;
  final String username;

  const HomeScreen({super.key, required this.token, required this.username});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  int _selectedIndex = 0;
  
  late List<Widget> _widgetOptions;

  @override
  void initState(){
    super.initState();
    _widgetOptions = <Widget>[
      HomePageScreen(token: widget.token, username: widget.username),
      BuscadorPageScreen(token: widget.token, username: widget.username),
      PerfilPageScreen(token: widget.token, username: widget.username)
    ];
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          title: const Text(
            'Proyecto App',
            style: TextStyle(fontWeight: FontWeight.w500),
          ),
          elevation: 5,
          backgroundColor: Colors.amber[800]),
      // body: Padding(
      //   padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 20),
      //   child: Column(
      //     children: <Widget>[
      //       const Text('Home Screen'),
      //       const SizedBox(height: 150),
      //       Text('Username: ${widget.username}'),
      //       Text('Token:  ${widget.token}'),
      //     ],
      //   ),
      // ),
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
