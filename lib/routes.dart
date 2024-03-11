import 'package:captain_zero/features/level1/level1.dart';
import 'package:captain_zero/features/level2/level2.dart';
import 'package:captain_zero/features/level3/level3.dart';
import 'package:captain_zero/features/levelStatus/level_status.dart';
import 'package:captain_zero/features/onboarding/onboarding.dart';
import 'package:captain_zero/features/summary.dart';
import 'package:captain_zero/shared/components/generic_pass_widget.dart';
import 'package:go_router/go_router.dart';
import 'package:shared_preferences/shared_preferences.dart';

final router = GoRouter(
  redirect: (context, state) async {
    final pref = await SharedPreferences.getInstance();
    final gameState = pref.getString('gameState');
    if (state.uri.path == '/') {
      switch (gameState) {
        case 'onBoarded':
          return '/level1';
        case 'level1Completed':
          return '/level2';
        case 'level2Completed':
          return '/level3';
        case 'level3Completed':
          return '/genericPass';
        default:
          return '/';
      }
    }
    return null;
  },
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const OnboardingScreen(),
    ),
    GoRoute(
      path: '/level1',
      builder: (context, state) => const Level1(),
    ),
    GoRoute(
      path: '/level2',
      builder: (context, state) => const Level2(),
    ),
    GoRoute(
      path: '/level3',
      builder: (context, state) => const Level3(),
    ),
    GoRoute(
      path: '/levelComplete/:level',
      builder: (context, state) => LevelCompleted(
        level: int.parse(state.pathParameters['level']!),
      ),
    ),
    GoRoute(
      path: '/genericPass',
      builder: (context, state) => const GenericPass(),
    ),
    GoRoute(
      path: '/summary',
      builder: (context, state) => const Summary(),
    ),
  ],
);
