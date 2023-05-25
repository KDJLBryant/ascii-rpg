import 'package:ascii_rpg/actors/enemy.dart';
import 'package:ascii_rpg/actors/room.dart';
import 'package:ascii_rpg/actors/door.dart';
import 'package:ascii_rpg/actors/item.dart';

// When creating a locked door, make sure the key is called 'Key'
// and the 'id' numbers are the same.

List<Room> allRooms = [
  Room(
      name: 'Entrance',
      description: 'Beginning room',
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
      secondDoor: Door(locked: false, id: 0, pos: [5, 0])),
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
      secondDoor: Door(locked: true, id: 0, pos: [7, 4])),
];
// Create items
List<Item> allItems = [
  Item(name: 'Key', id: 1, pos: [4, 6]),
];
// Create enemies
List<Enemy> allEnemies = [
  Enemy(name: 'Globlin', pos: [3, 3]),
];
