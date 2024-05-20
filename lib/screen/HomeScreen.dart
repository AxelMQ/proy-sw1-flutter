import 'package:flutter/material.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Proyecto App'),
        elevation: 5,
        backgroundColor: Colors.black38,
        actions: [
          ElevatedButton(
            style: ButtonStyle(
              backgroundColor: const MaterialStatePropertyAll(Colors.blueGrey),
              shape: MaterialStatePropertyAll(
                RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(17),
                ),
              ),
            ),
            child: const Text(
              'Ingresar',
              style: TextStyle(color: Colors.white),
            ),
            onPressed: () {
              print('Ingresar');
            },
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 50, horizontal: 150),
        child: Column(
          children: const [
            Text('Home Screen'),
          ],
        ),
      ),
    );
  }
}
