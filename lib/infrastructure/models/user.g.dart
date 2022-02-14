// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'user.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

User _$UserFromJson(Map<String, dynamic> json) => User(
      id: json['id'] as int,
      name: json['name'] as String,
      email: json['email'] as String,
      quizzes: (json['quizzes'] as List<dynamic>?)
          ?.map((e) => Quiz.fromJson(e as Map<String, dynamic>))
          .toList(),
      points: json['points'] as int?,
    );

Map<String, dynamic> _$UserToJson(User instance) => <String, dynamic>{
      'id': instance.id,
      'name': instance.name,
      'email': instance.email,
      'points': instance.points,
      'quizzes': instance.quizzes,
    };
