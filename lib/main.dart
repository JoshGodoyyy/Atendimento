import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'app/pages/splash/splash_screen.dart';

void main() {
  runApp(const MainApp());
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.immersiveSticky);
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      home: SplashScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}
