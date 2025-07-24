import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/controller/source_controller.dart';
import 'package:tic_tac_toe_app/views/screens/home_screen.dart';
import 'package:tic_tac_toe_app/views/screens/login_screnn.dart';

class App extends StatefulWidget {
  const App({super.key});

  @override
  State<App> createState() => _AppState();
}

class _AppState extends State<App> {
  @override
  void initState() {
    super.initState();
    ServiceController.checkLogin();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(scaffoldBackgroundColor: Colors.white),
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<String?>(
        stream: ServiceController.streamToken.stream,
        builder: (context, snapshot) {
          log("token: ${snapshot.data}");
          if (snapshot.data != null) {
            return const HomeScreen();
          } else {
            return const LoginScrenn();
          }
        },
      ),
    );
  }
}
