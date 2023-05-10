import 'dart:io';
import 'package:ascii_rpg/actors/door.dart';
import 'models/tiles.dart';
import 'actors/item.dart';
import 'actors/player.dart';
import 'actors/room.dart';

class Game {
  // Construct actor objects
  Player player = Player();
  // Create needed lists
  List<Room> roomList = [
    Room(
        name: 'Entrance',
        size: [6, 6],
        firstDoor: Door(locked: true, pos: [0, 2]),
        secondDoor: Door(locked: false, pos: [5, 2])),
    Room(
        name: 'Living room',
        size: [10, 10],
        firstDoor: Door(locked: false, pos: [0, 2]),
        secondDoor: Door(locked: false, pos: [9, 5])),
    Room(
        name: 'Dining room',
        size: [10, 8],
        firstDoor: Door(locked: false, pos: [0, 1]),
        secondDoor: Door(locked: false, pos: [5, 0])),
    Room(
        name: 'Hallway',
        size: [5, 12],
        firstDoor: Door(locked: false, pos: [2, 11]),
        secondDoor: Door(locked: false, pos: [3, 0])),
    Room(
        name: 'Garage',
        size: [8, 8],
        firstDoor: Door(locked: false, pos: [4, 7]),
        secondDoor: Door(locked: true, pos: [7, 4])),
  ];
  List<Item> itemList = [
    Item(name: 'Key', id: 0, pos: [2, 2]),
  ];

  void run() {
    // Initial setup (Debbuging code / need to move this elsewhere)
    player.name = startScreen();
    roomList[player.currentRoomIndex].fillWithItems(items: itemList);
    // Main gameloop
    bool gameLoop = true;
    while (gameLoop) {
      print('\n' * 100);
      // Update actors
      roomList[player.currentRoomIndex].update(player: player, tiles: tiles);
      // Display room and info
      player.display();
      roomList[player.currentRoomIndex].display();
      // Get player command
      String command = stdin.readLineSync() as String;
      // Process actors
      player.process(
          command: command,
          tiles: tiles,
          room: roomList[player.currentRoomIndex],
          roomList: roomList);
    }
  }

  String startScreen() {
    print('\nxXx--- Welcome to Dart ASCII rpg ---xXx\n\n'
        'Please enter your name adventurer!\n'
        '==================================');
    return stdin.readLineSync() as String;
  }
}
