// import 'dart:async';
// import 'dart:ui';
// import 'package:flame/components.dart';
// import 'package:flame/game.dart';
// import 'package:flame/input.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter/services.dart';
//
// void main() {
//   runApp(GameScreen());
// }
//
// class GameScreen extends StatelessWidget {
//   final RunnerGame _game = RunnerGame();
//
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       home: Scaffold(
//         body: GameWidget(game: _game),
//       ),
//     );
//   }
// }
//
// class RunnerGame extends FlameGame with TapDetector {
//   late Runner runner;
//   late ScoreText scoreText;
//   late Timer _spawnTimer;
//   int score = 0;
//
//   @override
//   Future<void> onLoad() async {
//     runner = Runner(Vector2(50, size.y - 80));
//     scoreText = ScoreText();
//     add(runner);
//     add(scoreText);
//     _spawnTimer = Timer.periodic(const Duration(seconds: 2), (Timer timer) {
//       add(Hurdle(Vector2(size.x, size.y - 80)));
//     });
//   }
//
//   @override
//   void onTap() {
//     if (!runner.isJumping) {
//       runner.jump();
//     }
//   }
//
//   void increaseScore() {
//     score++;
//     scoreText.text = 'Score: $score';
//   }
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//     final runnerRect = runner.toRect();
//     children.whereType<Hurdle>().forEach((hurdle) {
//       if (runnerRect.overlaps(hurdle.toRect())) {
//         pauseEngine();
//         _spawnTimer.cancel();
//         // Handle game over logic here
//       }
//     });
//
//     children.whereType<Hurdle>().where((hurdle) => hurdle.position.x < -hurdle.size.x).toList().forEach((hurdle) {
//       hurdle.removeFromParent();
//       increaseScore();
//     });
//   }
//
//   @override
//   void onRemove() {
//     super.onRemove();
//     if (_spawnTimer.isActive) {
//       _spawnTimer.cancel();
//     }
//   }
// }
//
// class Runner extends SpriteComponent with HasGameRef<RunnerGame> {
//   bool isJumping = false;
//   double jumpSpeed = -600;
//   double gravity = 1000;
//   late final double yMax;
//
//   Runner(Vector2 position) : super(position: position, size: Vector2(48, 48)) {
//     yMax = position.y;
//   }
//
//   void jump() {
//     if (!isJumping) {
//       jumpSpeed = -600; // Reset the jump speed every time
//       isJumping = true;
//     }
//   }
//
//   @override
//   Future<void> onLoad() async {
//     sprite = await gameRef.loadSprite('runner.png');
//   }
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//     if (isJumping) {
//       position.y += jumpSpeed * dt;
//       jumpSpeed += gravity * dt;
//       if (position.y >= yMax) {
//         position.y = yMax;
//         isJumping = false;
//       }
//     }
//   }
// }
//
// class Hurdle extends SpriteComponent with HasGameRef<RunnerGame> {
//   Hurdle(Vector2 position) : super(position: position, size: Vector2(48, 48));
//
//   @override
//   Future<void> onLoad() async {
//     sprite = await gameRef.loadSprite('hurdle.png');
//   }
//
//   @override
//   void update(double dt) {
//     super.update(dt);
//     position.x -= 200 * dt; // Move the hurdle leftward
//   }
// }
//
// class ScoreText extends TextComponent with HasGameRef<RunnerGame> {
//   ScoreText() : super(text: 'Score: 0', textRenderer: TextPaint(style: TextStyle(color: Colors.black, fontSize: 24)));
//
//   @override
//   Future<void> onLoad() async {
//     position = Vector2(20, 20);
//   }
// }
