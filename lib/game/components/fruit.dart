import 'dart:math';
import 'package:flame/collisions.dart';
import 'package:flame/components.dart';
import 'package:flutter/material.dart';
import 'package:pembuatan_game_bola/game/fruit_catcher_game.dart';
import 'basket.dart';

enum FruitType { apple, banana, orange, strawberry }

class Fruit extends PositionComponent
    with HasGameRef<FruitCatcherGame>, CollisionCallbacks {
  final FruitType type;
  final double fallSpeed = 200;

  Fruit({super.position})
    : type = FruitType.values[Random().nextInt(FruitType.values.length)],
      super(size: Vector2.all(40));

  @override
  Future<void> onLoad() async {
    await super.onLoad();
    anchor = Anchor.center;
    add(CircleHitbox());
  }

  @override
  void update(double dt) {
    super.update(dt);
    position.y += fallSpeed * dt;

    if (position.y > gameRef.size.y + 50) {
      removeFromParent();
    }
  }

  @override
  void onCollision(Set<Vector2> intersectionPoints, PositionComponent other) {
    super.onCollision(intersectionPoints, other);
    if (other is Basket) {
      gameRef.incrementScore();
      removeFromParent();
    }
  }

  @override
  void render(Canvas canvas) {
    final w = size.x;
    final h = size.y;
    final cx = w / 2;
    final cy = h / 2;

    final bodyPaint = Paint()..color = Colors.blue;
    final bodyRect = Rect.fromCenter(
      center: Offset(cx, cy),
      width: w * 0.55,
      height: h * 0.9,
    );
    canvas.drawOval(bodyRect, bodyPaint);

    final headPaint = Paint()
      ..color = Color.lerp(Colors.green, Colors.black, 0.3)!;
    final headRadius = h * 0.25;
    canvas.drawCircle(Offset(cx, cy - h * 0.3), headRadius, headPaint);

    final eyePaint = Paint()..color = Colors.white;
    final pupilPaint = Paint()..color = Colors.black;
    final eyeRadius = h * 0.08;
    final pupilRadius = h * 0.04;
    final eyeY = cy - h * 0.32;

    canvas.drawCircle(Offset(cx - h * 0.1, eyeY), eyeRadius, eyePaint);
    canvas.drawCircle(Offset(cx - h * 0.1, eyeY), pupilRadius, pupilPaint);
    canvas.drawCircle(Offset(cx + h * 0.1, eyeY), eyeRadius, eyePaint);
    canvas.drawCircle(Offset(cx + h * 0.1, eyeY), pupilRadius, pupilPaint);

    final antennaPaint = Paint()
      ..color = Color.lerp(const Color(0xff577590), Colors.black, 0.3)!
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    canvas.drawLine(
      Offset(cx - h * 0.08, cy - h * 0.45),
      Offset(cx - h * 0.2, cy - h * 0.55),
      antennaPaint,
    );
    canvas.drawCircle(
      Offset(cx - h * 0.2, cy - h * 0.55),
      2,
      Paint()..color = Colors.blueGrey,
    );

    canvas.drawLine(
      Offset(cx + h * 0.08, cy - h * 0.45),
      Offset(cx + h * 0.2, cy - h * 0.55),
      antennaPaint,
    );
    canvas.drawCircle(
      Offset(cx + h * 0.2, cy - h * 0.55),
      2,
      Paint()..color = Colors.blueAccent,
    );

    final linePaint = Paint()
      ..color = Color.lerp(Colors.blue, Colors.black, 0.2)!
      ..strokeWidth = 1.5;
    canvas.drawLine(
      Offset(cx, cy - h * 0.15),
      Offset(cx, cy + h * 0.35),
      linePaint,
    );

    final spotPaint = Paint()
      ..color = Color.lerp(Colors.yellow, Colors.white, 0.5)!;
    final spotRadius = h * 0.05;
    canvas.drawCircle(
      Offset(cx - w * 0.1, cy + h * 0.05),
      spotRadius,
      spotPaint,
    );
    canvas.drawCircle(
      Offset(cx + w * 0.1, cy + h * 0.05),
      spotRadius,
      spotPaint,
    );
    canvas.drawCircle(
      Offset(cx - w * 0.08, cy + h * 0.2),
      spotRadius,
      spotPaint,
    );
    canvas.drawCircle(
      Offset(cx + w * 0.08, cy + h * 0.2),
      spotRadius,
      spotPaint,
    );

    final legPaint = Paint()
      ..color = Color.lerp(Colors.red, Colors.black, 0.3)!
      ..strokeWidth = 1.5
      ..style = PaintingStyle.stroke;

    for (var i = 0; i < 3; i++) {
      final legY = cy - h * 0.05 + i * h * 0.17;
      canvas.drawLine(
        Offset(cx - w * 0.22, legY),
        Offset(cx - w * 0.38, legY - h * 0.08),
        legPaint,
      );
      canvas.drawLine(
        Offset(cx + w * 0.22, legY),
        Offset(cx + w * 0.38, legY - h * 0.08),
        legPaint,
      );
    }
  }
}