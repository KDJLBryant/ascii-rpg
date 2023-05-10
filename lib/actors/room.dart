import 'package:collection/collection.dart';

import 'item.dart';

class Room {
  String name;
  List<int> doorPos = [];
  List<Item> roomItems = [];
  List<int> size = [10, 10];
  List<List<String>> roomTiles = [];

  Room({required this.name, required this.doorPos});

  void fillWithItems({required List<Item> items}) {
    // Add items in room based on room name (for specific key rooms or trap room)
    for (Item item in items) {
      roomItems.add(item);
    }
  }

  void update({required player, required tiles}) {
    roomTiles = [];
    List<String> row = [];

    // Update room tiles
    for (int i = 0; i < size[1]; i++) {
      // Set basic room tiles
      for (int j = 0; j < size[0]; j++) {
        if (ListEquality().equals([j, i], doorPos)) {
          row.add(tiles['door']);
        } else if (i == 0 || j == 0) {
          row.add(tiles['wall']);
        } else if (j == size[0] - 1 || i == size[1] - 1) {
          row.add(tiles['wall']);
        } else {
          row.add(tiles['floor']);
        }
        // Set external actor tiles
        if (ListEquality().equals([j, i], player.pos)) {
          row[j] = tiles['player'];
        }
      }
      roomTiles.add(row);
      row = [];
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
    // Display all tiles for the room
    for (List<String> row in roomTiles.reversed.toList()) {
      print(row.join(' '));
    }
  }
}
