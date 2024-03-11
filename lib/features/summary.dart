import 'package:captain_zero/const.dart';
import 'package:captain_zero/shared/components/grand_button.dart';
import 'package:captain_zero/shared/enums.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:rive/rive.dart';
import 'package:shared_preferences/shared_preferences.dart';

class Summary extends StatefulWidget {
  const Summary({super.key});

  @override
  State<Summary> createState() => _SummaryState();
}

class _SummaryState extends State<Summary> {
  @override
  Widget build(BuildContext context) {
    double screenWidth = MediaQuery.of(context).size.width;
    double screenHeight = MediaQuery.of(context).size.height;
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Text(
              "Well Done!",
              style: Theme.of(context).textTheme.titleLarge,
            ),
            SizedBox(
              width: screenWidth,
              height: screenHeight * 0.2,
              child: const RiveAnimation.asset(
                'lib/shared/assets/earth.riv',
                alignment: Alignment.center,
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 16),
              child: Text(
                summary,
                softWrap: true,
                style: Theme.of(context)
                    .textTheme
                    .bodyLarge
                    ?.copyWith(fontWeight: FontWeight.w200),
                textAlign: TextAlign.justify,
              ),
            ),
            GrandButton(
                onPress: () async {
                  context.go('/level1');
                  final pref = await SharedPreferences.getInstance();
                  pref.setString('gameState', GameState.onBoarded.name);
                },
                text: 'Play Again')
          ],
        ),
      ),
    );
  }
}
