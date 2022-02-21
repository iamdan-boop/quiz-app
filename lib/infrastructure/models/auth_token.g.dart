// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'auth_token.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

AuthToken _$AuthTokenFromJson(Map<String, dynamic> json) => AuthToken(
      authToken: json['authToken'] as String,
      name: json['name'] as String,
      isAdmin: json['is_admin'] as bool,
    );

Map<String, dynamic> _$AuthTokenToJson(AuthToken instance) => <String, dynamic>{
      'authToken': instance.authToken,
      'name': instance.name,
      'is_admin': instance.isAdmin,
    };
