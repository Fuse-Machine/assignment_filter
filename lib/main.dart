
import 'package:filters_fc/assignment_filter.dart';
import 'package:filters_fc/home_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      initialRoute: '/assignment_filter',
      routes: {
        '/': (context) => const HomePage(),
        '/assignment_filter': (context) => const AssignmentFilter(),
      },
    );
  }
}
