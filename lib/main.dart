import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

 

void main() {
  runApp(
    ChangeNotifierProvider(
      create: (context) => AppStateProvider(),
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'My To-Do App',
        theme: ThemeData(
          primarySwatch: Colors.blue,
          visualDensity: VisualDensity.adaptivePlatformDensity,
        ),
        initialRoute: '/',
        routes: {
          '/': (context) => GuideScreen(),
          '/list': (context) => TransitionPage(
                child: ReorderableListScreen(),
                isLoading: Provider.of<AppStateProvider>(context).state.isLoading,
                hasData: Provider.of<AppStateProvider>(context).state.items.isNotEmpty,
              ),
          '/calendar': (context) => CalendarView(),
          '/create': (context) => TodoFormScreen(),
          '/edit': (context) => TodoFormScreen(
                item: ModalRoute.of(context).settings.arguments,
              ),
          '/details': (context) => TodoDetailsScreen(
                itemId: ModalRoute.of(context).settings.arguments,
              ),
        },
      ),
    ),
  );
}
