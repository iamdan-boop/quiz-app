import 'package:json_annotation/json_annotation.dart';
import 'package:quiz_app/infrastructure/models/quiz.dart';

part 'user.g.dart';

@JsonSerializable()
class User {
  const User({
    required this.id,
    required this.name,
    required this.email,
    required this.isAdmin,
    this.quizzes,
    this.points,
  });

  factory User.fromJson(Map<String, dynamic> json) => _$UserFromJson(json);

  final int id;
  final String name;
  final String email;
  @JsonKey(name: 'is_admin')
  final bool isAdmin;
  final int? points;
  final List<Quiz>? quizzes;
}
