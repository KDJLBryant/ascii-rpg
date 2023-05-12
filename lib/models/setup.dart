import 'package:ascii_rpg/actors/room.dart';
import 'package:ascii_rpg/actors/door.dart';
import 'package:ascii_rpg/actors/item.dart';

// When creating a locked room, make sure the key is called 'Key'
// and the 'id' numbers are the same.

List<Room> allRooms = [
  Room(
      name: 'Entrance',
      size: [6, 6],
      firstDoor: Door(locked: true, id: 0, pos: [0, 2]),
      secondDoor: Door(locked: false, id: 0, pos: [5, 2])),
  Room(
      name: 'Living room',
      size: [10, 10],
      firstDoor: Door(locked: false, id: 0, pos: [0, 2]),
      secondDoor: Door(locked: true, id: 1, pos: [9, 5])),
  Room(
      name: 'Dining room',
      size: [10, 8],
      firstDoor: Door(locked: false, id: 0, pos: [0, 1]),
      secondDoor: Door(locked: false, id: 0, pos: [5, 0])),
  Room(
      name: 'Hallway',
      size: [5, 12],
      firstDoor: Door(locked: false, id: 0, pos: [2, 11]),
      secondDoor: Door(locked: false, id: 0, pos: [3, 0])),
  Room(
      name: 'Garage',
      size: [8, 8],
      firstDoor: Door(locked: false, id: 0, pos: [4, 7]),
      secondDoor: Door(locked: true, id: 0, pos: [7, 4])),
];
// Create items
List<Item> allItems = [
  Item(name: 'Key', id: 1, pos: [8, 3]),
];
