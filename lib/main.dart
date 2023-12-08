import 'package:choosifoodi/core/utils/app_theme.dart';
import 'package:choosifoodi/screens/splash/splash_screen.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Choosi Foodi',
      theme: AppTheme.mainTheme,
      home: SplashScreen(),
      // home: HomeScreen(),
    );
  }
}
