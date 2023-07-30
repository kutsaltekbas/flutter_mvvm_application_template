// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'base_response_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

BaseResponseModel _$BaseResponseModelFromJson(Map<String, dynamic> json) =>
    BaseResponseModel(
      type: json['type'] as bool?,
      message: json['message'] as String?,
      data: json['data'],
      error: json['error'] == null
          ? null
          : BaseErrorResponseModel.fromJson(
              json['error'] as Map<String, dynamic>),
    );

Map<String, dynamic> _$BaseResponseModelToJson(BaseResponseModel instance) =>
    <String, dynamic>{
      'type': instance.type,
      'message': instance.message,
      'data': instance.data,
      'error': instance.error,
    };

BaseErrorResponseModel _$BaseErrorResponseModelFromJson(
        Map<String, dynamic> json) =>
    BaseErrorResponseModel(
      statusCode: json['statusCode'] as int?,
      description: json['description'] as String?,
    );

Map<String, dynamic> _$BaseErrorResponseModelToJson(
        BaseErrorResponseModel instance) =>
    <String, dynamic>{
      'statusCode': instance.statusCode,
      'description': instance.description,
    };
