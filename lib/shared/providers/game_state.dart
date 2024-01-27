import 'package:captain_zero/shared/enums.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

final gameState = StateProvider<GameState>((ref) => GameState.none);
