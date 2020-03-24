
import 'package:json_annotation/json_annotation.dart';
part 'article_response.g.dart';

@JsonSerializable()
class ArticleResponse{

  final String status;
  final int totalResults;
  final dynamic articles;

  ArticleResponse({this.status, this.totalResults, this.articles});

  factory ArticleResponse.fromJson(Map<String, dynamic> json) => _$ArticleResponseFromJson(json);

  Map<String, dynamic> toJson() => _$ArticleResponseToJson(this);
}