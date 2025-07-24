import 'dart:convert';
import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';
import 'package:tic_tac_toe_app/controller/login_controller.dart';
import 'package:tic_tac_toe_app/controller/register_controller.dart';
import 'package:tic_tac_toe_app/controller/source_controller.dart';
import 'package:tic_tac_toe_app/views/dialogs/register_dialog.dart';
import 'package:tic_tac_toe_app/views/screens/home_screen.dart';

class Services {
  Future<void> setUser(RegisterController controller, context) async {
    final url = Uri.parse('http://10.0.2.2:5000/usuarios');

    final dados = {
      'nome': controller.nameController.text,
      'telefone': controller.phoneController.text,
      'email': controller.emailController.text,
      'senha': controller.passController.text
    };

    try {
      final response = await http.post(url,
          headers: {'Content-Type': 'application/json'},
          body: json.encode(dados));

      if (response.statusCode == 201) {
        showDialog(
            context: context, builder: (context) => const RegisterDialog());
      } else {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text("Erro ao Criar a conta ${response.statusCode}")));
      }
    } catch (erro) {
      ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text("Erro ao conectar com o servidor $erro")));
    }
  }

  Future<void> loginUser(LoginController controller, context) async {
    final url = Uri.parse("http://10.0.2.2:5000/login");

    final login = {
      "email": controller.emailController.text,
      "senha": controller.passController.text
    };

    try {
      final response = await http.post(
        url,
        headers: {
          'Content-Type': 'application/json',
        },
        body: jsonEncode(login),
      );

      if (response.statusCode == 200) {
        final responseData = jsonDecode(response.body);
        final token = responseData['token'];

        final prefs = await SharedPreferences.getInstance();
        await prefs.setString("tokenOfAcess", token);
        log(token);
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
              content:
                  Text("Erro ao executar o login: ${response.statusCode}")),
        );
      }
    } catch (erro) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text("Erro ao conectar com o servidor: $erro")),
      );
      log("Erro: $erro");
    }
  }
}
