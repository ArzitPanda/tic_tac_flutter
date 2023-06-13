import 'package:flutter/material.dart';
import 'package:tic_tac_clone/responsive/responsive.dart';
import 'package:tic_tac_clone/screens/create_room_screen.dart';
import 'package:tic_tac_clone/screens/join_room_screen.dart';
import 'package:tic_tac_clone/widgets/custom_button.dart';

class MainMenuScreen extends StatelessWidget {
  static String routeName = '/main-menu';
  const MainMenuScreen({super.key});

  void createRoom(BuildContext context) {
    Navigator.pushNamed(context, CreateRoom.routeName);
  }

  void joinRoom(BuildContext context) {
    Navigator.pushNamed(context, JoinRoomScreen.routeName);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: Responsive(
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            CustomButton(onTap: () => createRoom(context), text: "create room"),
            const SizedBox(
              height: 20,
            ),
            CustomButton(onTap: () => joinRoom(context), text: "join room")
          ],
        ),
      ),
    ));
  }
}
