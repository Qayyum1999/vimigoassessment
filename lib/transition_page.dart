import 'package:flutter/material.dart';

class TransitionPage extends StatelessWidget {
  final Widget child;
  final bool isLoading;
  final bool hasData;

  TransitionPage({required this.child, this.isLoading = false, this.hasData = true});

  @override
  Widget build(BuildContext context) {
    if (isLoading) {
      return Center(
        child: CircularProgressIndicator(),
      );
    } else if (hasData) {
      return child;
    } else {
      return Center(
        child: Text('No data'),
      );
    }
  }
}
