import 'package:flutter/material.dart';
import 'package:tic_tac_toe_app/controller/tictactoe_controller.dart';
import 'package:tic_tac_toe_app/core/utils/app_colors.dart';
import 'package:tic_tac_toe_app/views/screens/widgets/winning_line.dart';

class GameBoard extends StatefulWidget {
  final TictactoeController controller;

  const GameBoard({required this.controller, super.key});
  @override
  State<GameBoard> createState() => _GameBoardState();
}

class _GameBoardState extends State<GameBoard> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
            color: Colors.grey[300], borderRadius: BorderRadius.circular(28)),
        child: LayoutBuilder(
          builder: (context, constraints) {
            final cellSize = (constraints.maxWidth - 40) / 3;

            return Stack(
              children: [
                StreamBuilder<List<int>?>(
                  stream: widget.controller.streamWinningLine.stream,
                  builder: (context, snapshot) {
                    final line = snapshot.data;
                    if (line == null) return const SizedBox.shrink();

                    final start = indexToOffset(line[0], cellSize);
                    final end = indexToOffset(line[2], cellSize);

                    return WinningLine(start: start, end: end);
                  },
                ),
                gridViewWidget(),
              ],
            );
          },
        ),
      ),
    );
  }

  Widget gridViewWidget() {
    return GridView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      padding: const EdgeInsets.all(0),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 3,
        crossAxisSpacing: 20,
        mainAxisSpacing: 20,
      ),
      itemCount: 9,
      itemBuilder: (context, index) => streamButtonPosition(
        index,
      ),
    );
  }

  Widget streamButtonPosition(int index) {
    return StreamBuilder<List<int>?>(
      stream: widget.controller.streamWinningLine.stream,
      builder: (context, snapshotLine) {
        final winningLine = snapshotLine.data ?? [];

        return StreamBuilder<List<String>>(
          stream: widget.controller.streamPositionDisplay.stream,
          builder: (context, snapshot) => buttonPosition(
            index,
            snapshot.data ?? widget.controller.displayXo,
            winningLine,
          ),
        );
      },
    );
  }

  Widget buttonPosition(
      int index, List<String> positions, List<int> winningLine) {
    final isWinningCell = winningLine.contains(index);

    return InkWell(
      onTap: positions[index] == "" && !widget.controller.gameOver
          ? () => widget.controller.tapped(index, context)
          : () {},
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(14),
          color: isWinningCell
              ? AppColors.blueColor
              : AppColors.blueColor.withOpacity(0.2),
        ),
        child: Align(
          alignment: Alignment.center,
          child: positions[index] == ""
              ? const SizedBox.shrink()
              : Image.asset(
                  positions[index],
                  width: 90,
                  height: 90,
                ),
        ),
      ),
    );
  }

  Offset indexToOffset(int index, double cellSize) {
    final row = index ~/ 3;
    final col = index % 3;
    return Offset(
      col * (cellSize + 20) + cellSize / 2,
      row * (cellSize + 20) + cellSize / 2,
    );
  }
}
