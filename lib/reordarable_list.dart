import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:provider/provider.dart';

import 'package:vimigoassessment/models/todo_item.dart';
import 'package:vimigoassessment/models/todo_service.dart';
import 'package:vimigoassessment/provider/appstateprovider.dart';


class ReorderableListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<AppStateProvider>(context);
    final items = provider.state.items;

    return ReorderableList(
      onReorder: (oldIndex, newIndex) {
        // Handle the list item reordering
      },
      child: ListView.builder(
        itemCount: items.length,
        itemBuilder: (context, index) {
          final item = items[index];

          return ListTile(
            key: Key('${item.id}'),
            title: Text(item.title),
            subtitle: Text(item.description),
            trailing: Text(item.dueDate.toString()),
            leading: Checkbox(
              value: item.isCompleted,
              onChanged: (value) {
                provider.completeItem(item.id);
              },
            ),
            onTap: () {
              // Navigate to the details screen
            },
          );
        },
      ),
    );
  }
}
