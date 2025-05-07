import 'package:flutter/material.dart';
import 'screens/home_screen.dart';

void main() {
  runApp(CapShopApp());
}

class CapShopApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cap Shop',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        scaffoldBackgroundColor: Color(0xFFF4F6F8), // light gray
        appBarTheme: AppBarTheme(
          backgroundColor: Color(0xFFFFFFFF), // white
          foregroundColor: Color(0xFF1E1E1E), // dark text
          elevation: 2,
          centerTitle: true,
          titleTextStyle: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E1E1E),
          ),
        ),
        cardColor: Color(0xFFFFFFFF),
        colorScheme: ColorScheme.light(
          primary: Color(0xFF0057D9), // deep blue
          secondary: Color(0xFFFFC107), // amber
        ),
        textTheme: const TextTheme(
          bodyMedium: TextStyle(
            color: Color(0xFF1E1E1E),
            fontSize: 16,
          ),
          titleLarge: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.bold,
            color: Color(0xFF1E1E1E),
          ),
        ),
      ),
      home: HomeScreen(),
    );
  }
}
