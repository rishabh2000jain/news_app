import 'package:json_annotation/json_annotation.dart';
import 'package:paper/src/app/repository/news/api/models/source.dart';

part 'articles.g.dart';

@JsonSerializable()
class Article {
  Article({
    Source? source,
    String? author,
    String? title,
    String? description,
    String? url,
    String? urlToImage,
    String? publishedAt,
    String? content,
  }) {
    _source = source;
    _author = author;
    _title = title;
    _description = description;
    _url = url;
    _urlToImage = urlToImage;
    _publishedAt = publishedAt;
    _content = content;
  }

 factory Article.fromJson(dynamic json) => _$ArticleFromJson(json);

  @JsonKey(name: 'source')
  Source? _source;
  @JsonKey(name: 'author')
  String? _author;
  @JsonKey(name: 'title')
  String? _title;
  @JsonKey(name: 'description')
  String? _description;
  @JsonKey(name: 'url')
  String? _url;
  @JsonKey(name: 'urlToImage')
  String? _urlToImage;
  @JsonKey(name: 'publishedAt')
  String? _publishedAt;
  @JsonKey(name: 'content')
  String? _content;

  Source? get source => _source;

  String? get author => _author;

  String? get title => _title;

  String? get description => _description;

  String? get url => _url;

  String? get urlToImage => _urlToImage;

  String? get publishedAt => _publishedAt;

  String? get content => _content;

  Map<String, dynamic> toJson() => _$ArticleToJson(this);

}
