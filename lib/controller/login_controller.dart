import 'dart:developer';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:rxdart/rxdart.dart';

class LoginController {
  final formKey = GlobalKey<FormState>();
  final RegExp regex = RegExp(
      r"^(([^<>()[\]\\.,;:\s@\']+(\.[^<>()[\]\\.,;:\s@\']+)*)|(\'.+\'))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$");
  bool isConfirmed = false;
  bool hideText = true;
  final streamtouch = BehaviorSubject<bool>();
  final streamObscureText = BehaviorSubject<bool>();
  final TextEditingController passController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  // static const String keyPass = "pass";
  static const String keyEmail = "email";
  static const String keyBottonState = "state";

  void closeStream() {
    streamtouch.close();
    streamObscureText.close();
  }

  String? validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return "Digite seu E-mail";
    } else if (!regex.hasMatch(value)) {
      return "E-mail Iválido";
    }
    log("$emailController");
    return null;
  }

  String? validatePass(String? value) {
    if (value == null || value.length < 8) return "Senha Inválida";
    log("$passController");
    return null;
  }

  void touch() {
    isConfirmed = !isConfirmed;
    streamtouch.add(isConfirmed);
    saveButtonState();
    if (isConfirmed == true) {
      saveUser();
    }
  }

  void obscureText() {
    hideText = !hideText;
    log("Escondeu a Senha");
    streamObscureText.sink.add(hideText);
  }

  Future<void> saveUser() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    // prefs.setString(keyPass, passController.text);
    prefs.setString(keyEmail, emailController.text);
    //log("$keyPass.");
    log("email:$keyEmail.");
  }

  Future<void> loadUser() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    final savedState = pref.getBool(keyBottonState) ?? false;
    if (savedState) {
      emailController.text = pref.getString(keyEmail) ?? '';
    }
  }

  Future<void> saveButtonState() async {
    final SharedPreferences pref = await SharedPreferences.getInstance();
    pref.setBool(keyBottonState, isConfirmed);
    log("isConfirmed: $isConfirmed");
  }

  Future<void> loadButtonState() async {
    final SharedPreferences prefs = await SharedPreferences.getInstance();
    isConfirmed = prefs.getBool(keyBottonState) ?? false;
    streamtouch.sink.add(isConfirmed);
  }
}
