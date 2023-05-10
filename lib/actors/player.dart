import 'dart:collection';
import 'package:collection/collection.dart';

import 'item.dart';

class Player {
  String name;
  int health = 100;
  List<Item> inventory = [];
  List<int> pos = [1, 1];
  int currentRoomIndex = 0;
  List<Item> groundItems = [];

  Player({required this.name});

  void handleMove(command, tiles, room) {
    switch (command) {
      case 'w':
        {
          pos[1] += 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[1] -= 1;
          }
        }
        break;
      case 's':
        {
          pos[1] -= 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[1] += 1;
          }
        }
        break;
      case 'd':
        {
          pos[0] += 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[0] -= 1;
          }
        }
        break;
      case 'a':
        {
          pos[0] -= 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[0] += 1;
          }
        }
        break;
    }
  }

  void handleItemPickup(command, room) {
    if (command == 'e') {
      for (Item item in room.roomItems) {
        if (ListEquality().equals(item.pos, pos)) {
          print('picked up $item');
          inventory.add(room.roomItems.removeAt(room.roomItems.indexOf(item)));
          return;
        }
      }
    }
  }

  void update({required room}) {
    //...
  }

  void process({required command, required tiles, required room}) {
    handleMove(command, tiles, room);
    handleItemPickup(command, room);
  }
}
