import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
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
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MiniBeat Go!',
      theme: createCustomLightTheme(),
      home: LoginScreen(),
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
    inputDecorationTheme: InputDecorationTheme(
      hintStyle: TextStyle(color: Colors.white),
      labelStyle: TextStyle(color: Colors.white),
      enabledBorder: UnderlineInputBorder(
        borderSide: BorderSide(color: kMiniBeatMainColor),
      ),
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
      bodyMedium:
          TextStyle(fontFamily: 'Hind', fontSize: 25, color: Colors.white),
      bodySmall:
          TextStyle(fontFamily: 'Hind', fontSize: 17, color: Colors.white),
      bodyLarge:
          TextStyle(fontFamily: 'Hind', fontSize: 45, color: Colors.white),
    ),
  );
}
