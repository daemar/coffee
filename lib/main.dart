import 'package:coffee/coffee_home.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Theme(
        data: ThemeData.light(),
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'Material App',
          initialRoute: 'home',
          routes: {
            'home': (context) => const CoffeeHome(),
          },
        ));
  }
}
