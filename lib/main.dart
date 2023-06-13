import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_clone/provider/room_data_provider.dart';
import 'package:tic_tac_clone/screens/create_room_screen.dart';
import 'package:tic_tac_clone/screens/game_screen.dart';
import 'package:tic_tac_clone/screens/join_room_screen.dart';
import 'package:tic_tac_clone/utils/colors.dart';
import 'package:tic_tac_clone/screens/main_menu_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => RoomDataProvider(),
      child: MaterialApp(
          title: 'Flutter Demo',
          routes: {
            MainMenuScreen.routeName: (context) => const MainMenuScreen(),
            CreateRoom.routeName: (context) => const CreateRoom(),
            JoinRoomScreen.routeName: (context) => const JoinRoomScreen(),
            GameScreen.routeName: (context) => const GameScreen()
          },
          initialRoute: MainMenuScreen.routeName,
          theme: ThemeData.dark().copyWith(scaffoldBackgroundColor: bgColor),
          home: const MainMenuScreen()),
    );
  }
}
