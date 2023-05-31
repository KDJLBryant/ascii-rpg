import 'dart:io';
import 'package:ascii_rpg/actors/enemy.dart';

import 'models/tiles.dart';
import 'models/setup.dart';
import 'actors/item.dart';
import 'actors/player.dart';
import 'actors/room.dart';

class Game {
  // Initialize variables
  Player player = Player();
  List<Room> roomList = [];
  List<Item> itemList = [];
  List<Enemy> enemyList = [];

  void run() {
    // Initialize player and rooms
    startScreen();
    // Main gameloop
    bool gameLoop = true;
    while (gameLoop) {
      print('\n' * 100);
      checkIfFinished();
      // Update actors
      roomList[player.currentRoomIndex].update(player: player, tiles: tiles);
      // Display room and info
      player.display();
      roomList[player.currentRoomIndex].display();
      // Get player command
      String command = stdin.readLineSync() as String;
      // Process actors
      player.process(
          command: command.toLowerCase(),
          tiles: tiles,
          room: roomList[player.currentRoomIndex],
          roomList: roomList);
    }
  }

  void startScreen() {
    player = Player();
    // Assign the rooms and items from the setup file to the room and item lists
    roomList = allRooms;
    itemList = allItems;
    enemyList = allEnemies;
    // Give the Ghost enemy a key to drop when killed
    enemyList[0].addItem(item: Item(name: 'Key', id: 2, pos: [0, 0]));
    // Place the items and enemies to the indexed rooms
    roomList[1].fillWithItems(items: itemList);
    roomList[2].fillWithEnemies(enemies: allEnemies);

    // Start the game with the player writing their desired name
    print('\nxXx--- Welcome to Dart ASCII rpg ---xXx\n\n'
        'Please enter your name adventurer!\n'
        '==================================');
    String name = stdin.readLineSync() as String;
    player.name = name;
  }

  void checkIfFinished() {
    // Check if the player has surpassed the length of the room list for ending the game
    // and allow the player to restart if wanted
    if (player.currentRoomIndex == roomList.length) {
      print(
          'xXx--- You have completed the game! ---xXx\nWould you like to continue (y/n): ');
      String choice = stdin.readLineSync() as String;

      if (choice.toLowerCase() == 'y') {
        startScreen();
      } else {
        exit(0);
      }
    }
  }
}
