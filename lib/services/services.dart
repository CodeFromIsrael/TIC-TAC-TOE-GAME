import 'dart:convert';
import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:tic_tac_toe_app/controller/register_controller.dart';
import 'package:tic_tac_toe_app/views/dialogs/register_dialog.dart';

Future<void> setUser(RegisterController controller, context) async {
  final url = Uri.parse('http://10.0.2.2:5000/usuarios');

  final dados = {
    'nome': controller.nameController.text,
    'telefone': controller.phoneController.text,
    'email': controller.emailController.text,
    'senha': controller.passController.text
  };

  final resposta = await http.post(
    url,
    headers: {'Content-Type': 'application/json'},
    body: jsonEncode(dados),
  );

  if (resposta.statusCode == 201) {
    showDialog(context: context, builder: (context) => const RegisterDialog());
  } else {
    return log('Erro: ${resposta.statusCode}');
  }
}
