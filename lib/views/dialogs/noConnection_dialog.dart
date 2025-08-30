import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';
import 'package:tic_tac_toe_app/core/utils/app_images.dart';

class NoconnectionDialog extends StatelessWidget {
  const NoconnectionDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return noConnetivy(context);
  }
}

Widget noConnetivy(context) {
  return SimpleDialog(
    backgroundColor: AppColors.blueColor,
    contentPadding: const EdgeInsets.all(16),
    shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
    children: [
      Column(
        children: [
          Image.asset(AppImages.noConnection),
          const Center(
              child: Text(
            "Sem Intenet !",
            style: TextStyle(color: Colors.black, fontSize: 18),
          )),
          const SizedBox(
            height: 30,
          ),
          ElevatedButton(
              onPressed: () {
                Navigator.of(context).pop();
              },
              child: const Text("Voltar"))
        ],
      ),
    ],
  );
}
