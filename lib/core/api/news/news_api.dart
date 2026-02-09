import 'dart:convert';

import 'package:http/http.dart' as http;
import 'package:centernews/core/models/news_article.dart';

/// Simple client for the public Spaceflight News API (no API key required).
class NewsApi {
  const NewsApi._();

  static const String _baseUrl =
      'https://api.spaceflightnewsapi.net/v4/articles';

  /// Fetch the latest articles, ordered by publish date desc.
  static Future<List<NewsArticle>> fetchLatest({int limit = 20}) async {
    final uri = Uri.parse('$_baseUrl/?limit=$limit&ordering=-published_at');
    final response = await http.get(uri);

    if (response.statusCode != 200) {
      throw Exception('News API error ${response.statusCode}');
    }

    final Map<String, dynamic> body =
        json.decode(response.body) as Map<String, dynamic>;
    final results = body['results'] as List<dynamic>? ?? [];

    return results
        .map((item) => NewsArticle.fromJson(item as Map<String, dynamic>))
        .toList();
  }
}


