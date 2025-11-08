import 'package:app_demo/screens/screens.dart';

class DefaultTheme {
  static final ThemeData defaultTheme = ThemeData.light().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[850],
    ),

    elevatedButtonTheme: ElevatedButtonThemeData(
        style: TextButton.styleFrom(
            backgroundColor: const Color(0xffd5d5d5), //#D5D5D5
            foregroundColor: const Color(0xffd5d5d5))),

    bottomNavigationBarTheme: BottomNavigationBarThemeData(
        backgroundColor: Colors.grey[850],
        selectedIconTheme: const IconThemeData(
          color: Colors.white,
        ),
        unselectedIconTheme: const IconThemeData(
          color: Colors.grey,
        ),
        selectedItemColor: Colors.white,
        unselectedItemColor: Colors.grey,
        elevation: 0,
        type: BottomNavigationBarType.fixed),

    textTheme: const TextTheme(
      //Titulos
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.black,
      ),
    ),

    cardTheme: const CardTheme(color: Colors.grey),

    inputDecorationTheme: const InputDecorationTheme(
      labelStyle: TextStyle(color: Colors.blue),
      border: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
      ),
      focusedBorder: OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        borderSide: BorderSide(color: Colors.blue),
      ),
    ),
    //hintColor: Colors.red
  );

  static final ThemeData darkTheme = ThemeData.dark().copyWith(
    appBarTheme: AppBarTheme(
      backgroundColor: Colors.grey[900],
    ),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: TextButton.styleFrom(
        backgroundColor: Colors.blue[900],
        foregroundColor: Colors.white,
      ),
    ),
    bottomNavigationBarTheme: BottomNavigationBarThemeData(
      backgroundColor: Colors.grey[900],
      selectedIconTheme: const IconThemeData(
        color: Colors.white,
      ),
      unselectedIconTheme: const IconThemeData(
        color: Colors.grey,
      ),
      selectedItemColor: Colors.white,
      unselectedItemColor: Colors.grey,
      elevation: 0,
      type: BottomNavigationBarType.fixed,
    ),
    textTheme: const TextTheme(
      //Titulos
      bodyMedium: TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Colors.white,
      ),
    ),
    cardTheme: CardTheme(
      color: Colors.grey[850],
    ),
    inputDecorationTheme: InputDecorationTheme(
      labelStyle: TextStyle(
        color: Colors.cyan[800],
      ),
      border: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        borderSide: BorderSide(color: Colors.white),
      ),
      focusedBorder: const OutlineInputBorder(
        borderRadius: BorderRadius.all(Radius.circular(25.0)),
        borderSide: BorderSide(color: Colors.grey),
      ),
    ),
  );
}
