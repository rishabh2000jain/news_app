import 'package:json_annotation/json_annotation.dart';

import 'articles.dart';
part 'news_response.g.dart';
/// status : "ok"
/// totalResults : 38
/// articles : [{"source":{"id":null,"name":"Nintendo Life"},"author":"Liam Doolan","title":"It's Official, Super Nintendo World Is Getting A Donkey Kong Expansion - Nintendo Life","description":"\"Set to open in 2024\"","url":"https://www.nintendolife.com/news/2021/09/its_official_super_nintendo_world_is_getting_a_donkey_kong_expansion","urlToImage":"https://images.nintendolife.com/660cdbcd47731/1280x720.jpg","publishedAt":"2021-09-28T05:25:00Z","content":"Image: Universal Studios / Nintendo\r\nIt seems the worst kept secret has finally been confirmed - Super Nintendo World is getting a Donkey Kong-themed \"expansion\" and it's set to open in 2024.\r\nAccord… [+1268 chars]"},null]
@JsonSerializable()
class NewsResponse {
  NewsResponse({
    String? status,
    int? totalResults,
    List<Article>? articles,
  }) {
    _status = status;
    _totalResults = totalResults;
    _articles = articles;
  }

  factory NewsResponse.fromJson(dynamic json) =>_$NewsResponseFromJson(json);
  // {
  //   _status = json['status'];
  //   _totalResults = json['totalResults'];
  //   if (json['articles'] != null) {
  //     _articles = [];
  //     json['articles'].forEach((v) {
  //       _articles?.add(Articles.fromJson(v));
  //     });
  //   }
  // }

  @JsonKey(name: 'status')
  String? _status;
  @JsonKey(name: 'totalResults')
  int? _totalResults;
  @JsonKey(name: 'articles')
  List<Article>? _articles;

  String? get status => _status;

  int? get totalResults => _totalResults;

  List<Article>? get articles => _articles;

  Map<String, dynamic> toJson()=>_$NewsResponseToJson(this);
  // {
  //   final map = <String, dynamic>{};
  //   map['status'] = _status;
  //   map['totalResults'] = _totalResults;
  //   if (_articles != null) {
  //     map['articles'] = _articles?.map((v) => v.toJson()).toList();
  //   }
  //   return map;
  // }
}
