import 'package:collection/collection.dart';
import 'item.dart';

class Player {
  String name = '';
  int health = 100;
  List<Item> inventory = [];
  List<int> pos = [1, 1];
  int currentRoomIndex = 0;

  void handleMove(command, tiles, room, roomList) {
    switch (command) {
      case 'w': // Up
        {
          pos[1] += 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[1] -= 1;
          } else if (room.getTile(pos) == tiles['door']) {
            pos[1] -= handleLockedDoor(roomList);
          }
        }
        break;
      case 's': // Down
        {
          pos[1] -= 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[1] += 1;
          } else if (room.getTile(pos) == tiles['door']) {
            pos[1] += handleLockedDoor(roomList);
          }
        }
        break;
      case 'd': // Left
        {
          pos[0] += 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[0] -= 1;
          } else if (room.getTile(pos) == tiles['door']) {
            pos[0] -= handleLockedDoor(roomList);
          }
        }
        break;
      case 'a': // Right
        {
          pos[0] -= 1;
          if (room.getTile(pos) == tiles['wall']) {
            pos[0] += 1;
          } else if (room.getTile(pos) == tiles['door']) {
            pos[0] += handleLockedDoor(roomList);
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

  int handleLockedDoor(roomList) {
    // Check and unlock locked 'first door' if the key is present
    if (ListEquality().equals(roomList[currentRoomIndex].secondDoor.pos, pos)) {
      if (roomList[currentRoomIndex].secondDoor.locked) {
        for (Item item in inventory) {
          if (item.name == 'Key' &&
              item.id == roomList[currentRoomIndex].secondDoor.id) {
            inventory.remove(item);
            roomList[currentRoomIndex].secondDoor.locked = false;
            return 0;
          } else {
            return 1;
          }
        }
        return 1;
      }
    }
    // Check and unlock locked 'second door' if the key is present
    else if (ListEquality()
        .equals(roomList[currentRoomIndex].firstDoor.pos, pos)) {
      if (roomList[currentRoomIndex].firstDoor.locked) {
        for (Item item in inventory) {
          if (item.name == 'Key' &&
              item.id == roomList[currentRoomIndex].firstDoor.id) {
            inventory.remove(item);
            roomList[currentRoomIndex].secondDoor.locked = false;
            return 0;
          } else {
            return 1;
          }
        }
        return 1;
      }
    }
    return 0;
  }

  void handleRoomChange(roomList) {
    // Move to next room
    if (ListEquality().equals(roomList[currentRoomIndex].secondDoor.pos, pos)) {
      currentRoomIndex += 1;
      pos = List.from(roomList[currentRoomIndex].firstDoor.pos);
    }
    // Move to previous room
    else if (ListEquality()
        .equals(roomList[currentRoomIndex].firstDoor.pos, pos)) {
      currentRoomIndex -= 1;
      pos = List.from(roomList[currentRoomIndex].secondDoor.pos);
    }
  }

  void display() {
    // display player info
    print('xXx--- $name ---xXx\n'
        'Health: $health\n'
        '¬¬¬ Inventory ¬¬¬');
    if (inventory.isEmpty) {
      print('...is empty');
    } else {
      for (Item item in inventory) {
        print(item.name);
      }
    }
    print('xXx' + '-' * (name.length + 8) + 'xXx');
    print('\n');
  }

  void process(
      {required command, required tiles, required room, required roomList}) {
    handleMove(command, tiles, room, roomList);
    handleItemPickup(command, room);
    handleRoomChange(roomList);
  }
}
