import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/controller/register_controller.dart';
import 'package:tic_tac_toe_app/controller/tictactoe_controller.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';
import 'package:tic_tac_toe_app/views/dialogs/new_game_dialog.dart';
import 'package:tic_tac_toe_app/views/screens/home_screen.dart';
import 'package:tic_tac_toe_app/views/screens/login_screnn.dart';

class SettingsDrawer extends StatefulWidget {
  const SettingsDrawer({super.key, required this.controller});
  final TictactoeController controller;

  @override
  State<SettingsDrawer> createState() => _SettingsDrawerState();
}

class _SettingsDrawerState extends State<SettingsDrawer> {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const DrawerHeader(
            decoration: BoxDecoration(color: AppColors.blueColor),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                  backgroundColor: Colors.white,
                  radius: 40,
                  child: Text(
                    "I",
                    style: TextStyle(color: AppColors.blueColor, fontSize: 20),
                  ),
                ),
                Text(
                  "",
                  style: TextStyle(color: Colors.white, fontSize: 20),
                )
              ],
            ),
          ),
          options(
              const Icon(Icons.home),
              const Text(
                "Home",
                style: TextStyle(fontSize: 20),
              ), () {
            Navigator.of(context).pop();
            Navigator.of(context).pop();
          }),
          options(
              const Icon(Icons.refresh),
              const Text(
                "Nova Partida",
                style: TextStyle(fontSize: 20),
              ), () {
            Navigator.of(context).pop();
            widget.controller.newGame();
            widget.controller.clearGrade();
            showDialog(
                barrierDismissible: false,
                context: context,
                builder: (context) {
                  return newGameDialog(context);
                });
          }),
          options(
              const Icon(
                Icons.exit_to_app,
                color: Colors.red,
              ),
              const Text("Sair",
                  style: TextStyle(color: Colors.red, fontSize: 20)), () {
            //SystemNavigator.pop();
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const HomeScreen()));
          })
        ],
      ),
    );
  }

  Widget options(Icon icon, Text title, fucttion) {
    return ListTile(
      leading: icon,
      title: title,
      onTap: fucttion,
    );
  }
}
