import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vimigoassessment/calender_view.dart';
import 'package:vimigoassessment/guide_screen.dart';
import 'package:vimigoassessment/provider/appstateprovider.dart';
import 'package:vimigoassessment/reordarable_list.dart';
import 'package:vimigoassessment/transition_page.dart';


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
