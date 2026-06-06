import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'views/dashboard_screen.dart';

void main() => runApp(const HireHubApp());

class HireHubApp extends StatelessWidget {
  const HireHubApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'HireHub',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.light,
        colorSchemeSeed: const Color(0xFF0A66C2),
        scaffoldBackgroundColor: const Color(0xFFF3F2EF),
      ),
      darkTheme: ThemeData(
        useMaterial3: true,
        brightness: Brightness.dark,
        colorSchemeSeed: const Color(0xFF0A66C2),
        scaffoldBackgroundColor: const Color(0xFF010409),
      ),
      themeMode: ThemeMode.light,
      home: DashboardScreen(),
    );
  }
}