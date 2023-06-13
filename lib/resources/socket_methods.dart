import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'package:tic_tac_clone/provider/room_data_provider.dart';
import 'package:tic_tac_clone/resources/game_methods.dart';
import 'package:tic_tac_clone/resources/socket_client.dart';
import 'package:tic_tac_clone/screens/game_screen.dart';
import 'package:tic_tac_clone/utils/utils.dart';

class SocketMethods {
  final _socketClient = SocketClient.instance?.socket!;

  Socket? get socketClient => _socketClient;

  void createRoom(String nickName) {
    if (nickName.isNotEmpty) {
      _socketClient?.emit("createRoom", {
        'nickname': nickName,
      });
    }
  }

  void joinRoom(String nickName, String roomId) {
    if (nickName.isNotEmpty && roomId.isNotEmpty) {
      _socketClient?.emit('joinRoom', {'nickname': nickName, 'roomId': roomId});
    }
  }

  void createRoomSuccessListener(BuildContext context) {
    _socketClient?.on('createRoomSucsess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void joinRoomSuccessListener(BuildContext context) {
    _socketClient?.on('joinRoomSucsess', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
      Navigator.pushNamed(context, GameScreen.routeName);
    });
  }

  void errorOccuredListner(BuildContext context) {
    _socketClient?.on('errorOccured', (data) {
      showSnackBar(context, data);
    });
  }

  void updatePlayersStateListner(BuildContext context) {
    _socketClient?.on('updatePlayers', (playerData) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer1(playerData[0]);
      Provider.of<RoomDataProvider>(context, listen: false)
          .updatePlayer2(playerData[1]);
    });
  }

  void updateRoomListener(BuildContext context) {
    _socketClient?.on('updateRoom', (room) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(room);
    });
  }

  void tapGrid(int index, String roomId, List<String> displayElements) {
    if (displayElements[index] == '') {
      _socketClient?.emit('tap', {'index': index, 'roomId': roomId});
    }
  }

  void tappedListener(BuildContext context) {
    _socketClient?.on('tapped', (data) {
      Provider.of<RoomDataProvider>(context, listen: false)
          .updateDisplayElement(data['index'], data['choice']);

      Provider.of<RoomDataProvider>(context, listen: false)
          .updateRoomData(data['room']);
    });

    GameMethods().checkWinner(context, _socketClient);
  }
}
