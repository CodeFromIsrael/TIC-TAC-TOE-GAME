import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/controller/source_controller.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';
import 'package:tic_tac_toe_app/core/utils/app_images.dart';
import 'package:tic_tac_toe_app/views/screens/tictactoe_screen.dart';
import 'package:tic_tac_toe_app/views/screens/widgets/wavy_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [top(), modeOfGame(), logout(), bottom()],
            ),
          ),
        );
      }),
    );
  }

  Widget top() {
    return const WavyContainer(postionWavy: PositionWavy.bottom);
  }

  Widget bottom() {
    return const WavyContainer(postionWavy: PositionWavy.top);
  }

  Widget modeOfGame() {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          const Text(
            "Escolha um modo de \n jogo",
            style: TextStyle(
                color: AppColors.blueColor,
                fontSize: 28,
                fontWeight: FontWeight.w500),
          ),
          const SizedBox(
            height: 28,
          ),
          options(
              Image.asset(
                AppImages.imageLocale,
              ),
              const Text("Jogar Localmente",
                  style: TextStyle(color: AppColors.blueColor, fontSize: 24)),
              () {
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => const TictactoeScreen()));
          }),
          const SizedBox(
            height: 16,
          ),
          options(
              Image.asset(AppImages.imageOnlline),
              const Text("Jogar Onlline",
                  style: TextStyle(color: AppColors.blueColor, fontSize: 24)),
              () {}),
          const SizedBox(
            height: 16,
          ),
          options(
              Image.asset(AppImages.bot),
              const Text("Jogar Contra o Bot",
                  style: TextStyle(color: AppColors.blueColor, fontSize: 24)),
              () {})
        ],
      ),
    );
  }

  Widget options(Image image, Text text, function) {
    return InkWell(
      onTap: () {
        function();
      },
      child: Padding(
        padding: const EdgeInsets.all(2),
        child: Container(
          padding: const EdgeInsets.all(6),
          decoration: BoxDecoration(
              color: AppColors.blueColor.withOpacity(0.1),
              borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              SizedBox(height: 110, child: image),
              const SizedBox(
                width: 4,
              ),
              Flexible(child: text)
            ],
          ),
        ),
      ),
    );
  }

  Widget logout() {
    return IconButton(
        onPressed: () async => await ServiceController.logout(),
        icon: const Icon(
          Icons.logout,
          size: 32,
          color: AppColors.blueColor,
        ));
  }
}
