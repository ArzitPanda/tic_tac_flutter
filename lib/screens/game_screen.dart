import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tic_tac_clone/provider/room_data_provider.dart';
import 'package:tic_tac_clone/resources/socket_methods.dart';
import 'package:tic_tac_clone/views/scoreboard.dart';
import 'package:tic_tac_clone/views/tic_tac_board.dart';
import 'package:tic_tac_clone/views/waiting_lobby.dart';

class GameScreen extends StatefulWidget {
  static String routeName = '/game';
  const GameScreen({super.key});

  @override
  State<GameScreen> createState() => _GameScreenState();
}

class _GameScreenState extends State<GameScreen> {
  final SocketMethods _socketMethods = SocketMethods();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    _socketMethods.updateRoomListener(context);
    _socketMethods.updatePlayersStateListner(context);
  }

  @override
  Widget build(BuildContext context) {
    RoomDataProvider roomDataProvider = Provider.of<RoomDataProvider>(context);

    return Scaffold(
        body: roomDataProvider.roomdata['isJoin']
            ? const WaitingLobby()
            : SafeArea(
                child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const ScoreBoard(),
                  const TicTacBoard(),
                  Text(
                      '${roomDataProvider.roomdata['turn']['nickname']} \'s turn')
                ],
              )));
  }
}
