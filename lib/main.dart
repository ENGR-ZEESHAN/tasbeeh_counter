import 'package:flutter/material.dart';
import 'package:tasbeeh_counter/pages/counters_page.dart';
import 'package:tasbeeh_counter/pages/create_tasbeeh_page.dart';
import 'package:tasbeeh_counter/utils/themes.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: MyTheme.lightTheme(),
        initialRoute: 'home',
        routes: {
          'home': (context) => const MyCounters(),
          'createTasbeeh': (context) => CreateTasbeeh(),
          // 'TasbeehCounter': (_) => TasbeehCounter(),
        });
  }
}
