import 'package:flutter/material.dart';

class ComfirmDialog extends StatelessWidget {
  const ComfirmDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return comfirmDialog();
  }
}

Widget comfirmDialog() {
  return const SimpleDialog(
    title: Center(
      child: Text("Tem certeza que deseja sair da sua conta"),
    ),
    children: [
      Row(
        children: [],
      )
    ],
  );
}

Widget Button(Function func, String texto) {
  return ElevatedButton(onPressed: () {}, child: Text(texto));
}
