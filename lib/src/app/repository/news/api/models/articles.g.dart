// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'articles.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Article _$ArticlesFromJson(Map<String, dynamic> json) {
  return Article(
    source: json['source'] == null ? null : Source.fromJson(json['source']),
    author: json['author'] as String?,
    title: json['title'] as String?,
    description: json['description'] as String?,
    url: json['url'] as String?,
    urlToImage: json['urlToImage'] as String?,
    publishedAt: json['publishedAt'] as String?,
    content: json['content'] as String?,
  );
}

Map<String, dynamic> _$ArticlesToJson(Article instance) => <String, dynamic>{
      'source': instance.source,
      'author': instance.author,
      'title': instance.title,
      'description': instance.description,
      'url': instance.url,
      'urlToImage': instance.urlToImage,
      'publishedAt': instance.publishedAt,
      'content': instance.content,
    };
