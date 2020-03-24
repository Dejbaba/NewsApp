// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'source_response.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

SourceResponse _$SourceResponseFromJson(Map<String, dynamic> json) {
  return SourceResponse(
    status: json['status'] as String,
    sources: json['sources'],
  );
}

Map<String, dynamic> _$SourceResponseToJson(SourceResponse instance) =>
    <String, dynamic>{
      'status': instance.status,
      'sources': instance.sources,
    };
