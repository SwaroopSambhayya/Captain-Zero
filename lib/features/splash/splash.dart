import 'package:captain_zero/features/splash/components/captain_zero.dart';
import 'package:captain_zero/features/splash/components/game_intro.dart';
import 'package:captain_zero/shared/components/grand_button.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  late PageController _pageController;
  int currentIndex = 0;
  @override
  void initState() {
    super.initState();
    _pageController = PageController();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        margin: const EdgeInsets.only(top: 20),
        child: Column(
          children: [
            Expanded(
              child: PageView(
                controller: _pageController,
                physics: const NeverScrollableScrollPhysics(),
                children: const [CaptainZero(), GameIntro()],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 30.0),
              child: GrandButton(
                  onPress: () async {
                    if (currentIndex == 0) {
                      _pageController.nextPage(
                          duration: const Duration(milliseconds: 500),
                          curve: Curves.easeInOut);
                      setState(() {
                        currentIndex++;
                      });
                    } else {
                      context.go('/level1');
                      SharedPreferences pref =
                          await SharedPreferences.getInstance();
                      pref.setBool('onboarded', true);
                    }
                  },
                  text: currentIndex == 0 ? "Let's Start" : "Start Journey!"),
            )
          ],
        ),
      ),
    );
  }
}
