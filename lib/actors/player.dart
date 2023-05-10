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
      case 'w': // Up
        {
          pos[1] += 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[1] -= 1;
          } else if (ListEquality().equals(room.secondDoor.pos, pos) &&
              room.secondDoor.locked) {
            pos[1] -= 1;
          } else if (ListEquality().equals(room.firstDoor.pos, pos) &&
              room.firstDoor.locked) {
            pos[1] -= 1;
          }
        }
        break;
      case 's': // Down
        {
          pos[1] -= 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[1] += 1;
          } else if (ListEquality().equals(room.secondDoor.pos, pos) &&
              room.secondDoor.locked) {
            pos[1] += 1;
          } else if (ListEquality().equals(room.firstDoor.pos, pos) &&
              room.firstDoor.locked) {
            pos[1] += 1;
          }
        }
        break;
      case 'd': // Left
        {
          pos[0] += 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[0] -= 1;
          } else if (ListEquality().equals(room.secondDoor.pos, pos) &&
              room.secondDoor.locked) {
            pos[0] -= 1;
          } else if (ListEquality().equals(room.firstDoor.pos, pos) &&
              room.firstDoor.locked) {
            pos[0] -= 1;
          }
        }
        break;
      case 'a': // Right
        {
          pos[0] -= 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[0] += 1;
          } else if (ListEquality().equals(room.secondDoor.pos, pos) &&
              room.secondDoor.locked) {
            pos[0] += 1;
          } else if (ListEquality().equals(room.firstDoor.pos, pos) &&
              room.firstDoor.locked) {
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

  void handleDoorInteraction(command, roomList) {
    // Move to next room
    if (ListEquality().equals(roomList[currentRoomIndex].secondDoor.pos, pos) &&
        !roomList[currentRoomIndex].secondDoor.locked) {
      currentRoomIndex += 1;
      pos = List.from(roomList[currentRoomIndex].firstDoor.pos);
    }
    // Move to previous room
    else if (ListEquality()
            .equals(roomList[currentRoomIndex].firstDoor.pos, pos) &&
        !roomList[currentRoomIndex].firstDoor.locked) {
      currentRoomIndex -= 1;
      pos = List.from(roomList[currentRoomIndex].secondDoor.pos);
    }
  }

  void process(
      {required command, required tiles, required room, required roomList}) {
    handleMove(command, tiles, room);
    handleItemPickup(command, room);
    handleDoorInteraction(command, roomList);
  }
}
