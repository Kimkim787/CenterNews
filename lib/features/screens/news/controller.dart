import 'package:get/get.dart';
import 'package:centernews/core/api/news/news_api.dart';
import 'package:centernews/core/error/error_messages.dart';
import 'package:centernews/core/models/news_article.dart';

import 'interface.dart';

class NewsController extends INewsController {
  @override
  final RxList<NewsArticle> articles = <NewsArticle>[].obs;

  @override
  final RxBool isLoading = false.obs;

  @override
  final RxString errorMessage = ''.obs;

  @override
  final Rxn<NewsArticle> selectedArticle = Rxn<NewsArticle>();

  @override
  final RxString searchQuery = ''.obs;

  @override
  void onInit() {
    super.onInit();
    fetchLatest();
  }

  @override
  List<NewsArticle> get filteredArticles {
    final q = searchQuery.value.trim().toLowerCase();
    if (q.isEmpty) return articles;
    return articles
        .where((a) =>
            a.title.toLowerCase().contains(q) ||
            a.summary.toLowerCase().contains(q))
        .toList();
  }

  @override
  Future<void> fetchLatest() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final latest = await NewsApi.fetchLatest(limit: 25);
      articles.assignAll(latest);
      // Clear selection if it no longer exists.
      if (selectedArticle.value != null &&
          !articles.any((a) => a.id == selectedArticle.value!.id)) {
        selectedArticle.value = null;
      }
    } catch (e) {
      errorMessage.value = ErrorMessages.newsLoadFailed;
    } finally {
      isLoading.value = false;
    }
  }

  @override
  void select(NewsArticle article) {
    selectedArticle.value = article;
    Get.snackbar(
      'Selected',
      article.title,
      snackPosition: SnackPosition.BOTTOM,
      duration: const Duration(seconds: 2),
    );
  }

  @override
  void setQuery(String value) {
    searchQuery.value = value;
  }
}


