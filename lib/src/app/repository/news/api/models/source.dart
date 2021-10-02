import 'package:json_annotation/json_annotation.dart';
part 'source.g.dart';
@JsonSerializable()
class Source {
  Source({
    dynamic id,
    String? name,
  }) {
    _id = id;
    _name = name;
  }

  Source.fromJson(dynamic json) {
    _id = json['id'];
    _name = json['name'];
  }

  @JsonKey(name: 'id')
  dynamic _id;
  @JsonKey(name: 'name')
  String? _name;

  dynamic get id => _id;

  String? get name => _name;

  Map<String, dynamic> toJson() {
    final map = <String, dynamic>{};
    map['id'] = _id;
    map['name'] = _name;
    return map;
  }
}

/// source : {"id":null,"name":"Nintendo Life"}
/// author : "Liam Doolan"
/// title : "It's Official, Super Nintendo World Is Getting A Donkey Kong Expansion - Nintendo Life"
/// description : "\"Set to open in 2024\""
/// url : "https://www.nintendolife.com/news/2021/09/its_official_super_nintendo_world_is_getting_a_donkey_kong_expansion"
/// urlToImage : "https://images.nintendolife.com/660cdbcd47731/1280x720.jpg"
/// publishedAt : "2021-09-28T05:25:00Z"
/// content : "Image: Universal Studios / Nintendo\r\nIt seems the worst kept secret has finally been confirmed - Super Nintendo World is getting a Donkey Kong-themed \"expansion\" and it's set to open in 2024.\r\nAccord… [+1268 chars]"

/// id : null
/// name : "Nintendo Life"
