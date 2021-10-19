import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Settings extends Equatable {
  final int difficulty;
  final bool newGame;

  Settings({required this.difficulty, this.newGame = true});

  @override
  List<Object> get props => [difficulty, newGame];

  Settings copyWith({int? difficulty, bool? newGame}) {
    return Settings(
      difficulty: difficulty ?? this.difficulty,
      newGame: newGame ?? this.newGame,
    );
  }
}
