import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';

class NewGameDialog extends StatelessWidget {
  const NewGameDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return newGameDialog(context);
  }
}

Widget newGameDialog(context) {
  return SimpleDialog(
    backgroundColor: AppColors.blueColor,
    contentPadding: const EdgeInsets.all(14),
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(10)),
    children: [
      const Center(
          child: Text(
        "Um novo jogo foi iniciado",
        style: TextStyle(color: Colors.white, fontSize: 20),
      )),
      const SizedBox(
        height: 14,
      ),
      ElevatedButton(
          onPressed: () {
            Navigator.of(context).pop();
          },
          style: ElevatedButton.styleFrom(
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10))),
          child: const Text("ok",
              style: TextStyle(fontSize: 20, color: AppColors.blueColor)))
    ],
  );
}
