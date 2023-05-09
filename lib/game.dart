import 'dart:io';
import 'models/tiles.dart';
import 'actors/item.dart';
import 'actors/player.dart';
import 'actors/room.dart';

class Game {
  Player player = Player(name: 'Kyle');
  Room room = Room(name: 'TestRoom');
  List<Item> itemList = [
    Item(name: 'Key', id: 0, pos: [2, 2])
  ];
  Game();

  void run() {
    // Initial setup
    room.fillWithItems(items: itemList);

    // Main gameloop
    bool gameLoop = true;
    while (gameLoop) {
      // Update actors
      player.update(room: room);
      room.update(player: player, tiles: tiles);
      // Display room and info
      room.display();
      // Get player command
      String command = stdin.readLineSync() as String;
      // Process actors
      player.process(command: command, tiles: tiles, room: room);
    }
  }
}
