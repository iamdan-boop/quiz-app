// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'quiz.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Quiz _$QuizFromJson(Map<String, dynamic> json) => Quiz(
      id: json['id'] as int,
      quizName: json['quiz_name'] as String,
      quizDescription: json['quiz_description'] as String,
      questions: (json['questions'] as List<dynamic>?)
          ?.map((e) => Question.fromJson(e as Map<String, dynamic>))
          .toList(),
      points: json['points'] as int?,
    );

Map<String, dynamic> _$QuizToJson(Quiz instance) => <String, dynamic>{
      'id': instance.id,
      'quiz_name': instance.quizName,
      'quiz_description': instance.quizDescription,
      'points': instance.points,
      'questions': instance.questions,
    };
