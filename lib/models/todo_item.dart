import 'package:flutter/foundation.dart';

class TodoItem {
  final int id;
  final String title;
  final String description;
  final DateTime dueDate;
  bool isCompleted;
  int order; // add order property
  bool isDirty;

  TodoItem({
    required this.id,
    required this.title,
    required this.description,
    required this.dueDate,
    this.isCompleted = false,
    required this.order,
    required this.isDirty,
  });

  TodoItem.fromJson(Map<String, dynamic> json)
      : id = json['id'],
        title = json['title'],
        description = json['description'],
        dueDate = DateTime.parse(json['dueDate']),
        isCompleted = json['isCompleted'],
        order = json['order'],
        isDirty = json['isDirty'];
  Map<String, dynamic> toJson() => {
        'id': id,
        'title': title,
        'description': description,
        'dueDate': dueDate.toIso8601String(),
        'isCompleted': isCompleted,
        'order': order,
        'isDirty': isDirty,
      };

  TodoItem copyWith({
    int? id,
    String? title,
    String? description,
    DateTime? dueDate,
    bool? isCompleted,
    int? order,
    bool? isDirty,
  }) {
    return TodoItem(
      id: id ?? this.id,
      title: title ?? this.title,
      description: description ?? this.description,
      dueDate: dueDate ?? this.dueDate,
      isCompleted: isCompleted ?? this.isCompleted,
      order: order ?? this.order,
      isDirty: isDirty ?? this.isDirty,
    );
  }
}
