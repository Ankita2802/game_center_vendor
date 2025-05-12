import 'package:flutter/material.dart';
import 'package:game_center_vendor/models/games_model.dart';
import 'package:game_center_vendor/provider/games_provider.dart';
import 'package:game_center_vendor/provider/team_provider.dart';
import 'package:game_center_vendor/screens/game_center_vendor/game_center_vendor_main_screen.dart';
import 'package:game_center_vendor/screens/vendor_dashboard/vendor_dashboard_screen.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => TeamProvider()),
        ChangeNotifierProvider(create: (context) => GamesListProvider()),
      ],
      child: MaterialApp(
        darkTheme: ThemeData.dark(),
        debugShowCheckedModeBanner: false,
        title: "PlayVerse",
        home: VendorDashboardScreen(),
        theme: ThemeData(useMaterial3: false, brightness: Brightness.dark),
      ),
    );
  }
}

class MyAppThemes {
  static final lightTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.light,
  );

  static final darkTheme = ThemeData(
    primaryColor: Colors.black,
    brightness: Brightness.dark,
  );
}
