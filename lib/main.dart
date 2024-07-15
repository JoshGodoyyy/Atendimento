import 'package:atendimento/app/ui/theme/theme_config.dart';
import 'package:flutter/material.dart';
import 'app/pages/splash/splash_screen.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: const SplashScreen(),
      theme: ThemeConfig.theme,
      debugShowCheckedModeBanner: false,
    );
  }
}
