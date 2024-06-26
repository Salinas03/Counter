import 'package:flutter/material.dart';
import 'package:wear/wear.dart';

import 'counter/counter_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context){
    return AmbientMode(
      child: const CounterPage(),
      builder: (context, mode, child){
        return MaterialApp(
          title: 'Counter wear',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            visualDensity: VisualDensity.compact,
            colorScheme: mode == WearMode.active
              ? const ColorScheme.dark(
                primary: Color(0xFF00B5FF),
              )
              : const ColorScheme.dark(
                primary: Colors.white24,
                onBackground: Colors.white10,
                onSurface: Colors.white10,
              )
          ),
          home: child,
        );
      }
    );
  }

}
