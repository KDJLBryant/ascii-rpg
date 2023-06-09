import 'dart:math';

import 'package:ascii_rpg/actors/item.dart';

class Enemy {
  String name;
  int health = 100;
  List<int> pos;
  List<Item> inventory = [];
  bool isDead = false;

  Enemy({required this.name, required this.pos});

  void addItem({required Item item}) {
    inventory.add(item);
  }

  void handleMove(room, tiles) {
    // Move the enemy based of a randomly generated number for direction
    // and prevent the enemy from moving beyond the boundries of walls and doors
    var randomNum = Random(DateTime.now().millisecondsSinceEpoch);
    var move = randomNum.nextInt(4);

    switch (move) {
      case 0: // Up
        {
          pos[1] += 1;
          if (room.getTile(pos) == tiles['wall'] ||
              room.getTile(pos) == tiles['door']) {
            pos[1] -= 1;
          }
        }
        break;
      case 1: // Down
        {
          pos[1] -= 1;
          if (room.getTile(pos) == tiles['wall'] ||
              room.getTile(pos) == tiles['door']) {
            pos[1] += 1;
          }
        }
        break;
      case 2: // Left
        {
          pos[0] += 1;
          if (room.getTile(pos) == tiles['wall'] ||
              room.getTile(pos) == tiles['door']) {
            pos[0] -= 1;
          }
        }
        break;
      case 3: // Right
        {
          pos[0] -= 1;
          if (room.getTile(pos) == tiles['wall'] ||
              room.getTile(pos) == tiles['door']) {
            pos[0] += 1;
          }
        }
        break;
    }
  }

  int handleAttack(int damage) {
    health -= damage;
    return -5;
  }

  void handleDeath() {
    if (health <= 0) {
      isDead = true;
    }
  }

  void process({required room, required tiles}) {
    // Process all member methods
    handleMove(room, tiles);
    handleDeath();
  }
}
