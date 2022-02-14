import 'package:equatable/equatable.dart';
import 'package:formz/formz.dart';
import 'package:quiz_app/infrastructure/models/user.dart';

class LeaderboardState extends Equatable {
  const LeaderboardState({
    this.submissionStatus = FormzStatus.pure,
    this.leaderboards = const <User>[],
  });

  LeaderboardState copyWith({
    FormzStatus? submissionStatus,
    List<User>? leaderboards,
  }) {
    return LeaderboardState(
      submissionStatus: submissionStatus ?? this.submissionStatus,
      leaderboards: leaderboards ?? this.leaderboards,
    );
  }

  final FormzStatus submissionStatus;
  final List<User> leaderboards;

  @override
  List<Object?> get props => [
        leaderboards,
        submissionStatus,
      ];
}
