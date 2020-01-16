import 'package:flutter/material.dart';
import 'home_page.dart';
import 'message.dart';

int checkingWinner(List player1, List player2) {
  var winner = -1;
  //Rows checking for player 1
  if (player1.contains(1) && player1.contains(2) && player1.contains(3)) {
    winner = 1;
  }
  if (player1.contains(4) && player1.contains(5) && player1.contains(6)) {
    winner = 1;
  }
  if (player1.contains(7) && player1.contains(8) && player1.contains(9)) {
    winner = 1;
  }
  if (player1.contains(1) && player1.contains(5) && player1.contains(9)) {
    winner = 1;
  }
  if (player1.contains(7) && player1.contains(5) && player1.contains(3)) {
    winner = 1;
  }
  //Rows checking for player 2
  if (player2.contains(1) && player2.contains(2) && player2.contains(3)) {
    winner = 2;
  }
  if (player2.contains(4) && player2.contains(5) && player2.contains(6)) {
    winner = 2;
  }
  if (player2.contains(7) && player2.contains(8) && player2.contains(9)) {
    winner = 2;
  }
  if (player2.contains(1) && player2.contains(5) && player2.contains(9)) {
    winner = 2;
  }
  if (player2.contains(7) && player2.contains(5) && player2.contains(3)) {
    winner = 2;
  }

  //column checking for player 1
  if (player1.contains(1) && player1.contains(4) && player1.contains(7)) {
    winner = 1;
  }
  if (player1.contains(2) && player1.contains(5) && player1.contains(8)) {
    winner = 1;
  }
  if (player1.contains(3) && player1.contains(6) && player1.contains(9)) {
    winner = 1;
  }

  //column checking for player 2
  if (player2.contains(1) && player2.contains(4) && player2.contains(7)) {
    winner = 2;
  }
  if (player2.contains(2) && player2.contains(5) && player2.contains(8)) {
    winner = 2;
  }
  if (player2.contains(3) && player2.contains(6) && player2.contains(9)) {
    winner = 2;
  }
  return winner;
}
