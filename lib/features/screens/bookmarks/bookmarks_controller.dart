import 'package:centernews/core/constants/bookmark_constants.dart';
import 'package:centernews/core/models/news_article.dart';
import 'package:get/get.dart';

import 'bookmarks_interface.dart';

class BookmarkController extends IBookmarkController {
  BookmarkController() {
    bookmarks.assignAll(kDefaultBookmarks);
  }

  @override
  final RxList<NewsArticle> bookmarks = <NewsArticle>[].obs;
}
