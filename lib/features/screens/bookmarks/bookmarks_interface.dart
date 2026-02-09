import 'package:get/get.dart';
import 'package:centernews/core/models/news_article.dart';

abstract class IBookmarkController extends GetxController {
  RxList<NewsArticle> get bookmarks;
}
