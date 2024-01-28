import 'package:captain_zero/features/level1/level1.dart';
import 'package:captain_zero/features/level2/level2.dart';
import 'package:captain_zero/features/levelStatus/level_status.dart';
import 'package:captain_zero/features/splash/splash.dart';
import 'package:go_router/go_router.dart';

final router = GoRouter(
  routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => const SplashScreen(),
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
      path: '/levelComplete/:level',
      builder: (context, state) => LevelCompleted(
        level: int.parse(state.pathParameters['level']!),
      ),
    )
  ],
);
