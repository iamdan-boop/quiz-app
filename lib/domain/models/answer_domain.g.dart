// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'answer_domain.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AnswerDomain _$AnswerDomainFromJson(Map<String, dynamic> json) => AnswerDomain(
      json['answer'] as String,
      json['is_correct'] as bool,
    );

Map<String, dynamic> _$AnswerDomainToJson(AnswerDomain instance) =>
    <String, dynamic>{
      'answer': instance.answer,
      'is_correct': instance.isCorrect,
    };
