import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';

class RegisterDialog extends StatelessWidget {
  const RegisterDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return SimpleDialog(
      backgroundColor: AppColors.blueColor,
      contentPadding: const EdgeInsets.all(16),
      shape: BeveledRectangleBorder(borderRadius: BorderRadius.circular(8)),
      children: const [
        Center(
            child: Text(
          "Conta Criada !",
          style: TextStyle(color: Colors.white, fontSize: 18),
        )),
      ],
    );
  }
}
