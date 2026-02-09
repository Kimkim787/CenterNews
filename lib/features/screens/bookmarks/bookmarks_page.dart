import 'package:centernews/core/configurations/routes.dart';
import 'package:centernews/features/screens/bookmarks/bookmarks_interface.dart';
import 'package:centernews/presentation/news_card.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

class BookmarksPage extends GetView<IBookmarkController> {
  const BookmarksPage({super.key});

  String _formatDate(DateTime date) =>
      DateFormat.yMMMd().add_jm().format(date.toLocal());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Bookmarked News'),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Get.back(),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.home),
            tooltip: 'Back to latest',
            onPressed: () => Get.offAllNamed(AppRoutes.news),
          ),
        ],
      ),
      body: Obx(() {
        final items = controller.bookmarks;
        if (items.isEmpty) {
          return const Center(child: Text('No bookmarks yet.'));
        }
        return ListView.separated(
          padding: const EdgeInsets.all(12),
          itemCount: items.length,
          separatorBuilder: (_, __) => const SizedBox(height: 10),
          itemBuilder: (context, index) {
            final article = items[index];
            return NewsCard(
              article: article,
              formattedDate: _formatDate(article.publishedAt),
              selected: false,
              onTap: () => Get.toNamed(AppRoutes.newsDetail, arguments: article),
            );
          },
        );
      }),
    );
  }
}
