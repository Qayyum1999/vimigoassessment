import 'package:flutter/material.dart';
import 'package:flutter_reorderable_list/flutter_reorderable_list.dart';
import 'package:provider/provider.dart';

import 'package:vimigoassessment/models/todo_item.dart';
import 'package:vimigoassessment/models/todo_service.dart';
import 'package:vimigoassessment/provider/appstateprovider.dart';

class ReorderableListScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('My To-Do List'),
        actions: [
          IconButton(
            icon: Icon(Icons.calendar_today),
            onPressed: () => Navigator.pushNamed(context, '/calendar'),
          ),
        ],
      ),
      body: Consumer<AppStateProvider>(
        builder: (context, provider, child) {
          if (provider.state.isLoading) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else if (provider.state.items.isEmpty) {
            return Center(
              child: Text('No items found'),
            );
          } else {
            return ReorderableListView.builder(
              padding: EdgeInsets.symmetric(vertical: 8.0),
              itemCount: provider.state.items.length,
              onReorder: (oldIndex, newIndex) {
                if (oldIndex < newIndex) {
                  newIndex -= 1;
                }
                final item = provider.state.items.removeAt(oldIndex);
                provider.state.items.insert(newIndex, item);
                item.order = newIndex;
                item.isDirty = true;
                for (int i = 0; i < provider.state.items.length; i++) {
                  if (i == newIndex) {
                    continue;
                  }
                  final otherItem = provider.state.items[i];
                  if (otherItem.order >= newIndex) {
                    otherItem.order += 1;
                    otherItem.isDirty = true;
                  }
                }
                provider.updateItem(item);
              },
              itemBuilder: (context, index) {
                final item = provider.state.items[index];
                return TodoTile(
                  item: item,
                  onTap: () => Navigator.pushNamed(context, '/details', arguments: item.id),
                  onCheckboxChanged: (_) {
                    provider.completeItem(item.id);
                  },
                );
              },
            );
          }
        },
      ),
      floatingActionButton: FloatingActionButton(
        child: Icon(Icons.add),
        onPressed: () => Navigator.pushNamed(context, '/create'),
      ),
    );
  }
}