import 'package:flutter/material.dart';
import 'package:tic_tac_clone/models/player.dart';

class RoomDataProvider extends ChangeNotifier {
  //notifyListener

  Map<String, dynamic> _roomdata = {};
  List<String> _displayElements = ['', '', '', '', '', '', '', '', ''];
  int _filledBoxes = 0;
  // ignore: prefer_final_fields
  Player _player1 =
      Player(nickname: '', socketID: '', points: 0, playerType: 'X');

  // ignore: prefer_final_fields
  Player _player2 =
      Player(nickname: '', socketID: '', points: 0, playerType: 'O');

  Map<String, dynamic> get roomdata => _roomdata;
  List<String> get displayElement => _displayElements;
  Player get player1 => _player1;
  Player get player2 => _player2;
  int get filledBoxes => _filledBoxes;
  void updateRoomData(Map<String, dynamic> data) {
    _roomdata = data;
    notifyListeners();
  }

  void updatePlayer1(Map<String, dynamic> player1Data) {
    _player1 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updatePlayer2(Map<String, dynamic> player1Data) {
    _player2 = Player.fromMap(player1Data);
    notifyListeners();
  }

  void updateDisplayElement(int index, String choice) {
    _displayElements[index] = choice;
    _filledBoxes = _filledBoxes + 1;
    notifyListeners();
  }
}
