import 'dart:math';

class Enemy {
  String name;
  int health = 100;
  List<int> pos;
  bool following = false;

  Enemy({required this.name, required this.pos});

  void handleMove(room, tiles) {
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

  void process({required room, required tiles}) {
    handleMove(room, tiles);
  }
}
