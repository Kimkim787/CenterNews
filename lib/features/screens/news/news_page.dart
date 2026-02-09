import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';
import 'package:centernews/core/configurations/routes.dart';
import 'package:centernews/core/error/error_messages.dart';
import 'package:centernews/features/screens/bookmarks/bookmarks_controller.dart';
import 'package:centernews/features/screens/bookmarks/bookmarks_interface.dart';
import 'package:centernews/features/screens/bookmarks/bookmarks_page.dart';
import 'package:centernews/features/screens/news/interface.dart';
import 'package:centernews/presentation/news_card.dart';
import 'package:centernews/presentation/search_input.dart';

class NewsPage extends GetView<INewsController> {
  const NewsPage({super.key});

  String _formatDate(DateTime date) {
    if (date.millisecondsSinceEpoch == 0) return 'Unknown date';
    return DateFormat.yMMMd().add_jm().format(date.toLocal());
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Latest News'),
        actions: [
          IconButton(
            icon: const Icon(Icons.bookmark),
            tooltip: 'Bookmarks',
            onPressed: () => Get.to(
              () => const BookmarksPage(),
              binding: BindingsBuilder(() {
                Get.lazyPut<IBookmarkController>(() => BookmarkController());
              }),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh),
            onPressed: controller.fetchLatest,
            tooltip: 'Refresh',
          ),
          IconButton(
            icon: const Icon(Icons.logout),
            tooltip: 'Sign out',
            onPressed: () => Get.offAllNamed(AppRoutes.login),
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }
        if (controller.errorMessage.isNotEmpty) {
          return Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Text(
                  controller.errorMessage.value,
                  style: const TextStyle(color: Colors.red),
                ),
                const SizedBox(height: 12),
                ElevatedButton(
                  onPressed: controller.fetchLatest,
                  child: const Text('Try again'),
                ),
              ],
            ),
          );
        }

        final items = controller.filteredArticles;
        if (items.isEmpty) {
          return const Center(child: Text(ErrorMessages.noArticlesMatch));
        }

        return Column(
          children: [
            Padding(
              padding: const EdgeInsets.fromLTRB(12, 12, 12, 4),
              child: SearchInput(
                hintText: 'Search news...',
                onChanged: controller.setQuery,
              ),
            ),
            Expanded(
              child: ListView.separated(
                padding: const EdgeInsets.fromLTRB(12, 8, 12, 12),
                itemCount: items.length,
                separatorBuilder: (_, __) => const SizedBox(height: 10),
                itemBuilder: (context, index) {
                  final article = items[index];
                  final isSelected =
                      controller.selectedArticle.value?.id == article.id;
                  return NewsCard(
                    article: article,
                    formattedDate: _formatDate(article.publishedAt),
                    selected: isSelected,
                    onTap: () {
                      controller.select(article);
                      Get.toNamed(AppRoutes.newsDetail, arguments: article);
                    },
                  );
                },
              ),
            ),
          ],
        );
      }),
    );
  }
}
