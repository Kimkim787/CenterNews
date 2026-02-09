import 'package:get/get.dart';
import 'package:centernews/core/models/news_article.dart';

abstract class INewsController extends GetxController {
  RxList<NewsArticle> get articles;
  RxBool get isLoading;
  RxString get errorMessage;
  Rxn<NewsArticle> get selectedArticle;
  RxString get searchQuery;
  List<NewsArticle> get filteredArticles;

  Future<void> fetchLatest();
  void select(NewsArticle article);
  void setQuery(String value);
}


