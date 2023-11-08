import 'package:flutter/material.dart';
import 'package:game/AppModule/Auth/authController.dart';
import 'package:game/Utils/AppText.dart';
import 'dart:async';
import 'package:flutter/material.dart';
import 'package:get/get.dart';



void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Roche Game',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: JumpGameScreen(),
    );
  }
}

class JumpGameScreen extends StatefulWidget {
  @override
  _JumpGameScreenState createState() => _JumpGameScreenState();
}

class _JumpGameScreenState extends State<JumpGameScreen> {
  double characterYAxis = 0;
  double hurdleXAxis = 2;
  bool gameHasStarted = false;

  void startGame() {
    gameHasStarted = true;
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        hurdleXAxis -= 0.05;
      });

      if (hurdleXAxis < -1.5) { // Hurdle has left the screen
        hurdleXAxis = 2; // Reset hurdle position
      }
    });
  }

  void jump() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        if (characterYAxis < 1) {
          characterYAxis += 0.1;
        }
      });

      if (characterYAxis >= 1) {
        timer.cancel();
        fall();
      }
    });
  }

  void fall() {
    Timer.periodic(Duration(milliseconds: 50), (timer) {
      setState(() {
        if (characterYAxis > 0) {
          characterYAxis -= 0.1;
        }
      });

      if (characterYAxis <= 0) {
        timer.cancel();
        characterYAxis = 0;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: gameHasStarted ? jump : startGame,
      child: Scaffold(
        body: Column(
          children: [
            Expanded(
              flex: 3,
              child: Stack(
                children: [
                  AnimatedContainer(
                    alignment: Alignment(0, characterYAxis),
                    duration: Duration(milliseconds: 0),
                    color: Colors.blue[200],
                    child: MyCharacter(),
                  ),
                  AnimatedContainer(
                    alignment: Alignment(hurdleXAxis, 1),
                    duration: Duration(milliseconds: 0),
                    child: MyHurdle(),
                  ),
                ],
              ),
            ),
            Expanded(
              child: Container(
                color: Colors.green,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Text(
                      'Score: 0',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                    Text(
                      'Best: 0',
                      style: TextStyle(color: Colors.white, fontSize: 35),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class MyCharacter extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      child: Icon(Icons.directions_run, color: Colors.white),
    );
  }
}

class MyHurdle extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: 50,
      height: 50,
      color: Colors.brown,
    );
  }
}