import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';
import 'package:tic_tac_toe_app/controller/register_controller.dart';
import 'package:tic_tac_toe_app/core/utils/app_images.dart';
import 'package:tic_tac_toe_app/views/dialogs/old_dialog.dart';

class TictactoeController {
  bool thePlayer = true;
  String imageWinner = "";
  List<String> displayXo = ["", "", "", "", "", "", "", "", ""];
  bool gameOver = false;
  int jogador1 = 0;
  int jogador2 = 0;
  final playerName = RegisterController();
  List<List<int>> possibilityOfWinner = [
    [0, 1, 2],
    [3, 4, 5],
    [6, 7, 8],
    [0, 3, 6],
    [1, 4, 7],
    [2, 5, 8],
    [0, 4, 8],
    [2, 4, 6],
  ];

  final streamPositionDisplay = BehaviorSubject<List<String>>();
  final streamWinningLine = BehaviorSubject<List<int>?>();
  final streamScoreboard = BehaviorSubject<int>();

  void closeStreams() {
    streamPositionDisplay.close();
    streamWinningLine.close();
    streamScoreboard.close();
  }

  void tapped(int index, BuildContext context) {
    if (displayXo[index] != "" || gameOver) return;

    displayXo[index] = thePlayer ? AppImages.x : AppImages.o;
    streamPositionDisplay.sink.add(displayXo);

    thePlayer = !thePlayer;

    arriveWinner(context);
  }

  void arriveWinner(BuildContext context) {
    for (var winner in possibilityOfWinner) {
      String a = displayXo[winner[0]];
      String b = displayXo[winner[1]];
      String c = displayXo[winner[2]];

      if (a != "" && a == b && b == c) {
        log('Vencedor: $a');
        gameOver = true;
        streamWinningLine.add(winner);

        if (a == AppImages.x) {
          jogador1++;
          log("jogador!: $jogador1");
          streamPositionDisplay.sink.add(displayXo);
          streamScoreboard.sink.add(jogador1);
        } else {
          jogador2++;
          log("jogador2: $jogador2");
          streamPositionDisplay.sink.add(displayXo);
          streamScoreboard.sink.add(jogador2);
        }

        for (int index in winner) {
          displayXo[index] =
              a == AppImages.x ? AppImages.xInvertido : AppImages.oInvertido;
        }

        streamPositionDisplay.sink.add(displayXo);
        return;
      }
    }

    if (!displayXo.contains("")) {
      log("deu velha");
      gameOver = true;
      //streamOldDialog.sink.add(null);
      streamWinningLine.add(null);
      showDialog(
          context: context,
          barrierDismissible: false,
          builder: (BuildContext context) {
            return OldDialog(controller: this);
          });
    }
  }

  void clearGrade() {
    displayXo = List.filled(9, "");
    thePlayer = true;
    gameOver = false;
    streamWinningLine.add(null);
    streamPositionDisplay.sink.add(displayXo);
  }

  void newGame() {
    jogador1 = 0;
    jogador2 = 0;
    log("Jogador 1: $jogador1");
    log("jogador 2: $jogador2");
    streamScoreboard.sink.add(jogador1);
    streamScoreboard.sink.add(jogador2);
    streamPositionDisplay.sink.add(displayXo);
  }
}
