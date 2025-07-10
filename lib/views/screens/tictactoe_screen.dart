import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/controller/tictactoe_controller.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';
import 'package:tic_tac_toe_app/views/screens/widgets/game_board.dart';
import 'package:tic_tac_toe_app/views/screens/widgets/settings_drawer.dart';
import 'package:tic_tac_toe_app/views/screens/widgets/wavy_container.dart';

class TictactoeScreen extends StatefulWidget {
  const TictactoeScreen({super.key});

  @override
  State<TictactoeScreen> createState() => _TictactoeScreenState();
}

class _TictactoeScreenState extends State<TictactoeScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _controller.closeStreams();
    super.dispose();
  }

  final _controller = TictactoeController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      drawer: SettingsDrawer(
        controller: _controller,
      ),
      body: LayoutBuilder(builder: (context, constraints) {
        return SingleChildScrollView(
          child: ConstrainedBox(
            constraints: BoxConstraints(minHeight: constraints.maxHeight),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              mainAxisSize: MainAxisSize.min,
              children: [
                top(),
                GameBoard(controller: _controller),
                bottom(),
              ],
            ),
          ),
        );
      }),
    );
  }

  Widget _scoreBoard({required String playerName, required int score}) {
    return Row(
      children: [
        Text(
          playerName,
          style: const TextStyle(
            color: Colors.white,
            fontSize: 20,
          ),
        ),
        const SizedBox(width: 8),
        Container(
          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(50),
          ),
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
          child: Text(
            "$score",
            style: const TextStyle(
              color: AppColors.blueColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }

  Widget top() {
    return WavyContainer(
      postionWavy: PositionWavy.bottom,
      child: SafeArea(
        child: SizedBox(
          height: 160,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Align(
                alignment: Alignment.topRight,
                child: Builder(
                  builder: (context) => IconButton(
                    onPressed: () => Scaffold.of(context).openDrawer(),
                    icon: const Icon(
                      Icons.menu,
                      color: Colors.white,
                      size: 30,
                    ),
                  ),
                ),
              ),
              Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                    onPressed: () {
                      _controller.clearGrade();
                    },
                    icon: const Icon(Icons.restart_alt,
                        color: Colors.white, size: 30)),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget bottom() {
    return WavyContainer(
      postionWavy: PositionWavy.top,
      child: SizedBox(
        height: 170,
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: StreamBuilder<int>(
            stream: _controller.streamScoreboard,
            builder: (context, snapshot) {
              return Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Align(
                    alignment: Alignment.bottomLeft,
                    child: _scoreBoard(
                      playerName: "Jogador 1",
                      score: _controller.jogador1,
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomRight,
                    child: _scoreBoard(
                        playerName: "Jogador 2", score: _controller.jogador2),
                  )
                ],
              );
            },
          ),
        ),
      ),
    );
  }
}
