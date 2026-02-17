import 'dart:async';
import 'dart:math';
import 'package:flame/game.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pembuatan_game_bola/game/components/basket.dart';
import 'package:pembuatan_game_bola/game/components/fruit.dart';
import 'package:pembuatan_game_bola/game/managers/audio_manager.dart';

class FruitCatcherGame extends FlameGame with HasCollisionDetection {
  @override
  Color backgroundColor() => const Color(0xFF87CEEB);

  final ValueNotifier<int> scoreNotifier = ValueNotifier<int>(0);

  late Timer interval;

  @override
  Future<void> onLoad() async {
    await super.onLoad();

    AudioManager().playBackgroundMusic();

    add(Basket());

    interval = Timer(1.0, onTick: () => _spawnFruit(), repeat: true);
  }

  @override
  void update(double dt) {
    super.update(dt);
    interval.update(dt);
  }

  void _spawnFruit() {
    final randomX = Random().nextDouble() * size.x;

    final fixedX = randomX.clamp(20.0, size.x - 20.0);

    add(Fruit(position: Vector2(fixedX, -50)));
  }

  void incrementScore() {
    scoreNotifier.value += 1;
    AudioManager().playSfx('collect.mp3');
  }
}