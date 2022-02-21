import 'package:equatable/equatable.dart';

abstract class QuizUserEvent extends Equatable {}

class GetQuizzes extends QuizUserEvent {
  @override
  List<Object?> get props => [];
}
