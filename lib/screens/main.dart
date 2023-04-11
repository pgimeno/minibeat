import 'package:flutter/material.dart';
import 'package:minibeat/screens/login.dart';
import 'package:minibeat/utils/constants.dart';
import 'package:minibeat/screens/register.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // root
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Demo',
      theme: createCustomLightTheme(),
      initialRoute: '/',
      routes: {
        '/':(context) => LoginScreen(),
        '/register':(context) =>  RegisterScreen(),
      },
    );
  }
}

ThemeData createCustomLightTheme() {
  final ThemeData base = ThemeData.light();
  return base.copyWith(
    colorScheme: base.colorScheme.copyWith(
      primary: kMiniBeatMainColor,
      onPrimary: Colors.white,
      secondary: kMiniBeatMainColor,
      onSecondary: Colors.white,
    ),
    appBarTheme: AppBarTheme(
      color: kMiniBeatMainColor,
      iconTheme: IconThemeData(color: Colors.white),
      actionsIconTheme: IconThemeData(color: Colors.white),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: kMiniBeatMainColor,
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      selectedItemColor: kMiniBeatMainColor,
    ),
    textTheme: TextTheme(
      bodyMedium: TextStyle(fontFamily: 'Hind', fontSize: 25, color: Colors.black),
      bodySmall: TextStyle(fontFamily: 'Hind', fontSize: 15, color: Colors.black),
      bodyLarge: TextStyle(fontFamily: 'Hind', fontSize: 45, color: Colors.black),

    ),
  );
}
