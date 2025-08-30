import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';
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
        children: [
          Top(),
          input(),
          const SizedBox(
            height: 10,
          ),
          text(),
          SizedBox(height: 100, child: listPlayers())
        ],
      ),
    );
  }

  Widget Top() {
    return const WavyContainer(
      postionWavy: PositionWavy.bottom,
    );
  }

  Widget input() {
    return Padding(
        padding: const EdgeInsets.all(10),
        child: TextFormField(
            decoration: InputDecoration(
                prefixIcon: const Icon(Icons.search),
                border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20))),
            textInputAction: TextInputAction.search));
  }

  Widget text() {
    return const Center(
      child: Text(
        "JOGADORES ONLLINE",
        style: TextStyle(color: AppColors.blueColor, fontSize: 20),
      ),
    );
  }

  Widget listPlayers() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        decoration: BoxDecoration(
            color: AppColors.blueColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(20)),
        child: ListView(
          children: [players()],
        ),
      ),
    );
  }

  Widget players() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Container(
        height: 60,
        decoration: BoxDecoration(
          color: AppColors.blueColor,
          borderRadius: BorderRadius.circular(16),
        ),
        child: Padding(
          padding: const EdgeInsets.all(8),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Padding(
                padding: EdgeInsets.all(8.0),
                child: Text(
                  "JOGADOR",
                  style: TextStyle(color: Colors.white),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(4),
                child: ElevatedButton(
                    onPressed: () {},
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.white,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadiusGeometry.circular(10))),
                    child: const Text(
                      "DESAFIAR",
                      style: TextStyle(color: Colors.black),
                    )),
              )
            ],
          ),
        ),
      ),
    );
  }
}
