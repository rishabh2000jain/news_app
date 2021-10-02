import 'package:json_annotation/json_annotation.dart';
import 'package:paper/src/app/repository/news/api/models/source.dart';

part 'articles.g.dart';

@JsonSerializable()
class Articles {
  Articles({
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

 factory Articles.fromJson(dynamic json) => _$ArticlesFromJson(json);

  //  {
  //   _source = json['source'] != null ? Source.fromJson(json['source']) : null;
  //   _author = json['author'];
  //   _title = json['title'];
  //   _description = json['description'];
  //   _url = json['url'];
  //   _urlToImage = json['urlToImage'];
  //   _publishedAt = json['publishedAt'];
  //   _content = json['content'];
  // }
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

  Map<String, dynamic> toJson() => _$ArticlesToJson(this);
// {
//   final map = <String, dynamic>{};
//   if (_source != null) {
//     map['source'] = _source?.toJson();
//   }
//   map['author'] = _author;
//   map['title'] = _title;
//   map['description'] = _description;
//   map['url'] = _url;
//   map['urlToImage'] = _urlToImage;
//   map['publishedAt'] = _publishedAt;
//   map['content'] = _content;
//   return map;
// }
}
