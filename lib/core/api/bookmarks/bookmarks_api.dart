import 'dart:async';

import 'package:centernews/core/constants/bookmark_constants.dart';
import 'package:centernews/core/models/news_article.dart';

/// Fake bookmarks API that mimics a network fetch for default bookmarks.
class BookmarksApi {
  const BookmarksApi._();

  static Future<List<NewsArticle>> fetchDefault({
    Duration latency = const Duration(milliseconds: 700),
  }) async {
    await Future.delayed(latency);
    return List<NewsArticle>.from(kDefaultBookmarks);
  }
}
