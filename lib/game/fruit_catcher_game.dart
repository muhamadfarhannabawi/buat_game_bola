import 'dart:math';

import 'package:flame/camera.dart';
import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/game.dart';
import 'package:flutter/widgets.dart';
import 'package:pembuatan_game_bola/game/components/basket.dart';
import 'package:pembuatan_game_bola/game/components/fruit.dart';
import 'package:pembuatan_game_bola/game/managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame
    with PanDetector, HasCollisionDetection {
  late Basket basket;
  late TextComponent scoreText;
  final Random random = Random();
  double fruitSpawnTimer = 0;
  double fruitSpawnInterval = 1.5;

  // Spawn interval decreases with difficulty
  void updateSpawnInterval() {
    fruitSpawnInterval = (1.5 - (difficultyLevel * 0.1)).clamp(0.5, 1.5);
  }

  // Difficulty level tracking
  int difficultyLevel = 1;
  int fruitsCollected = 0;

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);
  int _score = 0;

  int get score => _score;
  set score(int value) {
    _score = value;
    scoreNotifier.value = value;
  }

  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    camera.viewport = FixedResolutionViewport(resolution: Vector2(400, 800));

    basket = Basket();
    await add(basket);

    await AudioManager().initialize();
    AudioManager().playBackgroundMusic();
  }

  @override
  void update(double dt) {
    super.update(dt);

    fruitSpawnTimer += dt;
    if (fruitSpawnTimer >= fruitSpawnInterval) {
      spawnFruit();
      fruitSpawnTimer = 0;
    }
  }

  void spawnFruit() {
    final x = random.nextDouble() * size.x;
    final fruit = Fruit(position: Vector2(x, -50));
    add(fruit);
  }

  @override
  void onPanUpdate(DragUpdateInfo info) {
    basket.position.x += info.delta.global.x;
    basket.position.x = basket.position.x.clamp(
      basket.size.x / 2,
      size.x - basket.size.x / 2,
    );
  }

  void incrementScore() {
    score++;
    AudioManager().playSfx('collect.mp3');
  }

  void gameOver() {
    AudioManager().playSfx('explosion.mp3');
    pauseEngine();
  }

  @override
  void onRemove() {
    AudioManager().pauseBackgroundMusic();
    super.onRemove();
  }
}