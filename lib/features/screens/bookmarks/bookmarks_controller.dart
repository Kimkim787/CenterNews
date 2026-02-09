import 'package:centernews/core/api/bookmarks/bookmarks_api.dart';
import 'package:centernews/core/error/error_messages.dart';
import 'package:centernews/core/models/news_article.dart';
import 'package:get/get.dart';

import 'bookmarks_interface.dart';

class BookmarkController extends IBookmarkController {
  @override
  final RxList<NewsArticle> bookmarks = <NewsArticle>[].obs;

  @override
  final RxBool isLoading = false.obs;

  @override
  final RxString errorMessage = ''.obs;

  @override
  void onInit() {
    super.onInit();
    loadBookmarks();
  }

  @override
  Future<void> loadBookmarks() async {
    isLoading.value = true;
    errorMessage.value = '';
    try {
      final items = await BookmarksApi.fetchDefault();
      bookmarks.assignAll(items);
    } catch (_) {
      errorMessage.value = ErrorMessages.bookmarksLoadFailed;
    } finally {
      isLoading.value = false;
    }
  }
}
