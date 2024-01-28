import 'package:captain_zero/features/level2/components/wordle/empty_box.dart';
import 'package:captain_zero/features/level2/components/wordle/letter_box.dart';
import 'package:captain_zero/features/level2/providers/score_tracker.dart';
import 'package:captain_zero/features/level2/utils/get_puzzled_word.dart';
import 'package:captain_zero/shared/enums.dart';
import 'package:captain_zero/shared/providers/game_state.dart';
import 'package:captain_zero/shared/theme.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class Wordle extends ConsumerStatefulWidget {
  const Wordle({super.key});

  @override
  ConsumerState<Wordle> createState() => _WordleState();
}

class _WordleState extends ConsumerState<Wordle> {
  List<List<String>> words = [
    ["PLANET", "HYDRO", "FOSSIL"],
    ["FUEL", "ENERGY", "COAL"],
    ["CARBON", "SMOKE", "GREEN"],
    ["SOLAR", "WIND", "AIR"],
    ["WATER", "REUSE", "FOREST"],
    ["SUSTAIN", "POWER", "EARTH"],
    ["SOIL", "PLANT", "TREE"],
    // ["FILTER", "FOREST", "CLIMATE"],
    // ["SUSTAIN", "HARVEST", "NATURAL"]
  ];

  late PageController pageController;

  @override
  void initState() {
    pageController = PageController();

    super.initState();
  }

  @override
  void dispose() {
    pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final BrandColors colors = Theme.of(context).extension<BrandColors>()!;
    ref.listen(scoreTracker, (previous, next) {
      if (next % 3 == 0) {
        if (next != (words.length * 3)) {
          pageController.nextPage(
              duration: const Duration(milliseconds: 500),
              curve: Curves.easeIn);
        } else {
          ref.read(gameState.notifier).state = GameState.level2Completed;
        }
      }
    });
    return Column(
      children: [
        Consumer(
          builder: (context, ref, child) {
            int score = ref.watch(scoreTracker);

            return Padding(
              padding: const EdgeInsets.only(top: 10),
              child: Text(
                "$score / ${words.length * 3}",
                style: Theme.of(context)
                    .textTheme
                    .titleMedium
                    ?.copyWith(color: colors.brandColor5),
              ),
            );
          },
        ),
        Expanded(
          child: PageView.builder(
            controller: pageController,
            physics: const NeverScrollableScrollPhysics(),
            itemBuilder: (context, index) {
              return Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: words[index]
                    .map(
                      (word) => WordleRow(
                        puzzledWord: getPuzzledWord(word),
                        word: word,
                      ),
                    )
                    .toList(),
              );
            },
            itemCount: words.length,
          ),
        ),
      ],
    );
  }
}

class WordleRow extends ConsumerStatefulWidget {
  const WordleRow({super.key, required this.puzzledWord, required this.word});

  final List<String> puzzledWord;
  final String word;

  @override
  ConsumerState<WordleRow> createState() => _WordleRowState();
}

class _WordleRowState extends ConsumerState<WordleRow> {
  int wordCount = 0;

  updateMatchCount() {
    setState(() {
      wordCount++;
      if (wordCount == widget.word.length) {
        ref.read(scoreTracker.notifier).state++;
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return FittedBox(
      child: Row(
        children: widget.puzzledWord
            .asMap()
            .entries
            .map(
              (entry) => Column(
                children: [
                  LetterBox(data: entry.value, onAccepted: updateMatchCount),
                  if (wordCount != widget.word.length)
                    const SizedBox(
                      height: 20,
                    ),
                  EmptyLetterBox(
                    dataToAccept: widget.word[entry.key],
                  )
                ],
              ),
            )
            .toList(),
      ),
    );
  }
}
