import 'package:captain_zero/features/level3/models/game_state_notifier.dart';
import 'package:captain_zero/features/level3/models/level_3_state.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final level3State = StateNotifierProvider<GameStateNotifier, Level3State>(
    (ref) => GameStateNotifier());
