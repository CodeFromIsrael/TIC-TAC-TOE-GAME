import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/controller/source_controller.dart';
import 'package:tic_tac_toe_app/controller/tictactoe_controller.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';
import 'package:tic_tac_toe_app/core/utils/app_images.dart';
import 'package:tic_tac_toe_app/views/dialogs/comfirm_dialog.dart';
import 'package:tic_tac_toe_app/views/screens/onlline_screen.dart';
import 'package:tic_tac_toe_app/views/screens/tictactoe_screen.dart';
import 'package:tic_tac_toe_app/views/screens/user_screnn.dart';
import 'package:tic_tac_toe_app/views/screens/widgets/settings_drawer.dart';
import 'package:tic_tac_toe_app/views/screens/widgets/wavy_container.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  final controller = TictactoeController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [top(), modeOfGame(), bottom()],
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
    return WavyContainer(
      postionWavy: PositionWavy.top,
      child: SizedBox(
        height: 150,
        child: Padding(
          padding: const EdgeInsets.all(6.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Padding(
                padding: const EdgeInsets.all(5.0),
                child: Align(
                  alignment: Alignment.bottomLeft,
                  child: logout(),
                ),
              ),
              Padding(
                padding: const EdgeInsetsGeometry.all(20.0),
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: rakingBottom(),
                ),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Align(
                  alignment: Alignment.bottomRight,
                  child: userBottom(),
                ),
              )
            ],
          ),
        ),
      ),
    );
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
              () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => const OnllineScreen()));
          }),
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
        onPressed: () {
          showDialog(
              context: context, builder: (context) => comfirmDialog(context));
        },
        icon: const Icon(
          Icons.logout,
          size: 40,
          color: Colors.white,
        ));
  }

  Widget userBottom() {
    return IconButton(
        onPressed: () {
          Navigator.push(context,
              MaterialPageRoute(builder: (context) => const UserScrenn()));
        },
        icon: const Icon(
          Icons.person,
          size: 40,
          color: Colors.white,
        ));
  }

  Widget rakingBottom() {
    return IconButton(
        onPressed: () {},
        icon: const Icon(
          Icons.leaderboard,
          size: 30,
          color: Colors.white,
        ));
  }
}
