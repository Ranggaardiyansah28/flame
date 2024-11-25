import 'dart:async';
import 'dart:math';

import 'package:flame/components.dart';
import 'package:flame/events.dart';
import 'package:flame/flame.dart';

class Ship extends SpriteComponent with TapCallbacks {
  late Vector2 tujuan;
  late Vector2 arah;
  double speed = 1000.0;

   Ship() {
    arah = Vector2(0, 0);
    tujuan = position;
  }
  @override
  void onMount() {
    super.onMount();
  }
 
  
  void setTujuan(DragUpdateInfo info){
    tujuan = info.eventPosition.global;
    lookAt(tujuan);
    angle += pi;
    arah = tujuan - position;
    arah = arah.normalized();
  }

  @override
  FutureOr<void> onLoad() async {
    sprite = Sprite(await Flame.images.load("ships/spaceShips_001.png"));
    position = Vector2(100, 100);
    angle = -pi/2;
    anchor = Anchor.center;
  }

  @override
  void update(double dt) {
    if((tujuan-position).length < speed) {
      position = tujuan;
      arah = Vector2(0, 0);
    }
    position.add(arah * speed);
    super.update(dt);
  }
}