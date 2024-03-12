import 'package:captain_zero/features/level1/enum.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameStateProvider =
    StateProvider<Level1GameState>((ref) => Level1GameState.isPlaying);
