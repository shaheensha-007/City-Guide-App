import 'package:flutter/material.dart';
import 'package:flutter_interview/ui/home.dart';
import 'package:flutter_interview/widgets/NavigationServies.dart';

void main() {

  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
        useMaterial3: true,
      ),
        navigatorKey: NavigationService.navigatorKey,
      home:Home()
    );
  }
}