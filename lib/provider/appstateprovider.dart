import 'package:flutter/material.dart';

import 'package:vimigoassessment/models/todo_item.dart';
import 'package:vimigoassessment/models/todo_service.dart';

class AppState {
  bool isLoading;
  List<TodoItem> items;

  AppState({this.isLoading = false, this.items = const []});

  AppState copyWith({bool? isLoading, List<TodoItem>? items}) {
    return AppState(
      isLoading: isLoading ?? this.isLoading,
      items: items ?? this.items,
    );
  }
}

class AppStateProvider with ChangeNotifier {
  AppState _state = AppState(isLoading: true);
  final TodoService _service = TodoService();

  AppState get state => _state;

  void _loadData() async {
    final items = await _service.readAll();
    _state = _state.copyWith(isLoading: false, items: items);
    notifyListeners();
  }

  void createItem(TodoItem item) async {
    await _service.create(item);
    _loadData();
  }

  void updateItem(TodoItem item) async {
    await _service.update(item);
    _loadData();
  }

  void deleteItem(int id) async {
    await _service.delete(id);
    _loadData();
  }

  void completeItem(int id) async {
    final item = await _service.read(id);
    item.isCompleted = true;
    await _service.update(item);
    _loadData();
  }

  AppStateProvider() {
    _loadData();
  }
}
