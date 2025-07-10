import 'dart:ui';
import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';
import 'package:tic_tac_toe_app/core/utils/app_images.dart';
import 'package:tic_tac_toe_app/controller/tictactoe_controller.dart';

class OldDialog extends StatelessWidget {
  const OldDialog({super.key, required this.controller});
  final TictactoeController controller;

  @override
  Widget build(BuildContext context) {
    return oldDialog(context);
  }

  Widget oldDialog(context) {
    return SimpleDialog(
      title: const Center(
          child: Text("Deu velha !",
              style: TextStyle(color: Colors.white, fontSize: 26))),
      backgroundColor: const Color.fromARGB(255, 1, 1, 53),
      contentPadding: const EdgeInsets.all(16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30)),
      children: [
        Image.asset(
          AppImages.old,
        ),
        const SizedBox(
          height: 16,
        ),
        Container(
          width: double.maxFinite,
          margin: const EdgeInsets.all(0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Expanded(
                child: ElevatedButton(
                  onPressed: () {
                    controller.clearGrade();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 40),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(14),
                    ),
                    backgroundColor: const Color.fromARGB(255, 1, 1, 53),
                  ),
                  child: const Text(
                    "Reiniciar",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
              const SizedBox(
                width: 12,
              ),
              Expanded(
                child: ElevatedButton(
                  onPressed: Navigator.of(context).pop,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(14)),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Ok",
                    style: TextStyle(color: AppColors.blueColor, fontSize: 17),
                  ),
                ),
              ),
            ],
          ),
        )
      ],
    );
  }
}
