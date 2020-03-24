
import 'package:json_annotation/json_annotation.dart';
part 'source_response.g.dart';

@JsonSerializable()
class SourceResponse{

  final String status;
  final dynamic sources;

  SourceResponse({this.status, this.sources});

  factory SourceResponse.fromJson(Map<String, dynamic> json) => _$SourceResponseFromJson(json);

  Map<String, dynamic> toJson() => _$SourceResponseToJson(this);
}