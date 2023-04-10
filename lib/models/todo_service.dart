import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'todo_item.dart';

class TodoService {
  static const String _storageKey = 'todo_items';

  Future<List<TodoItem>> readAll() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_storageKey);

    if (jsonString == null) {
      return [];
    }

    final jsonList = json.decode(jsonString) as List<dynamic>;
    final items = jsonList.map((json) => TodoItem.fromJson(json)).toList();

    return items;
  }

  Future<TodoItem> read(int id) async {
    final items = await readAll();
    final item = items.firstWhere((item) => item.id == id, orElse: () {
      throw Exception('Item not found');
    });
    return item;
  }

  Future<void> create(TodoItem item) async {
    final items = await readAll();

    final newId =
        items.isNotEmpty ? items.map((item) => item.id).reduce(max) + 1 : 1;
    final newItem = item.copyWith(id: newId);

    items.add(newItem);
    final jsonList = items.map((item) => item.toJson()).toList();
    final jsonString = json.encode(jsonList);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonString);
  }

  Future<void> update(TodoItem item) async {
    final items = await readAll();
    final index = items.indexWhere((i) => i.id == item.id);

    if (index >= 0) {
      items[index] = item;
      final jsonList = items.map((item) => item.toJson()).toList();
      final jsonString = json.encode(jsonList);

      final prefs = await SharedPreferences.getInstance();
      await prefs.setString(_storageKey, jsonString);
    }
  }

  Future<void> delete(int id) async {
    final items = await readAll();
    items.removeWhere((item) => item.id == id);
    final jsonList = items.map((item) => item.toJson()).toList();
    final jsonString = json.encode(jsonList);

    final prefs = await SharedPreferences.getInstance();
    await prefs.setString(_storageKey, jsonString);
  }
}
