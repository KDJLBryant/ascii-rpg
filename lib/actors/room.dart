import 'package:ascii_rpg/actors/door.dart';
import 'package:ascii_rpg/actors/enemy.dart';
import 'package:ascii_rpg/models/setup.dart';
import 'package:collection/collection.dart';

import 'item.dart';

class Room {
  String name;
  String description;
  Door firstDoor;
  Door secondDoor;
  List<Item> roomItems = [];
  List<Enemy> roomEnemies = [];
  List<int> size = [];
  List<List<String>> roomTiles = [];

  Room(
      {required this.name,
      required this.description,
      required this.size,
      required this.firstDoor,
      required this.secondDoor});

  void fillWithItems({required List<Item> items}) {
    // Add items in room
    for (Item item in items) {
      roomItems.add(item);
    }
  }

  void fillWithEnemies({required List<Enemy> enemies}) {
    // Add enemies to room
    for (Enemy enemy in enemies) {
      roomEnemies.add(enemy);
    }
  }

  void update({required player, required tiles}) {
    roomTiles = [];
    List<String> row = [];

    // Update room tiles
    for (int i = 0; i < size[1]; i++) {
      // Set basic room tiles
      for (int j = 0; j < size[0]; j++) {
        if (ListEquality().equals([j, i], firstDoor.pos)) {
          row.add(tiles['door']);
        } else if (ListEquality().equals([j, i], secondDoor.pos)) {
          row.add(tiles['door']);
        } else if (i == 0 || j == 0) {
          row.add(tiles['wall']);
        } else if (j == size[0] - 1 || i == size[1] - 1) {
          row.add(tiles['wall']);
        } else {
          row.add(tiles['floor']);
        }
        // Set external actor tiles
        for (Item item in roomItems) {
          if (ListEquality().equals([j, i], item.pos)) {
            row[j] = tiles['item'];
          }
        }
        for (Enemy enemy in roomEnemies) {
          if (ListEquality().equals([j, i], enemy.pos)) {
            row[j] = tiles['enemy'];
          }
        }
        if (ListEquality().equals([j, i], player.pos)) {
          row[j] = tiles['player'];
        }
      }
      roomTiles.add(row);
      row = [];
    }
    // Process room-tied actors
    if (roomEnemies.isNotEmpty) {
      for (Enemy enemy in roomEnemies) {
        enemy.process(room: allRooms[player.currentRoomIndex], tiles: tiles);
      }
    }
  }

  String getTile(List<int> position) {
    // Get tile from specified position
    for (int i = 0; i < size[1]; i++) {
      for (int j = 0; j < size[0]; j++) {
        if (ListEquality().equals([j, i], position)) {
          return roomTiles[i][j];
        }
      }
    }
    return 'null';
  }

  void display() {
    // Display all tiles for the room and room name
    for (List<String> row in roomTiles.reversed.toList()) {
      print(row.join(' '));
    }
    print('^^^ $name ^^^\n'
        'xXx--- $description ---xXx\n');
  }
}
