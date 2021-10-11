import 'package:equatable/equatable.dart';
import 'package:meta/meta.dart';

@immutable
class Settings extends Equatable {
  final int difficulty;

  Settings({required this.difficulty});

  @override
  List<Object> get props => [difficulty];

  Settings copyWith({int? difficulty}) {
    return Settings(difficulty: difficulty ?? this.difficulty);
  }
}
