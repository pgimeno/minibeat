import 'package:arcore_flutter_plugin/arcore_flutter_plugin.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:minibeat/screens/ar_screen.dart';
import 'package:minibeat/screens/login.dart';
import 'package:minibeat/screens/menu.dart';
import 'package:minibeat/screens/puzzle.dart';
import 'package:minibeat/screens/radar.dart';
import 'package:minibeat/screens/ranking.dart';
import 'package:minibeat/screens/register.dart';
import 'package:minibeat/screens/success.dart';
import 'package:minibeat/utils/constants.dart';

List<int> llistaPeces = [];

void main() async{
  WidgetsFlutterBinding.ensureInitialized();
  print(await ArCoreController.checkArCoreAvailability());
  print(await ArCoreController.checkIsArCoreInstalled());

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // root
  @override
  Widget build(BuildContext context) {
    //getPlayer();
    print('Hello');
    SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'MiniBeat Go!',
      theme: createCustomLightTheme(),
      initialRoute: '/login',
      //pantalla inicial
      routes: {
        '/login': (context) => LoginScreen(),
        '/register': (context) => RegisterScreen(),
        //'/menu': (context) => MenuScreen(),
        '/ranking': (context) => RankingScreen(),
        '/puzzle' :(context) => PuzzleScreen(),
        '/radar': (context) => RadarScreen(),
        //'/hunt': (context) => ArScreen(),
        //'/success': (context) => SuccessScreen(),
      }
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
    checkboxTheme: CheckboxThemeData(
      shape: CircleBorder(
        side: BorderSide(
          color: Colors.white, // Customize the color of the border or outline
          width: 2.0, // Customize the width of the border or outline
        ),
      ),
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
