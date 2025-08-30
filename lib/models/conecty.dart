import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'package:tic_tac_toe_app/views/dialogs/noConnection_dialog.dart';

class Conecty {
  Future<bool> checkerConnection() async {
    final checker = InternetConnectionChecker.createInstance();
    bool hasInternet = await checker.hasConnection;
    if (hasInternet) {
      log("Dispositivo com Conexão");
      return true;
    } else {
      log("Dispositivo sem Conexão");
      return false;
    }
  }
}
