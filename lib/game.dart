import 'dart:io';
import 'models/tiles.dart';
import 'models/setup.dart';
import 'actors/item.dart';
import 'actors/player.dart';
import 'actors/room.dart';

class Game {
  // Construct actor objects
  Player player = Player();
  // Get rooms from setup
  List<Room> roomList = allRooms;
  // Get items from setup
  List<Item> itemList = allItems;

  void run() {
    // Initial setup (Debbuging code / need to move this elsewhere)
    player.name = startScreen();
    roomList[1].fillWithItems(items: itemList);
    roomList[2].fillWithEnemies(enemies: allEnemies);
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
