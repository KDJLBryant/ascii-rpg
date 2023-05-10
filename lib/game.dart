import 'dart:io';
import 'package:ascii_rpg/actors/door.dart';

import 'models/tiles.dart';
import 'actors/item.dart';
import 'actors/player.dart';
import 'actors/room.dart';

class Game {
  // Construct actor objects
  Player player = Player(name: 'Kyle');
  // Create needed lists
  List<Room> roomList = [
    Room(
        name: 'Entrance',
        size: [6, 6],
        firstDoor: Door(action: 'none', locked: true, pos: [0, 2]),
        secondDoor: Door(action: 'forward', locked: false, pos: [5, 2])),
    Room(
        name: 'Living room',
        size: [10, 10],
        firstDoor: Door(action: 'backward', locked: false, pos: [0, 2]),
        secondDoor: Door(action: 'forward', locked: true, pos: [9, 5])),
  ];
  List<Item> itemList = [
    Item(name: 'Key', id: 0, pos: [2, 2]),
  ];

  Game();

  void run() {
    // Initial setup (Debbuging code / need to move this elsewhere)
    roomList[player.currentRoomIndex].fillWithItems(items: itemList);
    // Main gameloop
    bool gameLoop = true;
    while (gameLoop) {
      // Update actors
      player.update(room: roomList[player.currentRoomIndex]);
      roomList[player.currentRoomIndex].update(player: player, tiles: tiles);
      // Display room and info
      roomList[player.currentRoomIndex].display();
      // Get player command
      String command = stdin.readLineSync() as String;
      // Process actors
      player.process(
          command: command,
          tiles: tiles,
          room: roomList[player.currentRoomIndex]);
    }
  }

  void loadRoom(doorId) {
    if (doorId == 'forward') {
      player.currentRoomIndex += 1;
    } else if (doorId == 'backward') {
      player.currentRoomIndex -= 1;
    }
  }
}
