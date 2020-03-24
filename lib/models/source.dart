
import 'package:json_annotation/json_annotation.dart';
part 'source.g.dart';

@JsonSerializable()
class Source{
    final String id;
    final String name;
    final String description;
    final String url;
    final String category;
    final String language;
    final String country;

  Source({this.id, this.name, this.description, this.url, this.category, this.language, this.country});

    factory Source.fromJson(Map<String, dynamic> json) => _$SourceFromJson(json);

    Map<String, dynamic> toJson() => _$SourceToJson(this);

}