import 'package:flutter/material.dart';
import 'package:tic_tac_clone/resources/socket_methods.dart';
import 'package:tic_tac_clone/responsive/responsive.dart';
import 'package:tic_tac_clone/widgets/custom_button.dart';
import 'package:tic_tac_clone/widgets/custom_text.dart';
import 'package:tic_tac_clone/widgets/custom_textfield.dart';

class JoinRoomScreen extends StatefulWidget {
  static String routeName = '/join-room';
  const JoinRoomScreen({super.key});

  @override
  State<JoinRoomScreen> createState() => _JoinRoomScreenState();
}

class _JoinRoomScreenState extends State<JoinRoomScreen> {
  final TextEditingController _nameController = TextEditingController();
  final TextEditingController _roomController = TextEditingController();
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    super.initState();
    _socketMethods.joinRoomSuccessListener(context);
    _socketMethods.errorOccuredListner(context);
    _socketMethods.updatePlayersStateListner(context);
  }

  @override
  void dispose() {
    super.dispose();
    _nameController.dispose();
    _roomController.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      child: Responsive(
        widget: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const CustomText(
                text: "Create Room",
                fontSize: 70,
                shadow: [Shadow(blurRadius: 40, color: Colors.blue)]),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: _roomController,
              hintText: "enter your roomId",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextField(
              controller: _nameController,
              hintText: "enter your name",
            ),
            const SizedBox(
              height: 20,
            ),
            CustomButton(
                onTap: () => _socketMethods.joinRoom(
                    _nameController.text, _roomController.text),
                text: "join room")
          ],
        ),
      ),
    ));
  }
}
