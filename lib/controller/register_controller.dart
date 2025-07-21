import 'dart:developer';

import 'package:flutter/cupertino.dart';
import 'package:rxdart/rxdart.dart';

class RegisterController {
  final formKey = GlobalKey<FormState>();
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
  final RegExp phoneRegexp = RegExp(r'^\(\d{2}\)\s\d{4,5}-\d{4}$');
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController confirmController = TextEditingController();
  final streamObscureText = BehaviorSubject<bool>();
  bool isconfirmed = true;

  void closeStreams() {
    streamObscureText.close();
  }

  String? validateName(String? value) {
    if (value == null || value.isEmpty) return "Campo Obrigatório";
    if (value.length < 4) return "Nome Inválido";
    log("$nameController");
    return null;
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) return "Campo obrigatório";
    if (!regex.hasMatch(value)) return "E-mail invalido";
    log("$emailController");
    return null;
  }

  String? validatePhone(String? value) {
    if (value == null || value.isEmpty) return "Campo Obrigatório";
    // if (!phoneRegexp.hasMatch(value)) return "Numero Inválido";
    log("$phoneController");
    return null;
  }

  String? validatePass(String? value) {
    if (value == null || value.isEmpty) return "Campo Obrigatório";
    if (value.length < 8) return "Senha Inválida";
    log("$passController");
    return null;
  }

  String? confirmPass(String? value) {
    if (value == null || value.isEmpty) return "Campo Obrigatório";
    if (confirmController.text != passController.text) return "Senha Diferente";
    log("$confirmController");
    return null;
  }

  void obscureText() {
    isconfirmed = !isconfirmed;
    streamObscureText.sink.add(isconfirmed);
  }
}
