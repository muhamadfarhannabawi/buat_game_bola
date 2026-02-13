import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Fruit Cather Game',
      home: const GameScreen
      ):
  }
}

class GameScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Text('Game akan ditampilkan disini'),
      ),
    );
  }
}

class GameScreen extends StatefulWidget { 
  const GameScreen({super.key});

@override 
State <GameScreen> createState() => _GameScreenState();
}


class _GameScreenState extends State<GameScreen> {


  @override
  void initState() {
    super.initState();
  }

@override
Widget build(BuildContext context) {
  return Scaffold(
    body: Stack(
      children: [
        Positioned(
          top: 50,
          left: 20,
          child: Container(
            padding: const EdgeInsets.all(10),
            decoration: BoxDecoration(
              color: Colors.black54,
              borderRadius: BorderRadius.circular(10),
            ),
            child: const Text(
              'Score: 1',
              style: TextStyle(
                color: Colors.white,
                fontSize: 24,
                fontWeight: FontWeight.bold,
              ),
            ),
          ), // Container

        ), // Positioned
      ],
    ),
  );
}

}
class GameScreen extends StatefulWidget {
  const GameScreen ({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [

          // Positioned lain (jika ada)
          Positioned(
            top: 50,
            left: 20,
            child: Container(
              padding: const EdgeInsets.all(10),
              color: Colors.black54,
              child: const Text(
                'Score: 1',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ),

          // Penambahan icon di kanan atas
          Positioned(
            top: 50,
            right: 20,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(
                    Icons.music_note,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
                IconButton(
                  icon: const Icon(
                    Icons.volume_up,
                    color: Colors.black,
                  ),
                  onPressed: () {},
                ),
              ],
            ), // Row
          ), // Positioned
        ], // Children
      ), // Stack
    );
  }

}


