import 'package:get/get.dart';
import 'package:centernews/core/models/news_article.dart';

abstract class IBookmarkController extends GetxController {
  RxList<NewsArticle> get bookmarks;
  RxBool get isLoading;
  RxString get errorMessage;

  Future<void> loadBookmarks();
}
