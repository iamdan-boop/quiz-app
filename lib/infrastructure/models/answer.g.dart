// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Answer _$AnswerFromJson(Map<String, dynamic> json) => Answer(
      id: json['id'] as int,
      answer: json['answer'] as String,
      isCorrect: json['is_correct'] as bool,
    );

Map<String, dynamic> _$AnswerToJson(Answer instance) => <String, dynamic>{
      'id': instance.id,
      'answer': instance.answer,
      'is_correct': instance.isCorrect,
    };
