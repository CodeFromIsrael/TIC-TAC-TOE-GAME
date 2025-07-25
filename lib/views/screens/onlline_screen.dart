import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/views/screens/widgets/wavy_container.dart';

class OnllineScreen extends StatefulWidget {
  const OnllineScreen({super.key});

  @override
  State<OnllineScreen> createState() => _OnllineScreenState();
}

class _OnllineScreenState extends State<OnllineScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        children: [Top(), input()],
      ),
    );
  }

  Widget Top() {
    return const WavyContainer(
      postionWavy: PositionWavy.bottom,
    );
  }
}

Widget input() {
  return Padding(
      padding: const EdgeInsets.all(10),
      child: TextFormField(
          decoration: InputDecoration(
              prefixIcon: const Icon(Icons.search),
              border:
                  OutlineInputBorder(borderRadius: BorderRadius.circular(20))),
          textInputAction: TextInputAction.search));
}
