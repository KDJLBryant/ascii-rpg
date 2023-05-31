import 'package:ascii_rpg/actors/enemy.dart';
import 'package:ascii_rpg/actors/room.dart';
import 'package:ascii_rpg/actors/door.dart';
import 'package:ascii_rpg/actors/item.dart';

// Add rooms to the list for the player to navigate through
List<Room> allRooms = [
  Room(
      name: 'Entrance',
      description: 'W/A/S/D to move and E to pick up',
      size: [6, 6],
      firstDoor: Door(locked: true, id: 0, pos: [0, 2]),
      secondDoor: Door(locked: false, id: 0, pos: [5, 2])),
  Room(
      name: 'Living room',
      description: 'Find the key',
      size: [10, 10],
      firstDoor: Door(locked: false, id: 0, pos: [0, 2]),
      secondDoor: Door(locked: true, id: 1, pos: [9, 5])),
  Room(
      name: 'Dining room',
      description: 'Be careful! Kill it!',
      size: [10, 8],
      firstDoor: Door(locked: false, id: 0, pos: [0, 1]),
      secondDoor: Door(locked: true, id: 2, pos: [5, 0])),
  Room(
      name: 'Hallway',
      description: 'Explore',
      size: [5, 12],
      firstDoor: Door(locked: false, id: 0, pos: [2, 11]),
      secondDoor: Door(locked: false, id: 0, pos: [3, 0])),
  Room(
      name: 'Garage',
      description: 'End room',
      size: [8, 8],
      firstDoor: Door(locked: false, id: 0, pos: [4, 7]),
      secondDoor: Door(locked: false, id: 0, pos: [7, 4])),
];
// Create items list
List<Item> allItems = [
  Item(name: 'Key', id: 1, pos: [4, 6]),
];
// Create enemies list
List<Enemy> allEnemies = [
  Enemy(name: 'Ghost', pos: [3, 3]),
];
