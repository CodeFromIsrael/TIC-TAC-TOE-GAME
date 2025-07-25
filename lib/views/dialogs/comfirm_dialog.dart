import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/controller/source_controller.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';

class ComfirmDialog extends StatelessWidget {
  const ComfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return comfirmDialog(context);
  }
}

Widget comfirmDialog(context) {
  return SimpleDialog(
    backgroundColor: AppColors.blueColor,
    title: const Center(
      child: Text(
        "Tem certeza de que deseja se desconectar?",
        style: TextStyle(color: Colors.white),
      ),
    ),
    children: [
      Container(
        width: double.maxFinite,
        margin: const EdgeInsets.all(0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: () async {
                    await ServiceController.logout();
                    Navigator.of(context).pop();
                  },
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 40),
                    shape: RoundedRectangleBorder(
                      side: const BorderSide(color: Colors.white),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    backgroundColor: const Color.fromARGB(255, 1, 1, 53),
                  ),
                  child: const Text(
                    "Sim",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  ),
                ),
              ),
            ),
            const SizedBox(
              width: 12,
            ),
            Expanded(
              child: Padding(
                padding: const EdgeInsets.all(10),
                child: ElevatedButton(
                  onPressed: Navigator.of(context).pop,
                  style: ElevatedButton.styleFrom(
                    minimumSize: const Size(double.maxFinite, 40),
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(8)),
                    backgroundColor: Colors.white,
                  ),
                  child: const Text(
                    "Não",
                    style: TextStyle(color: AppColors.blueColor, fontSize: 17),
                  ),
                ),
              ),
            ),
          ],
        ),
      )
    ],
  );
}
